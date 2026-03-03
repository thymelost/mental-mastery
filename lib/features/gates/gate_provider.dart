import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../content/gates/all_gates.dart';
import '../../content/gates/gate_model.dart';
import '../../core/database/app_database.dart';
import '../../core/database/drift_provider.dart';
import '../../services/gate_evaluator/gate_evaluator_service.dart';
import '../../services/stats/stats_provider.dart';

// ─── State ────────────────────────────────────────────────────────────────────

@immutable
class GateEvalState {
  const GateEvalState({
    required this.gateNumber,
    this.autoResults = const [],
    this.confirmedIds = const {},
    this.evaluating = false,
    this.submitting = false,
    this.submitted = false,
    this.passed = false,
    this.attemptNumber = 1,
    this.error,
  });

  final int gateNumber;
  final List<CriterionEvalResult> autoResults;

  /// Criterion ids explicitly confirmed by the user (manual + semiAuto).
  final Set<String> confirmedIds;

  final bool evaluating;
  final bool submitting;
  final bool submitted;
  final bool passed;
  final int attemptNumber;
  final String? error;

  GateDefinition get definition => gateForNumber(gateNumber);

  /// True if any blocking criterion has autoStatus == fail.
  bool get hasHardBlock {
    for (final result in autoResults) {
      if (result.autoStatus == CriterionAutoStatus.fail) {
        final criterion = definition.criteria.firstWhere(
          (c) => c.id == result.criterionId,
          orElse: () => const GateCriterion(
            id: '',
            description: '',
            track: '',
            domain: '',
            criterionType: GateCriterionType.manual,
          ),
        );
        if (criterion.blockingIfFailed) return true;
      }
    }
    return false;
  }

  /// True when all criteria are satisfied and no hard block is active.
  bool get allSatisfied {
    if (hasHardBlock) return false;
    for (final criterion in definition.criteria) {
      final result = autoResults.firstWhere(
        (r) => r.criterionId == criterion.id,
        orElse: () => CriterionEvalResult(
          criterionId: criterion.id,
          autoStatus: CriterionAutoStatus.notEvaluated,
        ),
      );
      switch (criterion.criterionType) {
        case GateCriterionType.auto:
          if (result.autoStatus != CriterionAutoStatus.pass) return false;
        case GateCriterionType.semiAuto:
        case GateCriterionType.manual:
          if (!confirmedIds.contains(criterion.id)) return false;
      }
    }
    return true;
  }

  GateEvalState copyWith({
    List<CriterionEvalResult>? autoResults,
    Set<String>? confirmedIds,
    bool? evaluating,
    bool? submitting,
    bool? submitted,
    bool? passed,
    int? attemptNumber,
    String? error,
  }) {
    return GateEvalState(
      gateNumber: gateNumber,
      autoResults: autoResults ?? this.autoResults,
      confirmedIds: confirmedIds ?? this.confirmedIds,
      evaluating: evaluating ?? this.evaluating,
      submitting: submitting ?? this.submitting,
      submitted: submitted ?? this.submitted,
      passed: passed ?? this.passed,
      attemptNumber: attemptNumber ?? this.attemptNumber,
      error: error,
    );
  }
}

// ─── Notifier ─────────────────────────────────────────────────────────────────

class GateNotifier extends StateNotifier<GateEvalState> {
  GateNotifier(this._ref, int gateNumber)
      : super(GateEvalState(gateNumber: gateNumber));

  final Ref _ref;

  AppDatabase get _db => _ref.read(appDatabaseProvider);

  GateEvaluatorService get _evaluator =>
      GateEvaluatorService(_db);

  /// Loads the current attempt number from the DB, then runs auto evaluation.
  Future<void> initialize() async {
    // Ensure gate state row exists.
    await _db.gateStatesDao.ensureAllGatesInitialized();

    final gateState =
        await _db.gateStatesDao.getGateState(state.gateNumber);
    final attempt = (gateState?.attemptCount ?? 0) + 1;

    state = state.copyWith(evaluating: true, attemptNumber: attempt);
    try {
      final results = await _evaluator.evaluate(state.gateNumber);
      state = state.copyWith(autoResults: results, evaluating: false);
    } catch (e) {
      state = state.copyWith(
        evaluating: false,
        error: 'Evaluation error: $e',
      );
    }
  }

  void toggleConfirm(String criterionId) {
    final updated = Set<String>.from(state.confirmedIds);
    if (updated.contains(criterionId)) {
      updated.remove(criterionId);
    } else {
      updated.add(criterionId);
    }
    state = state.copyWith(confirmedIds: updated);
  }

  /// Submits the gate assessment. Writes results to DB and, on pass, advances
  /// the user's phase.
  Future<void> submit() async {
    if (state.submitting) return;
    state = state.copyWith(submitting: true, error: null);

    try {
      final gate = state.definition;
      final passed = state.allSatisfied;
      final now = DateTime.now();
      final attempt = state.attemptNumber;

      // Write gate_states row.
      await _db.gateStatesDao.updateGateState(
        state.gateNumber,
        GateStatesTableCompanion(
          status: Value(passed ? 'passed' : 'failed_retry'),
          attemptCount: Value(attempt),
          lastAttemptedAt: Value(now),
          passedAt: passed ? Value(now) : const Value.absent(),
          blockReason: passed
              ? const Value.absent()
              : Value(_buildBlockReason()),
          // L2→L3 gate extras.
          phq9AtGate: state.gateNumber == 7
              ? Value(_getPHQ9Score())
              : const Value.absent(),
          crisisIndicatorsClear: state.gateNumber == 7
              ? Value(state.confirmedIds.contains('g7_crisis'))
              : const Value.absent(),
        ),
      );

      // Write gate_criteria_states rows.
      final criteriaRows = gate.criteria.map((c) {
        final autoResult = state.autoResults.firstWhere(
          (r) => r.criterionId == c.id,
          orElse: () => CriterionEvalResult(
            criterionId: c.id,
            autoStatus: CriterionAutoStatus.notEvaluated,
          ),
        );
        String status;
        switch (c.criterionType) {
          case GateCriterionType.auto:
            status = autoResult.autoStatus == CriterionAutoStatus.pass
                ? 'auto_pass'
                : 'auto_fail';
          case GateCriterionType.semiAuto:
          case GateCriterionType.manual:
            status = state.confirmedIds.contains(c.id)
                ? 'manual_checked'
                : 'pending';
        }
        return GateCriteriaStatesTableCompanion.insert(
          gateNumber: state.gateNumber,
          criterionId: c.id,
          track: c.track,
          domain: c.domain,
          status: Value(status),
          value: Value(autoResult.displayValue),
          evaluatedAt: Value(now),
          attemptNumber: Value(attempt),
        );
      }).toList();

      await _db.gateCriteriaStatesDao.insertCriteriaStates(criteriaRows);

      // Advance phase on pass.
      if (passed) {
        // Read start date before completing the phase (for duration calc).
        final fromPhaseRow = await _db.phaseProgressDao.getPhaseByNumber(gate.fromPhase);
        await _db.phaseProgressDao.completePhase(gate.fromPhase);
        await _db.phaseProgressDao.activatePhase(gate.toPhase);
        await _db.userStateDao.setCurrentPhase(gate.toPhase);

        // Enqueue anonymous stats (fire-and-forget).
        final metCount = criteriaRows
            .where((r) =>
                r.status.value == 'auto_pass' ||
                r.status.value == 'manual_checked')
            .length;
        enqueueAndSubmit(
          extractor: _ref.read(statsExtractorProvider),
          submitter: _ref.read(statsSubmitterProvider),
          enqueue: (e) async {
            await e.enqueueGatePassage(
              gateNumber: state.gateNumber,
              passed: true,
              attemptCount: attempt,
              criteriaMetCount: metCount,
              criteriaTotal: gate.criteria.length,
            );
            if (fromPhaseRow != null) {
              await e.enqueuePhaseTransition(
                fromPhase: gate.fromPhase,
                toPhase: gate.toPhase,
                fromPhaseStartedAt: fromPhaseRow.startedAt,
              );
            }
          },
        ).ignore();
      } else {
        // Enqueue failed gate attempt stat.
        final metCount = criteriaRows
            .where((r) =>
                r.status.value == 'auto_pass' ||
                r.status.value == 'manual_checked')
            .length;
        enqueueAndSubmit(
          extractor: _ref.read(statsExtractorProvider),
          submitter: _ref.read(statsSubmitterProvider),
          enqueue: (e) => e.enqueueGatePassage(
            gateNumber: state.gateNumber,
            passed: false,
            attemptCount: attempt,
            criteriaMetCount: metCount,
            criteriaTotal: gate.criteria.length,
          ),
        ).ignore();
      }

      state = state.copyWith(
        submitting: false,
        submitted: true,
        passed: passed,
      );
    } catch (e) {
      state = state.copyWith(
        submitting: false,
        error: 'Submit failed: $e',
      );
    }
  }

  String _buildBlockReason() {
    final unmet = <String>[];
    for (final c in state.definition.criteria) {
      if (c.criterionType == GateCriterionType.auto) {
        final r = state.autoResults.firstWhere(
          (r) => r.criterionId == c.id,
          orElse: () => CriterionEvalResult(
            criterionId: c.id,
            autoStatus: CriterionAutoStatus.noData,
          ),
        );
        if (r.autoStatus != CriterionAutoStatus.pass) {
          unmet.add(c.id);
        }
      } else {
        if (!state.confirmedIds.contains(c.id)) unmet.add(c.id);
      }
    }
    return 'Unmet: ${unmet.join(', ')}';
  }

  int? _getPHQ9Score() {
    final r = state.autoResults.firstWhere(
      (r) => r.criterionId == 'g7_phq9',
      orElse: () => const CriterionEvalResult(
        criterionId: '',
        autoStatus: CriterionAutoStatus.noData,
      ),
    );
    if (r.displayValue == null) return null;
    // Extract numeric score from display value "Score: 7  (need ≤ 9)"
    final match = RegExp(r'Score: (\d+)').firstMatch(r.displayValue!);
    return match != null ? int.tryParse(match.group(1)!) : null;
  }
}

// ─── Providers ────────────────────────────────────────────────────────────────

/// Parameterized provider: one notifier per gate number.
final gateNotifierProvider = StateNotifierProvider.family<GateNotifier,
    GateEvalState, int>(
  (ref, gateNumber) => GateNotifier(ref, gateNumber),
);

/// Stream of gate state rows from the DB (for the phase journey + gate screens).
final allGateStatesProvider =
    StreamProvider<List<GateStatesTableData>>((ref) {
  return ref.watch(appDatabaseProvider).gateStatesDao.watchAllGateStates();
});

/// Single gate state row from the DB, by gate number.
final gateStateProvider =
    StreamProvider.family<GateStatesTableData?, int>((ref, gateNumber) {
  return ref
      .watch(appDatabaseProvider)
      .gateStatesDao
      .watchGateState(gateNumber);
});

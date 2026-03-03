import 'dart:convert';

import '../../content/gates/gate_model.dart';
import '../../content/gates/all_gates.dart';
import '../../core/database/app_database.dart';

// ─── Result types ─────────────────────────────────────────────────────────────

enum CriterionAutoStatus {
  /// Auto check passed.
  pass,

  /// Auto check failed (score below/above threshold).
  fail,

  /// Assessment has not been administered yet.
  noData,

  /// SemiAuto: no auto data; requires explicit user confirmation.
  requiresConfirmation,

  /// Manual criterion: not evaluated by this service.
  notEvaluated,
}

class CriterionEvalResult {
  const CriterionEvalResult({
    required this.criterionId,
    required this.autoStatus,
    this.displayValue,
  });

  final String criterionId;
  final CriterionAutoStatus autoStatus;

  /// Human-readable value shown alongside the criterion in the UI.
  /// e.g. "Score: 72  (threshold: ≥ 70)" or "Not yet administered".
  final String? displayValue;
}

// ─── Service ─────────────────────────────────────────────────────────────────

/// Evaluates all auto and semiAuto criteria for a gate.
///
/// Manual criteria are returned with [CriterionAutoStatus.notEvaluated] —
/// they require user confirmation in the UI and are not assessed here.
///
/// SemiAuto criteria (currently only g7_crisis) are returned with
/// [CriterionAutoStatus.requiresConfirmation] — the user must explicitly
/// acknowledge them regardless of any computed data.
class GateEvaluatorService {
  const GateEvaluatorService(this._db);
  final AppDatabase _db;

  Future<List<CriterionEvalResult>> evaluate(int gateNumber) async {
    final gate = gateForNumber(gateNumber);
    final results = <CriterionEvalResult>[];

    for (final criterion in gate.criteria) {
      switch (criterion.criterionType) {
        case GateCriterionType.manual:
          results.add(CriterionEvalResult(
            criterionId: criterion.id,
            autoStatus: CriterionAutoStatus.notEvaluated,
          ));
        case GateCriterionType.semiAuto:
          results.add(CriterionEvalResult(
            criterionId: criterion.id,
            autoStatus: CriterionAutoStatus.requiresConfirmation,
          ));
        case GateCriterionType.auto:
          results.add(await _evaluateAuto(criterion));
      }
    }

    return results;
  }

  Future<CriterionEvalResult> _evaluateAuto(GateCriterion criterion) async {
    final assessmentId = criterion.assessmentId;
    if (assessmentId == null) {
      return CriterionEvalResult(
        criterionId: criterion.id,
        autoStatus: CriterionAutoStatus.noData,
        displayValue: 'No assessment configured',
      );
    }

    // Special: FFMQ improvement (compares latest vs. earliest; no fixed threshold).
    if (assessmentId == 'FFMQ' && criterion.threshold == null) {
      return _evaluateFfmqImprovement(criterion.id);
    }

    // Special: B8 Condition D existence check (no fixed threshold).
    if (assessmentId == 'B8' && criterion.threshold == null) {
      return _evaluateB8CondDExists(criterion.id);
    }

    final threshold = criterion.threshold;
    if (threshold == null) {
      return CriterionEvalResult(
        criterionId: criterion.id,
        autoStatus: CriterionAutoStatus.noData,
        displayValue: 'No threshold defined',
      );
    }

    final latest =
        await _db.assessmentResultsDao.getLatestResult(assessmentId);
    if (latest == null || latest.totalScore == null) {
      return CriterionEvalResult(
        criterionId: criterion.id,
        autoStatus: CriterionAutoStatus.noData,
        displayValue: 'Not yet administered',
      );
    }

    final score = latest.totalScore!;
    final lowerBetter = _isLowerBetter(assessmentId);
    final passed = lowerBetter ? score <= threshold : score >= threshold;
    final dir = lowerBetter ? '≤' : '≥';

    return CriterionEvalResult(
      criterionId: criterion.id,
      autoStatus:
          passed ? CriterionAutoStatus.pass : CriterionAutoStatus.fail,
      displayValue:
          'Score: ${score.toStringAsFixed(0)}  (need $dir ${threshold.toStringAsFixed(0)})',
    );
  }

  Future<CriterionEvalResult> _evaluateFfmqImprovement(
    String criterionId,
  ) async {
    // getResultsForAssessment returns newest first.
    final results =
        await _db.assessmentResultsDao.getResultsForAssessment('FFMQ');
    if (results.length < 2) {
      return CriterionEvalResult(
        criterionId: criterionId,
        autoStatus: CriterionAutoStatus.noData,
        displayValue: 'Need ≥ 2 FFMQ scores to compare',
      );
    }
    final baseline = results.last.totalScore;
    final latest = results.first.totalScore;
    if (baseline == null || latest == null) {
      return CriterionEvalResult(
        criterionId: criterionId,
        autoStatus: CriterionAutoStatus.noData,
      );
    }
    return CriterionEvalResult(
      criterionId: criterionId,
      autoStatus:
          latest > baseline ? CriterionAutoStatus.pass : CriterionAutoStatus.fail,
      displayValue:
          'Baseline: ${baseline.toStringAsFixed(0)}, Latest: ${latest.toStringAsFixed(0)}',
    );
  }

  Future<CriterionEvalResult> _evaluateB8CondDExists(
    String criterionId,
  ) async {
    final results =
        await _db.assessmentResultsDao.getResultsForAssessment('B8');
    final hasCondD = results.any((r) {
      try {
        final raw = jsonDecode(r.rawScores) as Map<String, dynamic>;
        return raw.containsKey('condD') && raw['condD'] != null;
      } catch (_) {
        return false;
      }
    });
    return CriterionEvalResult(
      criterionId: criterionId,
      autoStatus:
          hasCondD ? CriterionAutoStatus.pass : CriterionAutoStatus.fail,
      displayValue: hasCondD
          ? 'Condition D assessment found'
          : 'No Condition D assessment on record',
    );
  }

  /// True for instruments where a lower score is better (PHQ-9, TAS-20, etc.).
  bool _isLowerBetter(String assessmentId) {
    return const {'PHQ9', 'TAS20', 'DASS21', 'RRS'}.contains(assessmentId);
  }
}

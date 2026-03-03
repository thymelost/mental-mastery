import 'dart:async';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/drift_provider.dart';
import '../../core/database/app_database.dart';
import '../../content/practices/practice_model.dart';
import '../../content/practices/all_practices.dart';
import '../../services/stats/stats_provider.dart';

// ─── Safety display mode ─────────────────────────────────────────────────────

/// Which safety UI to show before a practice session starts.
///
/// - [fullPage]     — first session ever, or Layer 2/3 after a ≥14-day gap.
/// - [summaryCard]  — compact one-tap card for repeat sessions.
/// - [observational] — "no stop criteria" flash card (signals list is empty).
enum SafetyDisplayMode { fullPage, summaryCard, observational }

/// Computes the correct [SafetyDisplayMode] for a given practice ID.
final safetyDisplayModeProvider =
    FutureProvider.family<SafetyDisplayMode, String>((ref, practiceId) async {
  final practice = practiceById(practiceId);
  if (practice == null) return SafetyDisplayMode.fullPage;

  // No stop criteria → observational flash card every session.
  if (practice.safetySignals.isEmpty) return SafetyDisplayMode.observational;

  final db = ref.read(appDatabaseProvider);
  final last =
      await db.practiceSessionsDao.getLastCompletedSession(practiceId);

  // No prior completed session → first-time full page.
  if (last == null) return SafetyDisplayMode.fullPage;

  // Layer 2/3 (phase >= 5): re-show full page after ≥14-day gap.
  if (practice.phaseNumber >= 5) {
    final daysSince = DateTime.now().difference(last.startedAt).inDays;
    if (daysSince >= 14) return SafetyDisplayMode.fullPage;
  }

  return SafetyDisplayMode.summaryCard;
});

// ─── Practice lookup ────────────────────────────────────────────────────────

/// Returns PracticeContent by id, or null if not found.
PracticeContent? practiceById(String id) {
  try {
    return kPractices.firstWhere((p) => p.id == id);
  } catch (_) {
    return null;
  }
}

/// Provider: all practices for the current phase, grouped by schedule slot.
final practicesForPhaseProvider =
    Provider.family<List<PracticeContent>, int>((ref, phaseNumber) {
  return kPractices
      .where((p) => p.phaseNumber == phaseNumber)
      .toList();
});

// ─── Session state ──────────────────────────────────────────────────────────

enum SessionStatus { idle, safetyCheck, running, paused, complete }

@immutable
class SessionState {
  const SessionState({
    this.status = SessionStatus.idle,
    this.practiceId,
    this.dbRowId,
    this.startedAt,
    this.elapsedSeconds = 0,
    this.driftCount = 0,
    this.driftTimestamps = const [],
    this.arousalBefore,
    this.arousalAfter,
    this.qualityScore,
    this.notesText,
    this.safetyAcknowledged = false,
  });

  final SessionStatus status;
  final String? practiceId;
  final int? dbRowId;
  final DateTime? startedAt;
  final int elapsedSeconds;
  final int driftCount;
  final List<int> driftTimestamps; // seconds from session start
  final double? arousalBefore;
  final double? arousalAfter;
  // I1.4 Practice Quality Monitoring: 0–1 behavioral relevance score.
  // Collected at Phase 7+ only.
  final double? qualityScore;
  final String? notesText;
  final bool safetyAcknowledged;

  int get durationMinutesTarget =>
      practiceById(practiceId ?? '')?.durationMinutes ?? 0;

  SessionState copyWith({
    SessionStatus? status,
    String? practiceId,
    int? dbRowId,
    DateTime? startedAt,
    int? elapsedSeconds,
    int? driftCount,
    List<int>? driftTimestamps,
    double? arousalBefore,
    double? arousalAfter,
    double? qualityScore,
    String? notesText,
    bool? safetyAcknowledged,
  }) {
    return SessionState(
      status: status ?? this.status,
      practiceId: practiceId ?? this.practiceId,
      dbRowId: dbRowId ?? this.dbRowId,
      startedAt: startedAt ?? this.startedAt,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      driftCount: driftCount ?? this.driftCount,
      driftTimestamps: driftTimestamps ?? this.driftTimestamps,
      arousalBefore: arousalBefore ?? this.arousalBefore,
      arousalAfter: arousalAfter ?? this.arousalAfter,
      qualityScore: qualityScore ?? this.qualityScore,
      notesText: notesText ?? this.notesText,
      safetyAcknowledged: safetyAcknowledged ?? this.safetyAcknowledged,
    );
  }
}

class SessionNotifier extends StateNotifier<SessionState> {
  SessionNotifier(this._ref) : super(const SessionState());

  final Ref _ref;
  Timer? _timer;
  int _phaseNumber = 0;

  void beginSafetyCheck(String practiceId) {
    state = SessionState(
      status: SessionStatus.safetyCheck,
      practiceId: practiceId,
    );
  }

  void acknowledgeSafety() {
    state = state.copyWith(safetyAcknowledged: true);
  }

  Future<void> startSession({required int phaseNumber}) async {
    _phaseNumber = phaseNumber;
    final practiceId = state.practiceId;
    if (practiceId == null) return;

    final now = DateTime.now();
    final db = _ref.read(appDatabaseProvider);
    final rowId = await db.practiceSessionsDao.insertSession(
      PracticeSessionsTableCompanion.insert(
        practiceId: practiceId,
        phaseNumber: phaseNumber,
        startedAt: now,
        safetyAcknowledged: Value(state.safetyAcknowledged),
        arousalBefore: state.arousalBefore != null
            ? Value(state.arousalBefore!)
            : const Value.absent(),
      ),
    );

    state = state.copyWith(
      status: SessionStatus.running,
      dbRowId: rowId,
      startedAt: now,
      elapsedSeconds: 0,
    );

    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.status == SessionStatus.running) {
        state = state.copyWith(elapsedSeconds: state.elapsedSeconds + 1);
      }
    });
  }

  void pauseSession() {
    _timer?.cancel();
    state = state.copyWith(status: SessionStatus.paused);
  }

  void resumeSession() {
    state = state.copyWith(status: SessionStatus.running);
    _startTimer();
  }

  void logDrift() {
    if (state.status != SessionStatus.running) return;
    final newTimestamps = [...state.driftTimestamps, state.elapsedSeconds];
    state = state.copyWith(
      driftCount: state.driftCount + 1,
      driftTimestamps: newTimestamps,
    );
  }

  void setArousalBefore(double value) {
    state = state.copyWith(arousalBefore: value);
  }

  void setArousalAfter(double value) {
    state = state.copyWith(arousalAfter: value);
  }

  void setQualityScore(double value) {
    state = state.copyWith(qualityScore: value);
  }

  void setNotes(String text) {
    state = state.copyWith(notesText: text);
  }

  Future<void> completeSession() async {
    _timer?.cancel();
    final now = DateTime.now();
    final rowId = state.dbRowId;
    if (rowId == null) return;

    final db = _ref.read(appDatabaseProvider);
    await db.practiceSessionsDao.updateSession(
      PracticeSessionsTableCompanion(
        id: Value(rowId),
        endedAt: Value(now),
        durationSeconds: Value(state.elapsedSeconds),
        driftCount: Value(state.driftCount),
        driftTapLog: Value(_encodeTimestamps(state.driftTimestamps)),
        arousalAfter: state.arousalAfter != null
            ? Value(state.arousalAfter!)
            : const Value.absent(),
        notesText: state.notesText != null
            ? Value(state.notesText!)
            : const Value.absent(),
        qualityScore: state.qualityScore != null
            ? Value(state.qualityScore!)
            : const Value.absent(),
      ),
    );

    state = state.copyWith(status: SessionStatus.complete);

    // Enqueue anonymous session stat (fire-and-forget).
    enqueueAndSubmit(
      extractor: _ref.read(statsExtractorProvider),
      submitter: _ref.read(statsSubmitterProvider),
      enqueue: (e) => e.enqueueSession(
        practiceId: state.practiceId ?? '',
        phaseNumber: _phaseNumber,
        durationSeconds: state.elapsedSeconds,
        driftCount: state.driftCount,
        arousalBefore: state.arousalBefore,
        arousalAfter: state.arousalAfter,
        qualityScore: state.qualityScore,
      ),
    ).ignore();
  }

  void reset() {
    _timer?.cancel();
    state = const SessionState();
  }

  String _encodeTimestamps(List<int> timestamps) {
    return '[${timestamps.join(',')}]';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final sessionStateProvider =
    StateNotifierProvider<SessionNotifier, SessionState>(
  (ref) => SessionNotifier(ref),
);

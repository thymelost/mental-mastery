import 'dart:convert';

import 'package:drift/drift.dart';

import '../../core/database/app_database.dart';

/// Builds sanitized anonymous stat payloads and enqueues them.
///
/// Never includes: text, transcripts, notes, journal content, or any
/// free-text field. Only numeric scores, IDs, and timestamps.
///
/// Silently no-ops if the user has not opted in to anonymous statistics.
class StatsExtractorService {
  StatsExtractorService(this._db);

  final AppDatabase _db;

  // ── Public enqueue methods ───────────────────────────────────────────────

  Future<void> enqueueAssessment({
    required String assessmentId,
    required int phaseNumber,
    required double? totalScore,
    required Map<String, double>? subscaleScores,
    required DateTime administeredAt,
  }) async {
    final token = await _tokenIfOptedIn();
    if (token == null) return;
    await _enqueue(
      eventType: 'assessment',
      payload: {
        'token': token,
        'assessmentId': assessmentId,
        'phaseNumber': phaseNumber,
        'totalScore': totalScore,
        'subscaleScores': subscaleScores,
        'administeredAt': administeredAt.toUtc().toIso8601String(),
      },
    );
  }

  Future<void> enqueueGatePassage({
    required int gateNumber,
    required bool passed,
    required int attemptCount,
    required int criteriaMetCount,
    required int criteriaTotal,
  }) async {
    final token = await _tokenIfOptedIn();
    if (token == null) return;
    await _enqueue(
      eventType: 'gate_passage',
      payload: {
        'token': token,
        'gateNumber': gateNumber,
        'passed': passed,
        'attemptCount': attemptCount,
        'criteriaMetCount': criteriaMetCount,
        'criteriaTotal': criteriaTotal,
        'evaluatedAt': DateTime.now().toUtc().toIso8601String(),
      },
    );
  }

  Future<void> enqueuePhaseTransition({
    required int fromPhase,
    required int toPhase,
    required DateTime fromPhaseStartedAt,
  }) async {
    final token = await _tokenIfOptedIn();
    if (token == null) return;
    final durationDays =
        DateTime.now().difference(fromPhaseStartedAt).inDays;
    await _enqueue(
      eventType: 'phase_transition',
      payload: {
        'token': token,
        'fromPhase': fromPhase,
        'toPhase': toPhase,
        'durationDays': durationDays,
        'transitionedAt': DateTime.now().toUtc().toIso8601String(),
      },
    );
  }

  Future<void> enqueueSession({
    required String practiceId,
    required int phaseNumber,
    required int? durationSeconds,
    required int driftCount,
    required double? arousalBefore,
    required double? arousalAfter,
    required double? qualityScore,
  }) async {
    final token = await _tokenIfOptedIn();
    if (token == null) return;
    await _enqueue(
      eventType: 'session',
      payload: {
        'token': token,
        'practiceId': practiceId,
        'phaseNumber': phaseNumber,
        'durationSeconds': durationSeconds,
        'driftCount': driftCount,
        'arousalBefore': arousalBefore,
        'arousalAfter': arousalAfter,
        'qualityScore': qualityScore,
        'completedAt': DateTime.now().toUtc().toIso8601String(),
      },
    );
  }

  // ── Internals ────────────────────────────────────────────────────────────

  Future<String?> _tokenIfOptedIn() async {
    final state = await _db.userStateDao.getState();
    if (state == null || !state.statsOptIn) return null;
    return state.statsToken;
  }

  Future<void> _enqueue({
    required String eventType,
    required Map<String, dynamic> payload,
  }) =>
      _db.statsQueueDao.enqueue(
        StatsQueueTableCompanion.insert(
          eventType: eventType,
          payloadJson: jsonEncode(payload),
          createdAt: Value(DateTime.now()),
        ),
      );
}

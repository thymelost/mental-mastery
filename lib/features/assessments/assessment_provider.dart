import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/app_database.dart';
import '../../core/database/drift_provider.dart';
import '../../content/assessments/all_assessments.dart';
import '../../content/assessments/assessment_model.dart';
import '../../services/stats/stats_provider.dart';

// ─── Assessment session state ─────────────────────────────────────────────────

@immutable
class AssessmentSessionState {
  const AssessmentSessionState({
    this.assessmentId,
    this.rawScores = const {},
    this.totalScore,
    this.subscaleScores,
    this.isSubmitting = false,
    this.resultId,
  });

  final String? assessmentId;
  final Map<String, dynamic> rawScores;
  final double? totalScore;
  final Map<String, double>? subscaleScores;
  final bool isSubmitting;
  final int? resultId;

  AssessmentSessionState copyWith({
    String? assessmentId,
    Map<String, dynamic>? rawScores,
    double? totalScore,
    Map<String, double>? subscaleScores,
    bool? isSubmitting,
    int? resultId,
  }) {
    return AssessmentSessionState(
      assessmentId: assessmentId ?? this.assessmentId,
      rawScores: rawScores ?? this.rawScores,
      totalScore: totalScore ?? this.totalScore,
      subscaleScores: subscaleScores ?? this.subscaleScores,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      resultId: resultId ?? this.resultId,
    );
  }
}

// ─── Notifier ─────────────────────────────────────────────────────────────────

class AssessmentNotifier extends StateNotifier<AssessmentSessionState> {
  AssessmentNotifier(this._ref) : super(const AssessmentSessionState());

  final Ref _ref;

  void begin(String assessmentId) {
    state = AssessmentSessionState(assessmentId: assessmentId);
  }

  /// Called by runner widgets when the user completes the assessment.
  /// [rawScores] format varies by runner; stored as JSON.
  /// Returns the inserted result row id on success, null on failure.
  Future<int?> submit({
    required int phaseNumber,
    required Map<String, dynamic> rawScores,
    double? totalScore,
    Map<String, double>? subscaleScores,
    String? environmentType,
    String? loadType,
    double? hrDeviceCount,
    double? hrUserEstimate,
  }) async {
    if (state.isSubmitting) return null;
    state = state.copyWith(isSubmitting: true);

    try {
      final db = _ref.read(appDatabaseProvider);
      final id = await db.assessmentResultsDao.insertResult(
        AssessmentResultsTableCompanion.insert(
          assessmentId: state.assessmentId ?? '',
          phaseNumber: phaseNumber,
          administeredAt: DateTime.now(),
          rawScores: jsonEncode(rawScores),
          totalScore: Value(totalScore),
          subscaleScores: Value(
            subscaleScores != null ? jsonEncode(subscaleScores) : null,
          ),
          environmentType: Value(environmentType),
          loadType: Value(loadType),
          hrDeviceCount: Value(hrDeviceCount),
          hrUserEstimate: Value(hrUserEstimate),
        ),
      );
      state = state.copyWith(
        isSubmitting: false,
        rawScores: rawScores,
        totalScore: totalScore,
        subscaleScores: subscaleScores,
        resultId: id,
      );

      // Enqueue anonymous stat (fire-and-forget; silently no-ops if not opted in).
      enqueueAndSubmit(
        extractor: _ref.read(statsExtractorProvider),
        submitter: _ref.read(statsSubmitterProvider),
        enqueue: (e) => e.enqueueAssessment(
          assessmentId: state.assessmentId ?? '',
          phaseNumber: phaseNumber,
          totalScore: totalScore,
          subscaleScores: subscaleScores,
          administeredAt: DateTime.now(),
        ),
      ).ignore();

      return id;
    } catch (_) {
      state = state.copyWith(isSubmitting: false);
      return null;
    }
  }

  void reset() {
    state = const AssessmentSessionState();
  }
}

// ─── Providers ────────────────────────────────────────────────────────────────

final assessmentNotifierProvider =
    StateNotifierProvider<AssessmentNotifier, AssessmentSessionState>(
  (ref) => AssessmentNotifier(ref),
);

/// Stream of the most recent result for a given assessment id.
final latestResultProvider = StreamProvider.family<
    AssessmentResultsTableData?, String>((ref, assessmentId) {
  return ref
      .watch(appDatabaseProvider)
      .assessmentResultsDao
      .watchLatestResult(assessmentId);
});

/// All assessments available in the current phase, with last-admin date.
/// Returns a list of (AssessmentContent, DateTime?) pairs.
final phaseAssessmentsProvider =
    FutureProvider.family<List<(AssessmentContent, DateTime?)>, int>(
  (ref, phaseNumber) async {
    final db = ref.watch(appDatabaseProvider);
    final results = <(AssessmentContent, DateTime?)>[];

    for (final a in kAssessments) {
      if (a.phasesAdministered.contains(phaseNumber) || a.isWeekly) {
        final lastDate =
            await db.assessmentResultsDao.getLastAdminDate(a.id);
        results.add((a, lastDate));
      }
    }
    return results;
  },
);

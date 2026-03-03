import 'package:drift/drift.dart';
import '../app_database.dart';

part 'assessment_results_dao.g.dart';

@DriftAccessor(tables: [AssessmentResultsTable])
class AssessmentResultsDao extends DatabaseAccessor<AppDatabase>
    with _$AssessmentResultsDaoMixin {
  AssessmentResultsDao(super.db);

  /// Inserts a new assessment result row and returns the generated id.
  /// Append-only by design — rows are never edited or deleted after insert.
  Future<int> insertResult(AssessmentResultsTableCompanion entry) {
    return into(assessmentResultsTable).insert(entry);
  }

  /// Returns the most recent result for a given assessment, or null.
  Future<AssessmentResultsTableData?> getLatestResult(String assessmentId) {
    return (select(assessmentResultsTable)
          ..where((t) => t.assessmentId.equals(assessmentId))
          ..orderBy([(t) => OrderingTerm.desc(t.administeredAt)])
          ..limit(1))
        .getSingleOrNull();
  }

  /// Reactive stream of the most recent result for a given assessment.
  Stream<AssessmentResultsTableData?> watchLatestResult(String assessmentId) {
    return (select(assessmentResultsTable)
          ..where((t) => t.assessmentId.equals(assessmentId))
          ..orderBy([(t) => OrderingTerm.desc(t.administeredAt)])
          ..limit(1))
        .watchSingleOrNull();
  }

  /// Full history for a given assessment, newest first.
  Future<List<AssessmentResultsTableData>> getResultsForAssessment(
    String assessmentId,
  ) {
    return (select(assessmentResultsTable)
          ..where((t) => t.assessmentId.equals(assessmentId))
          ..orderBy([(t) => OrderingTerm.desc(t.administeredAt)]))
        .get();
  }

  /// Returns the date of the most recent administration, or null if never run.
  Future<DateTime?> getLastAdminDate(String assessmentId) async {
    final result = await getLatestResult(assessmentId);
    return result?.administeredAt;
  }

  /// All results for a given phase, ordered by administration time.
  Future<List<AssessmentResultsTableData>> getResultsByPhase(int phaseNumber) {
    return (select(assessmentResultsTable)
          ..where((t) => t.phaseNumber.equals(phaseNumber))
          ..orderBy([(t) => OrderingTerm.asc(t.administeredAt)]))
        .get();
  }

  /// Reactive stream of all results across all assessments, newest first.
  Stream<List<AssessmentResultsTableData>> watchAllResults() {
    return (select(assessmentResultsTable)
          ..orderBy([(t) => OrderingTerm.desc(t.administeredAt)]))
        .watch();
  }
}

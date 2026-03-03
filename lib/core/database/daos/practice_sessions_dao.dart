import 'package:drift/drift.dart';
import '../app_database.dart';

part 'practice_sessions_dao.g.dart';

@DriftAccessor(tables: [PracticeSessionsTable])
class PracticeSessionsDao extends DatabaseAccessor<AppDatabase>
    with _$PracticeSessionsDaoMixin {
  PracticeSessionsDao(super.db);

  /// Inserts a new session row and returns its generated id.
  Future<int> insertSession(PracticeSessionsTableCompanion entry) {
    return into(practiceSessionsTable).insert(entry);
  }

  /// Updates a session row (e.g. to set endedAt, driftCount, arousal, etc.).
  Future<void> updateSession(PracticeSessionsTableCompanion entry) {
    return (update(practiceSessionsTable)
          ..where((t) => t.id.equals(entry.id.value)))
        .write(entry);
  }

  /// Returns all sessions for a given practice, newest first.
  Future<List<PracticeSessionsTableData>> getSessionsForPractice(
    String practiceId,
  ) {
    return (select(practiceSessionsTable)
          ..where((t) => t.practiceId.equals(practiceId))
          ..orderBy([(t) => OrderingTerm.desc(t.startedAt)]))
        .get();
  }

  /// Returns all sessions in a given phase, newest first.
  Future<List<PracticeSessionsTableData>> getSessionsForPhase(
    int phaseNumber,
  ) {
    return (select(practiceSessionsTable)
          ..where((t) => t.phaseNumber.equals(phaseNumber))
          ..orderBy([(t) => OrderingTerm.desc(t.startedAt)]))
        .get();
  }

  /// Returns the count of completed sessions for a practice within a date window.
  /// Used by GateEvaluatorService for semi-auto criteria checks.
  Future<int> countSessionsInWindow({
    required String practiceId,
    required DateTime since,
  }) async {
    final count = practiceSessionsTable.id.count();
    final query = selectOnly(practiceSessionsTable)
      ..addColumns([count])
      ..where(practiceSessionsTable.practiceId.equals(practiceId) &
          practiceSessionsTable.startedAt.isBiggerThanValue(since) &
          practiceSessionsTable.endedAt.isNotNull());
    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }

  /// Returns the most recent completed session for a practice, or null.
  /// Used by safetyDisplayModeProvider to determine first-session vs. repeat.
  Future<PracticeSessionsTableData?> getLastCompletedSession(
    String practiceId,
  ) {
    return (select(practiceSessionsTable)
          ..where(
            (t) =>
                t.practiceId.equals(practiceId) & t.endedAt.isNotNull(),
          )
          ..orderBy([(t) => OrderingTerm.desc(t.startedAt)])
          ..limit(1))
        .getSingleOrNull();
  }

  /// Reactive stream of recent sessions across all practices (last 30 days).
  Stream<List<PracticeSessionsTableData>> watchRecentSessions() {
    final cutoff = DateTime.now().subtract(const Duration(days: 30));
    return (select(practiceSessionsTable)
          ..where((t) => t.startedAt.isBiggerThanValue(cutoff))
          ..orderBy([(t) => OrderingTerm.desc(t.startedAt)]))
        .watch();
  }
}

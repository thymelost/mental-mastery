import 'package:drift/drift.dart';
import '../app_database.dart';

part 'journal_entries_dao.g.dart';

@DriftAccessor(tables: [JournalEntriesTable])
class JournalEntriesDao extends DatabaseAccessor<AppDatabase>
    with _$JournalEntriesDaoMixin {
  JournalEntriesDao(super.db);

  /// Inserts a new metadata row and returns the generated id.
  Future<int> insertEntry(JournalEntriesTableCompanion entry) {
    return into(journalEntriesTable).insert(entry);
  }

  /// Updates an existing metadata row (word count, transcription flag, etc.).
  Future<void> updateEntry(JournalEntriesTableCompanion entry) {
    return (update(journalEntriesTable)
          ..where((t) => t.id.equals(entry.id.value)))
        .write(entry);
  }

  /// Returns a single entry by id, or null.
  Future<JournalEntriesTableData?> getEntry(int id) {
    return (select(journalEntriesTable)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  /// Reactive stream of a single entry by id (null if deleted).
  Stream<JournalEntriesTableData?> watchEntry(int id) {
    return (select(journalEntriesTable)..where((t) => t.id.equals(id)))
        .watchSingleOrNull();
  }

  /// Reactive stream of all entries, newest first.
  Stream<List<JournalEntriesTableData>> watchAllEntries() {
    return (select(journalEntriesTable)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();
  }

  /// Returns entries for a specific template, newest first.
  Future<List<JournalEntriesTableData>> getEntriesForTemplate(
    String templateId,
  ) {
    return (select(journalEntriesTable)
          ..where((t) => t.templateId.equals(templateId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  /// Returns entries for a specific phase, newest first.
  Future<List<JournalEntriesTableData>> getEntriesForPhase(int phaseNumber) {
    return (select(journalEntriesTable)
          ..where((t) => t.phaseNumber.equals(phaseNumber))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  /// Count of entries for a template within a date window.
  /// Used by GateEvaluatorService for consecutive-day journal streak checks.
  Future<int> countEntriesInWindow({
    required String templateId,
    required DateTime since,
  }) async {
    final count = journalEntriesTable.id.count();
    final query = selectOnly(journalEntriesTable)
      ..addColumns([count])
      ..where(journalEntriesTable.templateId.equals(templateId) &
          journalEntriesTable.createdAt.isBiggerThanValue(since));
    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }
}

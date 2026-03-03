import 'package:drift/drift.dart';
import '../app_database.dart';

part 'stats_queue_dao.g.dart';

@DriftAccessor(tables: [StatsQueueTable])
class StatsQueueDao extends DatabaseAccessor<AppDatabase>
    with _$StatsQueueDaoMixin {
  StatsQueueDao(super.db);

  Future<void> enqueue(StatsQueueTableCompanion entry) =>
      into(statsQueueTable).insert(entry);

  /// Returns up to [limit] unsubmitted events, oldest first.
  Future<List<StatsQueueTableData>> getPendingBatch({int limit = 50}) =>
      (select(statsQueueTable)
            ..where((t) => t.submittedAt.isNull())
            ..orderBy([(t) => OrderingTerm.asc(t.createdAt)])
            ..limit(limit))
          .get();

  Future<void> markSubmitted(List<int> ids) =>
      (update(statsQueueTable)..where((t) => t.id.isIn(ids))).write(
        StatsQueueTableCompanion(submittedAt: Value(DateTime.now())),
      );

  Future<int> pendingCount() =>
      (select(statsQueueTable)..where((t) => t.submittedAt.isNull()))
          .get()
          .then((rows) => rows.length);
}

import 'package:drift/drift.dart';
import '../app_database.dart';

part 'longitudinal_metrics_dao.g.dart';

@DriftAccessor(tables: [LongitudinalMetricsTable])
class LongitudinalMetricsDao extends DatabaseAccessor<AppDatabase>
    with _$LongitudinalMetricsDaoMixin {
  LongitudinalMetricsDao(super.db);

  /// Inserts a new metric snapshot. Called alongside every assessment save.
  Future<void> insertMetric(LongitudinalMetricsTableCompanion entry) {
    return into(longitudinalMetricsTable).insert(entry);
  }

  /// Reactive stream of all snapshots for a given metric id, oldest first.
  /// Used to drive trajectory charts in the Progress screen.
  Stream<List<LongitudinalMetricsTableData>> watchMetric(String metricId) {
    return (select(longitudinalMetricsTable)
          ..where((t) => t.metricId.equals(metricId))
          ..orderBy([(t) => OrderingTerm.asc(t.recordedAt)]))
        .watch();
  }

  /// Returns the most recent snapshot for a given metric, or null.
  Future<LongitudinalMetricsTableData?> getLatestMetric(String metricId) {
    return (select(longitudinalMetricsTable)
          ..where((t) => t.metricId.equals(metricId))
          ..orderBy([(t) => OrderingTerm.desc(t.recordedAt)])
          ..limit(1))
        .getSingleOrNull();
  }

  /// Returns all distinct metric IDs present in the table.
  /// Used to build the chart selector in the Progress screen.
  Future<List<String>> getAllMetricIds() async {
    final col = longitudinalMetricsTable.metricId;
    final query = selectOnly(longitudinalMetricsTable, distinct: true)
      ..addColumns([col]);
    final rows = await query.get();
    return rows.map((r) => r.read(col)!).toList();
  }

  /// Returns all snapshots for a phase, ordered by time.
  Future<List<LongitudinalMetricsTableData>> getMetricsForPhase(
    int phaseNumber,
  ) {
    return (select(longitudinalMetricsTable)
          ..where((t) => t.phaseNumber.equals(phaseNumber))
          ..orderBy([(t) => OrderingTerm.asc(t.recordedAt)]))
        .get();
  }
}

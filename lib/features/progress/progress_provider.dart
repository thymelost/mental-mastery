import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/app_database.dart';
import '../../core/database/drift_provider.dart';

/// Stream of all longitudinal metric snapshots for a given metric id,
/// ordered oldest→newest. Drives trajectory charts in the Progress screen.
final longitudinalMetricProvider = StreamProvider.family<
    List<LongitudinalMetricsTableData>, String>((ref, metricId) {
  return ref
      .watch(appDatabaseProvider)
      .longitudinalMetricsDao
      .watchMetric(metricId);
});

/// One-shot future: all distinct metric ids present in the DB.
/// Used to populate the chart selector in the Progress screen.
final allMetricIdsProvider = FutureProvider<List<String>>((ref) {
  return ref
      .watch(appDatabaseProvider)
      .longitudinalMetricsDao
      .getAllMetricIds();
});

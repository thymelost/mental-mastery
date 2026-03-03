// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'longitudinal_metrics_dao.dart';

// ignore_for_file: type=lint
mixin _$LongitudinalMetricsDaoMixin on DatabaseAccessor<AppDatabase> {
  $LongitudinalMetricsTableTable get longitudinalMetricsTable =>
      attachedDatabase.longitudinalMetricsTable;
  LongitudinalMetricsDaoManager get managers =>
      LongitudinalMetricsDaoManager(this);
}

class LongitudinalMetricsDaoManager {
  final _$LongitudinalMetricsDaoMixin _db;
  LongitudinalMetricsDaoManager(this._db);
  $$LongitudinalMetricsTableTableTableManager get longitudinalMetricsTable =>
      $$LongitudinalMetricsTableTableTableManager(
          _db.attachedDatabase, _db.longitudinalMetricsTable);
}

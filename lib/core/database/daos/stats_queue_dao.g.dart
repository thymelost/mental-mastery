// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_queue_dao.dart';

// ignore_for_file: type=lint
mixin _$StatsQueueDaoMixin on DatabaseAccessor<AppDatabase> {
  $StatsQueueTableTable get statsQueueTable => attachedDatabase.statsQueueTable;
  StatsQueueDaoManager get managers => StatsQueueDaoManager(this);
}

class StatsQueueDaoManager {
  final _$StatsQueueDaoMixin _db;
  StatsQueueDaoManager(this._db);
  $$StatsQueueTableTableTableManager get statsQueueTable =>
      $$StatsQueueTableTableTableManager(
          _db.attachedDatabase, _db.statsQueueTable);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_alarms_dao.dart';

// ignore_for_file: type=lint
mixin _$ScheduledAlarmsDaoMixin on DatabaseAccessor<AppDatabase> {
  $ScheduledAlarmsTableTable get scheduledAlarmsTable =>
      attachedDatabase.scheduledAlarmsTable;
  ScheduledAlarmsDaoManager get managers => ScheduledAlarmsDaoManager(this);
}

class ScheduledAlarmsDaoManager {
  final _$ScheduledAlarmsDaoMixin _db;
  ScheduledAlarmsDaoManager(this._db);
  $$ScheduledAlarmsTableTableTableManager get scheduledAlarmsTable =>
      $$ScheduledAlarmsTableTableTableManager(
          _db.attachedDatabase, _db.scheduledAlarmsTable);
}

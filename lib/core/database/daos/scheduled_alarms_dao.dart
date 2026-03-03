import 'package:drift/drift.dart';

import '../app_database.dart';

part 'scheduled_alarms_dao.g.dart';

@DriftAccessor(tables: [ScheduledAlarmsTable])
class ScheduledAlarmsDao extends DatabaseAccessor<AppDatabase>
    with _$ScheduledAlarmsDaoMixin {
  ScheduledAlarmsDao(super.db);

  Future<int> insertAlarm(ScheduledAlarmsTableCompanion entry) =>
      into(scheduledAlarmsTable).insert(entry);

  Stream<List<ScheduledAlarmsTableData>> watchUpcoming(int phaseNumber) =>
      (select(scheduledAlarmsTable)
            ..where((t) =>
                t.phaseNumber.equals(phaseNumber) & t.firedAt.isNull())
            ..orderBy([(t) => OrderingTerm.asc(t.scheduledFor)]))
          .watch();

  Future<List<ScheduledAlarmsTableData>> getPendingByType(
    String alarmType,
  ) =>
      (select(scheduledAlarmsTable)
            ..where((t) =>
                t.alarmType.equals(alarmType) & t.respondedAt.isNull()))
          .get();

  Future<void> markFired(int id) =>
      (update(scheduledAlarmsTable)..where((t) => t.id.equals(id))).write(
        ScheduledAlarmsTableCompanion(firedAt: Value(DateTime.now())),
      );

  Future<void> markResponded(int id, String responseJson) =>
      (update(scheduledAlarmsTable)..where((t) => t.id.equals(id))).write(
        ScheduledAlarmsTableCompanion(
          respondedAt: Value(DateTime.now()),
          responseJson: Value(responseJson),
        ),
      );

  Future<void> deleteAlarm(int id) =>
      (delete(scheduledAlarmsTable)..where((t) => t.id.equals(id))).go();

  Future<void> deleteAllByType(String alarmType) =>
      (delete(scheduledAlarmsTable)
            ..where((t) => t.alarmType.equals(alarmType)))
          .go();
}

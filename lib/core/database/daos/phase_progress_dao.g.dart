// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phase_progress_dao.dart';

// ignore_for_file: type=lint
mixin _$PhaseProgressDaoMixin on DatabaseAccessor<AppDatabase> {
  $PhaseProgressTableTable get phaseProgressTable =>
      attachedDatabase.phaseProgressTable;
  PhaseProgressDaoManager get managers => PhaseProgressDaoManager(this);
}

class PhaseProgressDaoManager {
  final _$PhaseProgressDaoMixin _db;
  PhaseProgressDaoManager(this._db);
  $$PhaseProgressTableTableTableManager get phaseProgressTable =>
      $$PhaseProgressTableTableTableManager(
          _db.attachedDatabase, _db.phaseProgressTable);
}

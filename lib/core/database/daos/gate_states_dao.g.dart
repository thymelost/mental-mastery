// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gate_states_dao.dart';

// ignore_for_file: type=lint
mixin _$GateStatesDaoMixin on DatabaseAccessor<AppDatabase> {
  $GateStatesTableTable get gateStatesTable => attachedDatabase.gateStatesTable;
  GateStatesDaoManager get managers => GateStatesDaoManager(this);
}

class GateStatesDaoManager {
  final _$GateStatesDaoMixin _db;
  GateStatesDaoManager(this._db);
  $$GateStatesTableTableTableManager get gateStatesTable =>
      $$GateStatesTableTableTableManager(
          _db.attachedDatabase, _db.gateStatesTable);
}

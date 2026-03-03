// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state_dao.dart';

// ignore_for_file: type=lint
mixin _$UserStateDaoMixin on DatabaseAccessor<AppDatabase> {
  $UserStateTableTable get userStateTable => attachedDatabase.userStateTable;
  UserStateDaoManager get managers => UserStateDaoManager(this);
}

class UserStateDaoManager {
  final _$UserStateDaoMixin _db;
  UserStateDaoManager(this._db);
  $$UserStateTableTableTableManager get userStateTable =>
      $$UserStateTableTableTableManager(
          _db.attachedDatabase, _db.userStateTable);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'practice_sessions_dao.dart';

// ignore_for_file: type=lint
mixin _$PracticeSessionsDaoMixin on DatabaseAccessor<AppDatabase> {
  $PracticeSessionsTableTable get practiceSessionsTable =>
      attachedDatabase.practiceSessionsTable;
  PracticeSessionsDaoManager get managers => PracticeSessionsDaoManager(this);
}

class PracticeSessionsDaoManager {
  final _$PracticeSessionsDaoMixin _db;
  PracticeSessionsDaoManager(this._db);
  $$PracticeSessionsTableTableTableManager get practiceSessionsTable =>
      $$PracticeSessionsTableTableTableManager(
          _db.attachedDatabase, _db.practiceSessionsTable);
}

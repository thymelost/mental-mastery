// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_entries_dao.dart';

// ignore_for_file: type=lint
mixin _$JournalEntriesDaoMixin on DatabaseAccessor<AppDatabase> {
  $JournalEntriesTableTable get journalEntriesTable =>
      attachedDatabase.journalEntriesTable;
  JournalEntriesDaoManager get managers => JournalEntriesDaoManager(this);
}

class JournalEntriesDaoManager {
  final _$JournalEntriesDaoMixin _db;
  JournalEntriesDaoManager(this._db);
  $$JournalEntriesTableTableTableManager get journalEntriesTable =>
      $$JournalEntriesTableTableTableManager(
          _db.attachedDatabase, _db.journalEntriesTable);
}

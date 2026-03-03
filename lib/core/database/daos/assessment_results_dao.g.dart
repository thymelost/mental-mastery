// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessment_results_dao.dart';

// ignore_for_file: type=lint
mixin _$AssessmentResultsDaoMixin on DatabaseAccessor<AppDatabase> {
  $AssessmentResultsTableTable get assessmentResultsTable =>
      attachedDatabase.assessmentResultsTable;
  AssessmentResultsDaoManager get managers => AssessmentResultsDaoManager(this);
}

class AssessmentResultsDaoManager {
  final _$AssessmentResultsDaoMixin _db;
  AssessmentResultsDaoManager(this._db);
  $$AssessmentResultsTableTableTableManager get assessmentResultsTable =>
      $$AssessmentResultsTableTableTableManager(
          _db.attachedDatabase, _db.assessmentResultsTable);
}

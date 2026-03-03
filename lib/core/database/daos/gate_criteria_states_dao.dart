import 'package:drift/drift.dart';
import '../app_database.dart';

part 'gate_criteria_states_dao.g.dart';

@DriftAccessor(tables: [GateCriteriaStatesTable])
class GateCriteriaStatesDao extends DatabaseAccessor<AppDatabase>
    with _$GateCriteriaStatesDaoMixin {
  GateCriteriaStatesDao(super.db);

  /// Returns all criterion state rows for a gate + attempt, unordered.
  Future<List<GateCriteriaStatesTableData>> getCriteriaForAttempt({
    required int gateNumber,
    required int attemptNumber,
  }) {
    return (select(gateCriteriaStatesTable)
          ..where(
            (t) =>
                t.gateNumber.equals(gateNumber) &
                t.attemptNumber.equals(attemptNumber),
          ))
        .get();
  }

  /// Inserts a batch of criterion state rows for a new gate attempt.
  Future<void> insertCriteriaStates(
    List<GateCriteriaStatesTableCompanion> entries,
  ) async {
    await batch((b) => b.insertAll(gateCriteriaStatesTable, entries));
  }

  /// Updates the status (and optionally value) for a single criterion row,
  /// identified by gate number + criterion id + attempt number.
  Future<void> updateCriterionStatus({
    required int gateNumber,
    required String criterionId,
    required int attemptNumber,
    required String status,
    String? value,
  }) {
    return (update(gateCriteriaStatesTable)
          ..where(
            (t) =>
                t.gateNumber.equals(gateNumber) &
                t.criterionId.equals(criterionId) &
                t.attemptNumber.equals(attemptNumber),
          ))
        .write(GateCriteriaStatesTableCompanion(
          status: Value(status),
          value: value != null ? Value(value) : const Value.absent(),
          evaluatedAt: Value(DateTime.now()),
        ));
  }
}

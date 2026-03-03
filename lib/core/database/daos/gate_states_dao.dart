import 'package:drift/drift.dart';
import '../app_database.dart';

part 'gate_states_dao.g.dart';

@DriftAccessor(tables: [GateStatesTable])
class GateStatesDao extends DatabaseAccessor<AppDatabase>
    with _$GateStatesDaoMixin {
  GateStatesDao(super.db);

  /// Returns the gate state row for a given gate number, or null.
  Future<GateStatesTableData?> getGateState(int gateNumber) {
    return (select(gateStatesTable)
          ..where((t) => t.gateNumber.equals(gateNumber)))
        .getSingleOrNull();
  }

  /// Reactive stream of a single gate state row.
  Stream<GateStatesTableData?> watchGateState(int gateNumber) {
    return (select(gateStatesTable)
          ..where((t) => t.gateNumber.equals(gateNumber)))
        .watchSingleOrNull();
  }

  /// Reactive stream of all gate states ordered by gate number.
  Stream<List<GateStatesTableData>> watchAllGateStates() {
    return (select(gateStatesTable)
          ..orderBy([(t) => OrderingTerm.asc(t.gateNumber)]))
        .watch();
  }

  /// Inserts a new gate state row. Returns the generated id.
  Future<int> insertGateState(GateStatesTableCompanion entry) {
    return into(gateStatesTable).insert(entry);
  }

  /// Updates an existing gate state row (matched by gate number).
  Future<void> updateGateState(int gateNumber, GateStatesTableCompanion patch) {
    return (update(gateStatesTable)
          ..where((t) => t.gateNumber.equals(gateNumber)))
        .write(patch);
  }

  /// Ensures a gate state row exists for every gate 1–9.
  /// Call once after onboarding completes; safe to call multiple times.
  Future<void> ensureAllGatesInitialized() async {
    for (int n = 1; n <= 9; n++) {
      final existing = await getGateState(n);
      if (existing == null) {
        await into(gateStatesTable).insert(
          GateStatesTableCompanion.insert(gateNumber: n),
        );
      }
    }
  }
}

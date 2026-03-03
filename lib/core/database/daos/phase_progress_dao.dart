import 'package:drift/drift.dart';
import '../app_database.dart';

part 'phase_progress_dao.g.dart';

@DriftAccessor(tables: [PhaseProgressTable])
class PhaseProgressDao extends DatabaseAccessor<AppDatabase>
    with _$PhaseProgressDaoMixin {
  PhaseProgressDao(super.db);

  /// Returns the currently active phase row, if any.
  Future<PhaseProgressTableData?> getActivePhase() {
    return (select(phaseProgressTable)
          ..where((t) => t.status.equals('active'))
          ..limit(1))
        .getSingleOrNull();
  }

  /// Creates a Phase 0 row with status 'active' if no row exists yet.
  Future<void> ensurePhase0Active() async {
    final existing = await (select(phaseProgressTable)
          ..where((t) => t.phaseNumber.equals(0)))
        .getSingleOrNull();
    if (existing == null) {
      await into(phaseProgressTable).insert(
        PhaseProgressTableCompanion.insert(
          phaseNumber: 0,
          status: const Value('active'),
          startedAt: DateTime.now(),
        ),
      );
    }
  }

  /// Returns all phase rows ordered by phase number.
  Future<List<PhaseProgressTableData>> getAllPhases() {
    return (select(phaseProgressTable)
          ..orderBy([(t) => OrderingTerm.asc(t.phaseNumber)]))
        .get();
  }

  /// Reactive stream of all phase rows for the phase journey screen.
  Stream<List<PhaseProgressTableData>> watchAllPhases() {
    return (select(phaseProgressTable)
          ..orderBy([(t) => OrderingTerm.asc(t.phaseNumber)]))
        .watch();
  }

  /// Marks a phase as complete and timestamps it.
  Future<void> completePhase(int phaseNumber) async {
    await (update(phaseProgressTable)
          ..where((t) => t.phaseNumber.equals(phaseNumber)))
        .write(
      PhaseProgressTableCompanion(
        status: const Value('complete'),
        completedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Returns a specific phase row by number, or null if not yet created.
  Future<PhaseProgressTableData?> getPhaseByNumber(int phaseNumber) {
    return (select(phaseProgressTable)
          ..where((t) => t.phaseNumber.equals(phaseNumber)))
        .getSingleOrNull();
  }

  /// Activates the next phase, creating its row.
  Future<void> activatePhase(int phaseNumber) async {
    final existing = await (select(phaseProgressTable)
          ..where((t) => t.phaseNumber.equals(phaseNumber)))
        .getSingleOrNull();
    if (existing == null) {
      await into(phaseProgressTable).insert(
        PhaseProgressTableCompanion.insert(
          phaseNumber: phaseNumber,
          status: const Value('active'),
          startedAt: DateTime.now(),
        ),
      );
    }
  }
}

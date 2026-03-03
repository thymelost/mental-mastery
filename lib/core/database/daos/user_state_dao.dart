import 'package:drift/drift.dart';
import '../app_database.dart';

part 'user_state_dao.g.dart';

@DriftAccessor(tables: [UserStateTable])
class UserStateDao extends DatabaseAccessor<AppDatabase>
    with _$UserStateDaoMixin {
  UserStateDao(super.db);

  /// Returns the singleton user state row, or null if not yet initialized.
  Future<UserStateTableData?> getState() {
    return (select(userStateTable)..where((t) => t.id.equals(1)))
        .getSingleOrNull();
  }

  /// Inserts the singleton row (id = 1) if it does not exist yet.
  Future<void> ensureInitialized() async {
    final existing = await getState();
    if (existing == null) {
      await into(userStateTable).insert(
        UserStateTableCompanion.insert(
          id: const Value(1),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );
    }
  }

  /// Sets onboarding_complete = true.
  Future<void> setOnboardingComplete() async {
    await (update(userStateTable)..where((t) => t.id.equals(1))).write(
      UserStateTableCompanion(
        onboardingComplete: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Updates the current phase number.
  Future<void> setCurrentPhase(int phase) async {
    await (update(userStateTable)..where((t) => t.id.equals(1))).write(
      UserStateTableCompanion(
        currentPhase: Value(phase),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Sets per-metric track assignments after Phase 0 assessments complete.
  /// Each value must be 'standard', 'extended', or 'priority'.
  /// Pass null for any metric to leave it unchanged.
  Future<void> setMetricTracks({
    String? emotional,
    String? somatic,
    String? vocabulary,
  }) async {
    await (update(userStateTable)..where((t) => t.id.equals(1))).write(
      UserStateTableCompanion(
        trackEmotionalLiteracy:
            emotional != null ? Value(emotional) : const Value.absent(),
        trackSomatic:
            somatic != null ? Value(somatic) : const Value.absent(),
        trackVocabulary:
            vocabulary != null ? Value(vocabulary) : const Value.absent(),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Records Phase 0 TAS-20 score.
  Future<void> setTas20Score(int score) async {
    await (update(userStateTable)..where((t) => t.id.equals(1))).write(
      UserStateTableCompanion(
        tas20Score: Value(score),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Sets anonymous statistics opt-in and generates a local token on opt-in.
  /// Token is cleared on opt-out.
  Future<void> setStatsOptIn({
    required bool optIn,
    String? token,
  }) async {
    await (update(userStateTable)..where((t) => t.id.equals(1))).write(
      UserStateTableCompanion(
        statsOptIn: Value(optIn),
        statsToken: optIn && token != null
            ? Value(token)
            : optIn
                ? const Value.absent()
                : const Value(null),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Reactive stream of the singleton user state row.
  Stream<UserStateTableData?> watchState() {
    return (select(userStateTable)..where((t) => t.id.equals(1)))
        .watchSingleOrNull();
  }
}

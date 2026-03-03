import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'database/app_database.dart';
import 'database/drift_provider.dart';

// ─── User State ────────────────────────────────────────────────────────────

/// Reactive stream of the singleton UserState row.
final userStateProvider = StreamProvider<UserStateTableData?>((ref) {
  return ref.watch(appDatabaseProvider).userStateDao.watchState();
});

/// Whether the user has completed onboarding.
final onboardingCompleteProvider = Provider<bool>((ref) {
  return ref.watch(userStateProvider).maybeWhen(
        data: (state) => state?.onboardingComplete ?? false,
        orElse: () => false,
      );
});

/// Current active phase number (0–8).
final currentPhaseProvider = Provider<int>((ref) {
  return ref.watch(userStateProvider).maybeWhen(
        data: (state) => state?.currentPhase ?? 0,
        orElse: () => 0,
      );
});

// ─── Phase Progress ────────────────────────────────────────────────────────

/// Reactive list of all phase progress rows, ordered by phase number.
final allPhasesProgressProvider =
    StreamProvider<List<PhaseProgressTableData>>((ref) {
  return ref.watch(appDatabaseProvider).phaseProgressDao.watchAllPhases();
});

// ─── Journal ───────────────────────────────────────────────────────────────

/// Reactive stream of all journal entry metadata rows, newest first.
final journalEntriesProvider =
    StreamProvider<List<JournalEntriesTableData>>((ref) {
  return ref.watch(appDatabaseProvider).journalEntriesDao.watchAllEntries();
});

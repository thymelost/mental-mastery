import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ml_kit_genai_engine.dart';
import 'transcription_manager.dart';
import 'transcription_settings.dart';

// ── Settings ──────────────────────────────────────────────────────────────────

/// Shared [TranscriptionSettings] instance.
///
/// Settings changes (preferMlKit, useWhisper, backgroundCapture) propagate
/// automatically to the manager because it holds a reference to this instance.
final transcriptionSettingsProvider =
    ChangeNotifierProvider<TranscriptionSettings>(
  (ref) => TranscriptionSettings(),
);

// ── Manager ───────────────────────────────────────────────────────────────────

/// The [TranscriptionManager] wired to the shared settings.
///
/// Prefer [ref.read] (not [ref.watch]) when calling imperative methods like
/// `start()` and `stop()` to avoid recreating the manager on each build.
final transcriptionManagerProvider =
    ChangeNotifierProvider<TranscriptionManager>(
  (ref) {
    final settings = ref.watch(transcriptionSettingsProvider);
    final manager = TranscriptionManager(settings: settings);
    manager.init();
    ref.onDispose(manager.dispose);
    return manager;
  },
);

// ── ML Kit availability ───────────────────────────────────────────────────────

/// True if [MlKitGenAiEngine] reports hardware/SDK availability at runtime.
///
/// Checked once on first read. Drives the ML Kit toggle visibility in
/// [TranscriptionWidget] — the toggle is hidden if this returns false.
final mlKitAvailableProvider = FutureProvider<bool>((ref) async {
  final engine = MlKitGenAiEngine();
  try {
    return await engine.isAvailable();
  } catch (_) {
    return false;
  }
});

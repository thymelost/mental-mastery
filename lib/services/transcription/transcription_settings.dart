import 'package:flutter/foundation.dart';

/// Persists user preferences for the transcription subsystem.
///
/// Lives in a [ChangeNotifierProvider] so the [TranscriptionManager] and
/// [TranscriptionWidget] can both read and mutate settings reactively.
class TranscriptionSettings extends ChangeNotifier {
  TranscriptionSettings();

  // ── Toggles ──────────────────────────────────────────────────────────────

  /// Whether to prefer ML Kit GenAI (Tier 2) over Tier 1 when available.
  ///
  /// Enabled by default. When [mlKitAvailable] is false at runtime, the
  /// manager falls through to Tier 1 regardless of this flag.
  bool _preferMlKit = true;

  /// Whether to use Whisper (Tier 3) exclusively — "Offline High-Privacy mode".
  ///
  /// Disabled by default. Must be set explicitly by the user. When true,
  /// the manager bypasses Tier 1 and Tier 2 and uses [WhisperEngine] only;
  /// if Whisper is not yet available, recording is blocked.
  bool _useWhisper = false;

  /// Allow audio capture to continue when the app is backgrounded.
  ///
  /// Off by default; requires careful lifecycle management to avoid draining
  /// battery / holding mic unnecessarily.
  bool _backgroundCapture = false;

  // ── Getters ───────────────────────────────────────────────────────────────

  bool get preferMlKit => _preferMlKit;
  bool get useWhisper => _useWhisper;
  bool get backgroundCapture => _backgroundCapture;

  // ── Setters ───────────────────────────────────────────────────────────────

  void setPreferMlKit(bool value) {
    if (_preferMlKit == value) return;
    _preferMlKit = value;
    notifyListeners();
  }

  void setUseWhisper(bool value) {
    if (_useWhisper == value) return;
    _useWhisper = value;
    notifyListeners();
  }

  void setBackgroundCapture(bool value) {
    if (_backgroundCapture == value) return;
    _backgroundCapture = value;
    notifyListeners();
  }
}

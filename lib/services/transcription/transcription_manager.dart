import 'dart:async';

import 'package:flutter/widgets.dart';

import 'ml_kit_genai_engine.dart';
import 'speech_to_text_engine.dart';
import 'transcription_engine.dart';
import 'transcription_settings.dart';
import 'whisper_engine.dart';

/// Orchestrates the three-tier transcription fallback chain.
///
/// Priority order (highest → lowest):
///   Tier 3: [WhisperEngine]    — only when [TranscriptionSettings.useWhisper]
///   Tier 2: [MlKitGenAiEngine] — when [preferMlKit] and engine.isAvailable()
///   Tier 1: [SpeechToTextEngine] — always available fallback
///
/// When an engine emits an error the manager automatically tries the next
/// lower tier. [TranscriptChunk]s are broadcast on [chunks].
///
/// Lifecycle: the manager registers itself as a [WidgetsBindingObserver] so
/// it can stop recording when the app is backgrounded (unless
/// [TranscriptionSettings.backgroundCapture] is true).
class TranscriptionManager extends ChangeNotifier with WidgetsBindingObserver {
  TranscriptionManager({required TranscriptionSettings settings})
      : _settings = settings;

  final TranscriptionSettings _settings;

  // ── Engines (lazy, shared instances) ────────────────────────────────────

  late final _tier1 = SpeechToTextEngine();
  late final _tier2 = MlKitGenAiEngine();
  final _tier3 = WhisperEngine.instance;

  // ── State ────────────────────────────────────────────────────────────────

  TranscriptionEngine? _activeEngine;
  bool _isRecording = false;
  bool _wasRecordingBeforePause = false;
  String _lastError = '';

  /// Engines that have failed in the current recording session.
  final _failedEngines = <EngineType>{};

  // ── Outbound stream ───────────────────────────────────────────────────────

  final _controller = StreamController<TranscriptChunk>.broadcast();

  /// All [TranscriptChunk]s emitted during the current (or most recent)
  /// recording session.
  Stream<TranscriptChunk> get chunks => _controller.stream;

  // ── Public state ─────────────────────────────────────────────────────────

  bool get isRecording => _isRecording;

  /// The engine currently producing audio, or null when idle.
  EngineType? get activeEngineType => _activeEngine?.engineType;

  /// The last error message from the fallback chain; empty when no error.
  String get lastError => _lastError;

  // ── Lifecycle ─────────────────────────────────────────────────────────────

  /// Must be called once after construction to register the lifecycle observer.
  void init() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopActiveEngine();
    _tier1.dispose();
    _tier2.dispose();
    _tier3.dispose();
    _controller.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      if (_isRecording && !_settings.backgroundCapture) {
        _wasRecordingBeforePause = true;
        stop();
      }
    } else if (state == AppLifecycleState.resumed) {
      if (_wasRecordingBeforePause) {
        _wasRecordingBeforePause = false;
        start();
      }
    }
  }

  // ── Public API ────────────────────────────────────────────────────────────

  /// Begin a recording session using the highest available tier.
  ///
  /// If [TranscriptionSettings.useWhisper] is true, only Whisper is tried;
  /// if it is unavailable, recording does not start and [lastError] is set.
  Future<void> start() async {
    if (_isRecording) return;

    _failedEngines.clear();
    _lastError = '';

    final engine = await _selectEngine();
    if (engine == null) {
      _lastError = _settings.useWhisper
          ? 'Offline High-Privacy mode: Whisper is not yet available. '
              'See Settings for setup instructions.'
          : 'No transcription engine is available on this device.';
      notifyListeners();
      return;
    }

    await _startEngine(engine);
  }

  /// Stop recording and flush any pending results.
  Future<void> stop() async {
    if (!_isRecording) return;
    await _stopActiveEngine();
    _isRecording = false;
    _activeEngine = null;
    notifyListeners();
  }

  // ── Engine selection ──────────────────────────────────────────────────────

  Future<TranscriptionEngine?> _selectEngine() async {
    if (_settings.useWhisper) {
      if (await _tier3.isAvailable()) return _tier3;
      return null; // Hard block — user explicitly chose Whisper-only
    }

    if (_settings.preferMlKit && !_failedEngines.contains(EngineType.mlKitGenAi)) {
      if (await _tier2.isAvailable()) return _tier2;
    }

    if (!_failedEngines.contains(EngineType.speechToText)) {
      if (await _tier1.isAvailable()) return _tier1;
    }

    return null;
  }

  // ── Engine management ─────────────────────────────────────────────────────

  Future<void> _startEngine(TranscriptionEngine engine) async {
    // Set _activeEngine BEFORE calling start() so _handleEngineError can
    // read it if start() calls onError synchronously.
    _activeEngine = engine;
    _isRecording = true;
    notifyListeners();

    await engine.start(
      onChunk: _handleChunk,
      onError: _handleEngineError,
    );
  }

  void _handleChunk(TranscriptChunk chunk) {
    if (!_controller.isClosed) _controller.add(chunk);
  }

  /// Called by an engine when it cannot continue (synchronously or async).
  ///
  /// Marks the engine as failed and attempts the next tier.
  void _handleEngineError(Object error) {
    final failed = _activeEngine;
    if (failed != null) {
      _failedEngines.add(failed.engineType);
      _stopActiveEngine(); // fire-and-forget; errors suppressed
    }
    _activeEngine = null;
    _isRecording = false;

    _lastError = error.toString();
    notifyListeners();

    // Kick off fallback asynchronously so we don't block the sync callback.
    _attemptFallback(error);
  }

  Future<void> _attemptFallback(Object originalError) async {
    if (_settings.useWhisper) {
      // Whisper-only mode — no fallback.
      return;
    }

    final next = await _selectEngine();
    if (next == null) {
      _lastError = 'All transcription engines failed. Last error: $originalError';
      notifyListeners();
      return;
    }

    await _startEngine(next);
  }

  Future<void> _stopActiveEngine() async {
    try {
      await _activeEngine?.stop();
    } catch (_) {
      // Suppress stop() errors during cleanup / fallback.
    }
  }
}

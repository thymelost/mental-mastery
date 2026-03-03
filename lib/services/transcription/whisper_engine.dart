// ⚠ FIRST-BUILD WARNING ────────────────────────────────────────────────────
// On the very first `flutter run` or `flutter build apk` after enabling this
// engine, CMake will download and compile ~400 MB of whisper.cpp source via
// FetchContent.  Expect 15–30 min on the first build; all subsequent
// incremental builds are fast.  Progress is visible in the Gradle/CMake
// output as "Building CXX object …" lines.
// ──────────────────────────────────────────────────────────────────────────

import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';

import '../../services/whisper_model/whisper_model_service.dart';
import 'transcription_engine.dart';
import 'whisper_audio_capture.dart';
import 'whisper_ffi_bindings.dart';

/// Tier 3 — offline Whisper base model via whisper.cpp FFI.
///
/// **Availability:** [isAvailable] returns `true` only when both conditions hold:
///   1. `libwhisper_bridge.so` can be loaded (i.e., the app was built with the
///      CMake native target — requires first build to complete, see warning above).
///   2. The ggml-base.bin model file exists on disk (user has downloaded it via
///      the Settings → Whisper Model card).
///
/// **Inference strategy:** Whisper is batch, not streaming.
///   - [start] begins audio capture (platform plugin must run on main isolate).
///   - [stop] ships the WAV path to [Isolate.run], which loads the library,
///     initialises a whisper context, runs inference, and returns the full text.
///   - A single [TranscriptChunk] with `isFinal: true` is emitted on completion.
///   - Model re-load per session adds ~2 s overhead, acceptable for journal use.
class WhisperEngine implements TranscriptionEngine {
  WhisperEngine._();
  static final instance = WhisperEngine._();

  // Lazily created so it can be recreated after dispose() (singleton lifecycle).
  WhisperAudioCapture? _capture;
  WhisperAudioCapture get _activeCapture => _capture ??= WhisperAudioCapture();

  // Set to true only after startRecording() succeeds; guards stop() against
  // running inference when capture never started (start/stop race condition).
  bool _recording = false;

  void Function(TranscriptChunk)? _onChunk;
  void Function(Object)? _onError;

  @override
  EngineType get engineType => EngineType.whisper;

  // ── Availability ────────────────────────────────────────────────────────

  @override
  Future<bool> isAvailable() async {
    try {
      // Condition 1: native library is loadable.
      if (WhisperFfiBindings.tryLoad() == null) return false;

      // Condition 2: model file is present on disk.
      final modelPath = await WhisperModelNotifier.getModelPath();
      return File(modelPath).exists();
    } catch (_) {
      return false;
    }
  }

  // ── Lifecycle ───────────────────────────────────────────────────────────

  @override
  Future<void> start({
    required void Function(TranscriptChunk chunk) onChunk,
    required void Function(Object error) onError,
  }) async {
    _onChunk = onChunk;
    _onError = onError;

    try {
      await _activeCapture.startRecording();
      _recording = true;
    } catch (e) {
      _onChunk = null;
      _onError = null;
      onError('WhisperEngine: audio capture failed to start — $e');
    }
  }

  @override
  Future<void> stop() async {
    final onChunk = _onChunk;
    final onError = _onError;
    _onChunk = null;
    _onError = null;

    // Guard: if startRecording() failed, _recording is still false — nothing to do.
    if (!_recording) {
      onError?.call('WhisperEngine: stop() called but no recording was active');
      return;
    }
    _recording = false;

    final wavPath = await _activeCapture.stopRecording();
    if (wavPath == null) {
      onError?.call('WhisperEngine: no audio captured');
      return;
    }

    final modelPath = await WhisperModelNotifier.getModelPath();

    String? text;
    try {
      // Run blocking inference in a background isolate to keep the UI responsive.
      // The isolate opens the .so fresh — safe and cheap on an already-loaded lib.
      text = await Isolate.run(() {
        final bindings = WhisperFfiBindings.tryLoad();
        if (bindings == null) return null;

        final ctx = bindings.initFromFile(modelPath);
        if (ctx == nullptr) return null;

        try {
          return bindings.transcribeFile(ctx, wavPath);
        } finally {
          bindings.freeCtx(ctx);
        }
      });
    } catch (e) {
      onError?.call('WhisperEngine: inference error — $e');
      _deleteTempWav(wavPath);
      return;
    }

    _deleteTempWav(wavPath);

    if (text != null && text.isNotEmpty) {
      onChunk?.call(TranscriptChunk(
        text: text,
        isFinal: true,
        confidence: null,
        timestampMs: DateTime.now().millisecondsSinceEpoch,
        engineType: EngineType.whisper,
      ));
    } else {
      onError?.call('WhisperEngine: transcription returned empty result');
    }
  }

  @override
  Future<void> dispose() async {
    _recording = false;
    await _capture?.dispose();
    _capture = null; // Allow lazy recreation if the singleton is reused after dispose.
  }

  // ── Helpers ─────────────────────────────────────────────────────────────

  void _deleteTempWav(String path) {
    try {
      final f = File(path);
      if (f.existsSync()) f.deleteSync();
    } catch (_) {
      // Non-fatal; temp directory will be cleaned by the OS eventually.
    }
  }
}

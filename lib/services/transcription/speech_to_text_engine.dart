import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

import 'transcription_engine.dart';

/// Tier 1 — uses the platform speech recogniser via the `speech_to_text`
/// package. Works on any Android device with Google ASR (cloud or on-device
/// depending on what the manufacturer has installed). No extra hardware
/// requirement; broadest compatibility.
class SpeechToTextEngine implements TranscriptionEngine {
  SpeechToTextEngine();

  final _stt = SpeechToText();
  bool _initialized = false;

  void Function(TranscriptChunk)? _onChunk;
  void Function(Object)? _onError;

  @override
  EngineType get engineType => EngineType.speechToText;

  // ── TranscriptionEngine ──────────────────────────────────────────────────

  @override
  Future<bool> isAvailable() async {
    try {
      _initialized = await _stt.initialize(
        onStatus: _handleStatus,
        onError: _handleSttError,
      );
      return _initialized;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<void> start({
    required void Function(TranscriptChunk chunk) onChunk,
    required void Function(Object error) onError,
  }) async {
    _onChunk = onChunk;
    _onError = onError;

    if (!_initialized) {
      _initialized = await _stt.initialize(
        onStatus: _handleStatus,
        onError: _handleSttError,
      );
    }

    if (!_initialized) {
      onError('SpeechToTextEngine: SpeechToText.initialize() returned false. '
          'Check microphone permission and ASR service availability.');
      return;
    }

    // If somehow already listening (e.g. re-use after stop), cancel first.
    if (_stt.isListening) await _stt.cancel();

    final sessionStart = DateTime.now().millisecondsSinceEpoch;

    final started = await _stt.listen(
      listenOptions: SpeechListenOptions(
        partialResults: true,
        cancelOnError: false,
      ),
      listenFor: const Duration(minutes: 5),
      pauseFor: const Duration(seconds: 4),
      onResult: (SpeechRecognitionResult result) {
        final conf = result.confidence > 0 ? result.confidence : null;
        _onChunk?.call(
          TranscriptChunk(
            text: result.recognizedWords,
            isFinal: result.finalResult,
            confidence: conf,
            timestampMs: DateTime.now().millisecondsSinceEpoch - sessionStart,
            engineType: EngineType.speechToText,
          ),
        );
      },
    );

    if (!started) {
      onError('SpeechToTextEngine: listen() returned false — '
          'microphone may be in use or permission was revoked.');
    }
  }

  @override
  Future<void> stop() async {
    if (_stt.isListening) await _stt.stop();
  }

  @override
  Future<void> dispose() async {
    if (_stt.isListening) await _stt.cancel();
    _onChunk = null;
    _onError = null;
    _initialized = false;
  }

  // ── Internal callbacks ────────────────────────────────────────────────────

  void _handleStatus(String status) {
    // 'done' fires when STT stops naturally (silence timeout). Surface this
    // as a final empty chunk so the manager knows the engine is idle.
    if (status == 'done' || status == 'notListening') {
      _onChunk?.call(
        const TranscriptChunk(
          text: '',
          isFinal: true,
          engineType: EngineType.speechToText,
        ),
      );
    }
  }

  void _handleSttError(SpeechRecognitionError error) {
    if (error.permanent) {
      _onError?.call(
        'SpeechToTextEngine: ${error.errorMsg} (permanent)',
      );
    }
    // Transient errors (e.g. network timeout on cloud STT) are ignored here;
    // the STT package resumes on its own in most cases.
  }
}

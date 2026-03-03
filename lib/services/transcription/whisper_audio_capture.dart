import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

/// Thin wrapper around the [AudioRecorder] from the `record` package.
///
/// Records mono PCM WAV at 16 kHz to a fixed temp file path.  The same path
/// is reused and overwritten on every session, which is intentional — the
/// file is only needed for the duration of a single transcription call.
class WhisperAudioCapture {
  final AudioRecorder _recorder = AudioRecorder();

  static const _fileName = 'whisper_capture.wav';

  /// Starts recording to `{temporaryDirectory}/whisper_capture.wav`.
  ///
  /// Throws [Exception] if the RECORD_AUDIO permission has been denied or
  /// if the recorder cannot be initialised.
  Future<void> startRecording() async {
    final dir = await getTemporaryDirectory();
    final path = '${dir.path}/$_fileName';

    await _recorder.start(
      const RecordConfig(
        encoder: AudioEncoder.wav,
        sampleRate: 16000,
        numChannels: 1,
      ),
      path: path,
    );
  }

  /// Stops the active recording.
  ///
  /// Returns the absolute path of the WAV file, or `null` if recording was
  /// never started or the recorder stopped without writing a file.
  Future<String?> stopRecording() async {
    return _recorder.stop();
  }

  /// Disposes the underlying [AudioRecorder].  Must be called when the engine
  /// is disposed to release the microphone resource.
  Future<void> dispose() async => _recorder.dispose();
}

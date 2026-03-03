/// Which engine produced a given [TranscriptChunk].
enum EngineType { speechToText, mlKitGenAi, whisper }

/// A single unit of transcription output.
///
/// Partial chunks arrive continuously during speech; isFinal = true marks
/// the end of a recognised utterance and is the chunk that should be
/// appended to the accumulated transcript.
class TranscriptChunk {
  const TranscriptChunk({
    required this.text,
    required this.isFinal,
    required this.engineType,
    this.confidence,
    this.timestampMs,
  });

  /// The recognised text for this chunk (may be a full utterance or a
  /// running partial).
  final String text;

  /// True when this chunk closes an utterance and should be committed.
  final bool isFinal;

  /// 0.0–1.0 if the engine reports a confidence score; null otherwise.
  final double? confidence;

  /// Milliseconds since the recognition session started; null if unavailable.
  final int? timestampMs;

  final EngineType engineType;

  @override
  String toString() =>
      'TranscriptChunk(${isFinal ? "final" : "partial"} '
      '"$text" conf=${confidence?.toStringAsFixed(2) ?? "n/a"} '
      'engine=$engineType)';
}

/// Common interface implemented by all three transcription tiers.
///
/// Implementations must be safe to call [isAvailable] on before [start],
/// and must never throw from [isAvailable].
abstract interface class TranscriptionEngine {
  EngineType get engineType;

  /// Returns true if this engine can be used on this device right now.
  /// Must never throw — return false on any failure.
  Future<bool> isAvailable();

  /// Begin capturing audio and emitting [TranscriptChunk]s.
  ///
  /// [onChunk] is guaranteed to be called on the main isolate.
  /// [onError] signals an unrecoverable failure; after it fires the engine
  /// is considered stopped and the caller must not call [stop] again.
  Future<void> start({
    required void Function(TranscriptChunk chunk) onChunk,
    required void Function(Object error) onError,
  });

  /// Gracefully stop recording and flush any pending results.
  /// Safe to call even if the engine is not currently running.
  Future<void> stop();

  /// Release all resources. The object must not be used after [dispose].
  Future<void> dispose();
}

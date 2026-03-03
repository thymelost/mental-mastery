/// State machine for the Whisper base model download lifecycle.
///
/// Transitions:
///   notDownloaded → downloading(0..1) → downloaded
///   downloading   → (cancel)         → notDownloaded
///   downloaded    → (delete)         → notDownloaded
///   any           → (error)          → error(message)
sealed class WhisperModelState {}

/// Model file is not present on device.
class ModelNotDownloaded extends WhisperModelState {}

/// Checking whether the model file already exists on disk.
class ModelChecking extends WhisperModelState {}

/// Model is actively downloading. [progress] is in the range [0.0, 1.0].
class ModelDownloading extends WhisperModelState {
  ModelDownloading(this.progress);
  final double progress;
}

/// Model file is fully downloaded and ready. [filePath] is the absolute path.
class ModelDownloaded extends WhisperModelState {
  ModelDownloaded(this.filePath);
  final String filePath;
}

/// An error occurred. [message] contains a human-readable description.
class ModelError extends WhisperModelState {
  ModelError(this.message);
  final String message;
}

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'whisper_model_state.dart';

/// Manages on-device storage of the whisper-base ggml model file.
///
/// Responsibilities:
///   - Check whether the model file already exists on disk.
///   - Download it from Hugging Face with per-chunk progress reporting.
///   - Support mid-download cancellation via [cancelDownload].
///   - Delete the local file via [deleteModel].
///
/// The FFI integration (whisper.cpp native build) reads the file from the path
/// exposed by [modelPath] — see whisper_engine.dart for the full guide.
class WhisperModelNotifier extends StateNotifier<WhisperModelState> {
  WhisperModelNotifier() : super(ModelNotDownloaded());

  // ── Constants ──────────────────────────────────────────────────────────────

  static const _downloadUrl =
      'https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-base.bin';
  static const _modelDir = 'mental_mastery_models';
  static const _modelFile = 'ggml-base.bin';

  /// Approximate download size in bytes, used for display only.
  static const int approximateSizeBytes = 142 * 1024 * 1024;

  // ── Internal state ─────────────────────────────────────────────────────────

  final _dio = Dio();
  CancelToken? _cancelToken;

  // ── Public API ─────────────────────────────────────────────────────────────

  /// Absolute path where the model file is (or will be) stored.
  Future<String> modelPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return p.join(dir.path, _modelDir, _modelFile);
  }

  /// Public static path accessor — used by WhisperEngine for FFI init
  /// without requiring a notifier instance.
  static Future<String> getModelPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return p.join(dir.path, _modelDir, _modelFile);
  }

  /// Checks disk for the model file. Emits [ModelChecking] then either
  /// [ModelDownloaded] or [ModelNotDownloaded]. Safe to call multiple times.
  Future<void> checkStatus() async {
    state = ModelChecking();
    try {
      final path = await modelPath();
      final exists = await File(path).exists();
      state = exists ? ModelDownloaded(path) : ModelNotDownloaded();
    } catch (e) {
      state = ModelError('Status check failed: $e');
    }
  }

  /// Begins downloading the model file. Progress updates are emitted as
  /// [ModelDownloading] states. On completion emits [ModelDownloaded].
  /// If already downloaded or currently downloading, does nothing.
  Future<void> startDownload() async {
    if (state is ModelDownloading || state is ModelDownloaded) return;

    final path = await modelPath();
    final dir = Directory(p.dirname(path));
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    _cancelToken = CancelToken();
    state = ModelDownloading(0.0);

    try {
      await _dio.download(
        _downloadUrl,
        path,
        cancelToken: _cancelToken,
        deleteOnError: true,
        onReceiveProgress: (received, total) {
          if (!mounted) return;
          final progress =
              total > 0 ? (received / total).clamp(0.0, 1.0) : 0.0;
          state = ModelDownloading(progress);
        },
      );

      if (mounted) {
        state = ModelDownloaded(path);
      }
    } on DioException catch (e) {
      if (!mounted) return;
      if (CancelToken.isCancel(e)) {
        // User-initiated cancel — return to not-downloaded cleanly.
        state = ModelNotDownloaded();
      } else {
        state = ModelError('Download failed: ${e.message}');
      }
    } catch (e) {
      if (mounted) state = ModelError('Download failed: $e');
    }
  }

  /// Cancels an in-progress download and returns to [ModelNotDownloaded].
  void cancelDownload() {
    _cancelToken?.cancel('User cancelled');
    // State is set to ModelNotDownloaded inside startDownload's catch block
    // once the cancellation propagates; no need to set it here.
  }

  /// Deletes the local model file and returns to [ModelNotDownloaded].
  Future<void> deleteModel() async {
    try {
      final path = await modelPath();
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
      if (mounted) state = ModelNotDownloaded();
    } catch (e) {
      if (mounted) state = ModelError('Delete failed: $e');
    }
  }

  @override
  void dispose() {
    _cancelToken?.cancel('Notifier disposed');
    _dio.close();
    super.dispose();
  }
}

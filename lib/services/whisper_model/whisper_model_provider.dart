import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'whisper_model_service.dart';
import 'whisper_model_state.dart';

/// Provides [WhisperModelNotifier] and its current [WhisperModelState].
///
/// Automatically calls [WhisperModelNotifier.checkStatus] on first access so
/// the UI always reflects the current on-disk state without an explicit call.
final whisperModelProvider =
    StateNotifierProvider<WhisperModelNotifier, WhisperModelState>((ref) {
  final notifier = WhisperModelNotifier();
  notifier.checkStatus();
  return notifier;
});

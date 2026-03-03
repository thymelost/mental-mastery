import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

// ── Native function typedefs ───────────────────────────────────────────────

typedef _InitFromFileNative = Pointer<Void> Function(Pointer<Utf8> modelPath);
typedef _InitFromFileDart = Pointer<Void> Function(Pointer<Utf8> modelPath);

typedef _TranscribeFileNative = Pointer<Utf8> Function(
    Pointer<Void> ctx, Pointer<Utf8> wavPath);
typedef _TranscribeFileDart = Pointer<Utf8> Function(
    Pointer<Void> ctx, Pointer<Utf8> wavPath);

typedef _FreeStringNative = Void Function(Pointer<Utf8> s);
typedef _FreeStringDart = void Function(Pointer<Utf8> s);

typedef _FreeCtxNative = Void Function(Pointer<Void> ctx);
typedef _FreeCtxDart = void Function(Pointer<Void> ctx);

// ── WhisperFfiBindings ─────────────────────────────────────────────────────

/// Lazy singleton that opens `libwhisper_bridge.so` once and exposes typed
/// Dart wrappers for the 4 exported C functions.
///
/// Each background [Isolate] that needs inference should call [tryLoad]
/// independently — `DynamicLibrary.open()` on an already-loaded .so is cheap
/// (returns the cached handle). Do NOT pass the singleton across isolate
/// boundaries.
class WhisperFfiBindings {
  WhisperFfiBindings._(DynamicLibrary lib)
      : _initFromFile = lib
            .lookupFunction<_InitFromFileNative, _InitFromFileDart>(
                'whisper_bridge_init_from_file'),
        _transcribeFile = lib
            .lookupFunction<_TranscribeFileNative, _TranscribeFileDart>(
                'whisper_bridge_transcribe_file'),
        _freeString = lib
            .lookupFunction<_FreeStringNative, _FreeStringDart>(
                'whisper_bridge_free_string'),
        _freeCtx = lib
            .lookupFunction<_FreeCtxNative, _FreeCtxDart>(
                'whisper_bridge_free');

  final _InitFromFileDart _initFromFile;
  final _TranscribeFileDart _transcribeFile;
  final _FreeStringDart _freeString;
  final _FreeCtxDart _freeCtx;

  // ── Singleton ──────────────────────────────────────────────────────────

  static WhisperFfiBindings? _instance;

  /// Returns a [WhisperFfiBindings] instance, or `null` if the native
  /// library cannot be loaded (e.g., running on non-Android platform,
  /// first build not yet completed, or .so not bundled).
  static WhisperFfiBindings? tryLoad() {
    if (_instance != null) return _instance;
    try {
      final lib = Platform.isAndroid
          ? DynamicLibrary.open('libwhisper_bridge.so')
          : DynamicLibrary.process(); // fallback for testing on other platforms
      _instance = WhisperFfiBindings._(lib);
      return _instance;
    } catch (_) {
      return null;
    }
  }

  // ── Public wrappers ────────────────────────────────────────────────────

  /// Initialises a whisper context from a model file on disk.
  ///
  /// Returns a native pointer that must be freed with [freeCtx].
  /// Returns [nullptr] on error.
  Pointer<Void> initFromFile(String modelPath) {
    return using((arena) {
      final pathPtr = modelPath.toNativeUtf8(allocator: arena);
      return _initFromFile(pathPtr);
    });
  }

  /// Transcribes the WAV file at [wavPath] using an existing [ctx].
  ///
  /// Returns the transcribed text, or `null` on error or empty result.
  /// The C string is copied to Dart and freed before this method returns —
  /// callers do not need to manage memory.
  String? transcribeFile(Pointer<Void> ctx, String wavPath) {
    return using((arena) {
      final wavPtr = wavPath.toNativeUtf8(allocator: arena);
      final resultPtr = _transcribeFile(ctx, wavPtr);
      if (resultPtr == nullptr) return null;
      final text = resultPtr.toDartString();
      _freeString(resultPtr);
      return text.isEmpty ? null : text;
    });
  }

  /// Releases the whisper context created by [initFromFile].
  void freeCtx(Pointer<Void> ctx) {
    if (ctx != nullptr) _freeCtx(ctx);
  }
}

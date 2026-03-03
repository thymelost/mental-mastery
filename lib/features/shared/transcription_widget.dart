import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/transcription/transcription_engine.dart';
import '../../services/transcription/transcription_provider.dart';
import '../../services/transcription/transcription_settings.dart';

/// Mic button + live transcript display + per-session settings toggles.
///
/// Drop this widget anywhere a voice input is needed (journal entry,
/// assessment prompt, etc.). It is self-contained: it manages its own
/// partial/final transcript buffer and exposes the completed transcript
/// via [onTranscriptComplete].
///
/// The widget reads from [transcriptionManagerProvider] and
/// [transcriptionSettingsProvider]; no additional setup is required beyond
/// wrapping the app in [ProviderScope].
class TranscriptionWidget extends ConsumerStatefulWidget {
  const TranscriptionWidget({
    super.key,
    this.onTranscriptComplete,
    this.hint = 'Tap the microphone to start speaking…',
  });

  /// Called when the user taps Done or stops recording, with the accumulated
  /// final transcript text.
  final void Function(String transcript)? onTranscriptComplete;

  /// Placeholder shown before any speech is captured.
  final String hint;

  @override
  ConsumerState<TranscriptionWidget> createState() =>
      _TranscriptionWidgetState();
}

class _TranscriptionWidgetState extends ConsumerState<TranscriptionWidget>
    with SingleTickerProviderStateMixin {
  // ── Transcript buffer ─────────────────────────────────────────────────────

  /// Committed (final) text accumulated across utterances.
  final _finalBuffer = StringBuffer();

  /// Current in-flight partial text (replaced by each partial chunk).
  String _partial = '';

  StreamSubscription<TranscriptChunk>? _chunkSub;

  // ── Animation ─────────────────────────────────────────────────────────────

  late final AnimationController _pulse;
  late final Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _pulseAnim = Tween(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _pulse, curve: Curves.easeInOut),
    );
    _pulse.stop();
  }

  @override
  void dispose() {
    _chunkSub?.cancel();
    _pulse.dispose();
    super.dispose();
  }

  // ── Recording control ─────────────────────────────────────────────────────

  Future<void> _toggleRecording() async {
    final manager = ref.read(transcriptionManagerProvider);

    if (manager.isRecording) {
      await manager.stop();
      _chunkSub?.cancel();
      _chunkSub = null;
      _pulse.stop();
      setState(() => _partial = '');
    } else {
      _finalBuffer.clear();
      _partial = '';

      _chunkSub = manager.chunks.listen(_onChunk);
      await manager.start();

      if (manager.isRecording) {
        _pulse.repeat(reverse: true);
      }
      setState(() {});
    }
  }

  void _onChunk(TranscriptChunk chunk) {
    setState(() {
      if (chunk.isFinal) {
        if (chunk.text.isNotEmpty) {
          if (_finalBuffer.isNotEmpty) _finalBuffer.write(' ');
          _finalBuffer.write(chunk.text);
        }
        _partial = '';
      } else {
        _partial = chunk.text;
      }
    });
  }

  void _clear() {
    _finalBuffer.clear();
    setState(() => _partial = '');
  }

  Future<void> _done() async {
    final manager = ref.read(transcriptionManagerProvider);
    if (manager.isRecording) {
      await manager.stop();
      _chunkSub?.cancel();
      _chunkSub = null;
      _pulse.stop();
    }
    final text = _finalBuffer.toString().trim();
    widget.onTranscriptComplete?.call(text);
    _finalBuffer.clear();
    setState(() => _partial = '');
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final manager = ref.watch(transcriptionManagerProvider);
    final settings = ref.watch(transcriptionSettingsProvider);
    final mlKitAsync = ref.watch(mlKitAvailableProvider);
    final mlKitAvailable = mlKitAsync.valueOrNull ?? false;

    final isRecording = manager.isRecording;
    final hasText = _finalBuffer.isNotEmpty || _partial.isNotEmpty;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Transcript area ─────────────────────────────────────────────────
        Container(
          constraints: const BoxConstraints(minHeight: 120),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: hasText
              ? _TranscriptText(
                  finalText: _finalBuffer.toString(),
                  partialText: _partial,
                )
              : Text(
                  widget.hint,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
        ),

        // ── Error banner ────────────────────────────────────────────────────
        if (manager.lastError.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              manager.lastError,
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: colorScheme.error),
            ),
          ),

        const SizedBox(height: 12),

        // ── Engine badge + mic button row ───────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isRecording && manager.activeEngineType != null)
              _EngineBadge(engineType: manager.activeEngineType!),
            const SizedBox(width: 12),
            _MicButton(
              isRecording: isRecording,
              pulseAnim: _pulseAnim,
              onTap: _toggleRecording,
            ),
          ],
        ),

        const SizedBox(height: 8),

        // ── Action row ──────────────────────────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (hasText && !isRecording)
              TextButton(
                onPressed: _clear,
                child: const Text('Clear'),
              ),
            const SizedBox(width: 8),
            FilledButton(
              onPressed: hasText || isRecording ? _done : null,
              child: const Text('Done'),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // ── Settings toggles ────────────────────────────────────────────────
        _SettingsToggles(
          settings: settings,
          mlKitAvailable: mlKitAvailable,
          isRecording: isRecording,
        ),
      ],
    ),
    );
  }

}

// ── Sub-widgets ───────────────────────────────────────────────────────────────

class _TranscriptText extends StatelessWidget {
  const _TranscriptText({
    required this.finalText,
    required this.partialText,
  });

  final String finalText;
  final String partialText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RichText(
      text: TextSpan(
        style: theme.textTheme.bodyMedium,
        children: [
          TextSpan(text: finalText),
          if (partialText.isNotEmpty)
            TextSpan(
              text: finalText.isNotEmpty ? ' $partialText' : partialText,
              style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant,
                fontStyle: FontStyle.italic,
              ),
            ),
        ],
      ),
    );
  }
}

class _MicButton extends StatelessWidget {
  const _MicButton({
    required this.isRecording,
    required this.pulseAnim,
    required this.onTap,
  });

  final bool isRecording;
  final Animation<double> pulseAnim;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final button = FloatingActionButton(
      onPressed: onTap,
      backgroundColor:
          isRecording ? colorScheme.error : colorScheme.primaryContainer,
      foregroundColor: isRecording
          ? colorScheme.onError
          : colorScheme.onPrimaryContainer,
      elevation: isRecording ? 6 : 2,
      child: Icon(isRecording ? Icons.stop : Icons.mic),
    );

    if (!isRecording) return button;

    return ScaleTransition(scale: pulseAnim, child: button);
  }
}

class _EngineBadge extends StatelessWidget {
  const _EngineBadge({required this.engineType});

  final EngineType engineType;

  String get _label => switch (engineType) {
        EngineType.speechToText => 'STT',
        EngineType.mlKitGenAi => 'ML Kit',
        EngineType.whisper => 'Whisper',
      };

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Chip(
      label: Text(_label),
      labelStyle: Theme.of(context)
          .textTheme
          .labelSmall
          ?.copyWith(color: colorScheme.onSecondaryContainer),
      backgroundColor: colorScheme.secondaryContainer,
      side: BorderSide.none,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      visualDensity: VisualDensity.compact,
    );
  }
}

class _SettingsToggles extends StatelessWidget {
  const _SettingsToggles({
    required this.settings,
    required this.mlKitAvailable,
    required this.isRecording,
  });

  final TranscriptionSettings settings;
  final bool mlKitAvailable;
  final bool isRecording;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Transcription options',
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),

        // ML Kit toggle — only shown when hardware supports it.
        if (mlKitAvailable)
          SwitchListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            value: settings.preferMlKit && !settings.useWhisper,
            onChanged: isRecording
                ? null
                : (v) {
                    settings.setPreferMlKit(v);
                    if (v) settings.setUseWhisper(false);
                  },
            title: const Text('Prefer ML Kit GenAI (on-device)'),
            subtitle: const Text('Higher accuracy on supported devices'),
          ),

        // Whisper (Offline High-Privacy) toggle — always shown.
        SwitchListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          value: settings.useWhisper,
          onChanged: isRecording
              ? null
              : (v) {
                  settings.setUseWhisper(v);
                  if (v) settings.setPreferMlKit(false);
                },
          title: const Text('Offline High-Privacy mode (Whisper)'),
          subtitle: const Text(
            'Requires one-time model download (~39 MB). '
            'Not yet available — see Settings.',
          ),
        ),

        // Background capture toggle.
        SwitchListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          value: settings.backgroundCapture,
          onChanged: (v) => settings.setBackgroundCapture(v),
          title: const Text('Continue when app is backgrounded'),
          subtitle: const Text('Uses more battery'),
        ),
      ],
    );
  }
}

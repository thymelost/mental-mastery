import 'package:flutter/material.dart';
import '../theme/tokens.dart';
import '../../features/shared/transcription_widget.dart';

/// A text field with an optional mic button for voice entry.
/// Voice transcription (Vosk / Whisper) is stubbed for Phase 6 implementation.
/// Text entry is always available and fully functional.
class VoiceInputField extends StatefulWidget {
  const VoiceInputField({
    super.key,
    required this.label,
    this.placeholder,
    this.initialValue,
    this.onChanged,
    this.minLines = 2,
    this.maxLines = 8,
    this.voiceEnabled = true,
  });

  final String label;
  final String? placeholder;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final int minLines;
  final int maxLines;
  /// If false, the mic button is hidden entirely (for scale/checklist fields).
  final bool voiceEnabled;

  @override
  State<VoiceInputField> createState() => _VoiceInputFieldState();
}

class _VoiceInputFieldState extends State<VoiceInputField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
    _controller.addListener(() => widget.onChanged?.call(_controller.text));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onMicTapped() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          MediaQuery.of(ctx).viewInsets.bottom + 24,
        ),
        child: TranscriptionWidget(
          hint: widget.placeholder ?? 'Speak your entry…',
          onTranscriptComplete: (text) {
            if (text.isNotEmpty) {
              final existing = _controller.text;
              _controller.text =
                  existing.isEmpty ? text : '$existing\n$text';
            }
            Navigator.of(ctx).pop();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: theme.textTheme.labelLarge),
        const SizedBox(height: spaceXs),
        Stack(
          children: [
            TextField(
              controller: _controller,
              minLines: widget.minLines,
              maxLines: widget.maxLines,
              decoration: InputDecoration(
                hintText: widget.placeholder,
                hintStyle: TextStyle(color: onSurfaceMuted),
                filled: true,
                fillColor: surfaceVariantDark,
                contentPadding: EdgeInsets.fromLTRB(
                  spaceMd,
                  spaceMd,
                  widget.voiceEnabled ? 48 : spaceMd,
                  spaceMd,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radiusMd),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radiusMd),
                  borderSide: BorderSide(
                    color: primaryTeal.withValues(alpha: 0.6),
                    width: 1,
                  ),
                ),
              ),
              style: theme.textTheme.bodyMedium,
            ),
            if (widget.voiceEnabled)
              Positioned(
                right: 4,
                top: 4,
                child: IconButton(
                  icon: const Icon(Icons.mic_none_outlined),
                  color: onSurfaceMuted,
                  iconSize: 20,
                  tooltip: 'Voice entry',
                  onPressed: _onMicTapped,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

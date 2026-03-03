import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/providers.dart';
import '../../core/theme/tokens.dart';
import '../../core/widgets/arousal_slider.dart';
import '../shared/transcription_widget.dart';
import 'practice_provider.dart';

/// Post-session screen: captures arousal-after and optional notes, then saves.
class SessionCompleteScreen extends ConsumerStatefulWidget {
  const SessionCompleteScreen({super.key, required this.practiceId});

  final String practiceId;

  @override
  ConsumerState<SessionCompleteScreen> createState() =>
      _SessionCompleteScreenState();
}

class _SessionCompleteScreenState
    extends ConsumerState<SessionCompleteScreen> {
  double _arousalAfter = 5.0;
  double _qualityScore = 0.5;
  final _notesController = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _showVoiceInput() {
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
          hint: 'Dictate session notes…',
          onTranscriptComplete: (text) {
            if (text.isNotEmpty) {
              final existing = _notesController.text.trim();
              _notesController.text =
                  existing.isEmpty ? text : '$existing\n$text';
            }
            Navigator.of(ctx).pop();
          },
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (_saving) return;
    setState(() => _saving = true);
    final notifier = ref.read(sessionStateProvider.notifier);
    notifier.setArousalAfter(_arousalAfter);
    final phaseNumber = ref.read(currentPhaseProvider);
    if (phaseNumber >= 7) {
      notifier.setQualityScore(_qualityScore);
    }
    if (_notesController.text.trim().isNotEmpty) {
      notifier.setNotes(_notesController.text.trim());
    }
    await notifier.completeSession();
    if (mounted) {
      notifier.reset();
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionStateProvider);
    final practice = practiceById(widget.practiceId);
    final phaseNumber = ref.watch(currentPhaseProvider);
    final elapsed = session.elapsedSeconds;
    final em = elapsed ~/ 60;
    final es = elapsed % 60;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Complete'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(spaceLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Summary card ─────────────────────────────────────────────
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(spaceLg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: gatePassGreen,
                          size: 20,
                        ),
                        const SizedBox(width: spaceSm),
                        Text(
                          practice?.name ?? widget.practiceId,
                          style: theme.textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: spaceMd),
                    _StatRow(
                      label: 'Duration',
                      value:
                          '${em.toString().padLeft(2, '0')}:${es.toString().padLeft(2, '0')}',
                    ),
                    _StatRow(
                      label: 'Attention drifts logged',
                      value: '${session.driftCount}',
                    ),
                    _StatRow(
                      label: 'Arousal before',
                      value: session.arousalBefore != null
                          ? session.arousalBefore!.toStringAsFixed(1)
                          : '—',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: spaceLg),

            // ── Arousal after ─────────────────────────────────────────────
            Text(
              'AROUSAL LEVEL NOW',
              style: theme.textTheme.labelSmall?.copyWith(
                color: primaryTeal,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: spaceSm),
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(spaceLg),
                child: ArousalSlider(
                  value: _arousalAfter,
                  onChanged: (v) => setState(() => _arousalAfter = v),
                ),
              ),
            ),
            const SizedBox(height: spaceLg),

            // ── Optional notes ────────────────────────────────────────────
            Row(
              children: [
                Text(
                  'SESSION NOTES (OPTIONAL)',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: primaryTeal,
                    letterSpacing: 1.1,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.mic_none_outlined),
                  iconSize: 20,
                  color: primaryTeal,
                  tooltip: 'Dictate note',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: _showVoiceInput,
                ),
              ],
            ),
            const SizedBox(height: spaceSm),
            TextField(
              controller: _notesController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Any observations from this session…',
                filled: true,
                fillColor: surfaceVariantDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radiusMd),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: spaceLg),

            // ── Quality score (Phase 7+) ──────────────────────────────────
            if (phaseNumber >= 7) ...[
              Text(
                'PRACTICE QUALITY (I1.4)',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: primaryTeal,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: spaceXs),
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(spaceMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'How behaviourally relevant was this session?',
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: spaceXs),
                      Text(
                        '0 = going through the motions · 1 = high relevance',
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: onSurfaceMuted),
                      ),
                      Slider(
                        value: _qualityScore,
                        min: 0,
                        max: 1,
                        divisions: 10,
                        activeColor: primaryTeal,
                        inactiveColor: surfaceVariantDark,
                        label: _qualityScore.toStringAsFixed(1),
                        onChanged: (v) =>
                            setState(() => _qualityScore = v),
                      ),
                      Center(
                        child: Text(
                          _qualityScore.toStringAsFixed(1),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontFamily: 'RobotoMono',
                            color: primaryTeal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: spaceLg),
            ],

            // ── Save button ───────────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saving ? null : _save,
                child: _saving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Save Session'),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: spaceSm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: theme.textTheme.bodySmall),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontFamily: 'RobotoMono',
              color: onSurfaceDark,
            ),
          ),
        ],
      ),
    );
  }
}

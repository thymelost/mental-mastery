import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/tokens.dart';
import '../../core/widgets/safety_card.dart';
import '../../core/widgets/arousal_slider.dart';
import '../../content/practices/practice_model.dart';
import 'practice_provider.dart';

/// Shows full practice description, steps, and a safety check before starting.
class PracticeDetailScreen extends ConsumerWidget {
  const PracticeDetailScreen({super.key, required this.practiceId});

  final String practiceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final practice = practiceById(practiceId);
    if (practice == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Practice not found.')),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(practice.name),
            floating: true,
            snap: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(spaceMd),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _MetaRow(practice: practice),
                const SizedBox(height: spaceLg),

                // ── Purpose ──────────────────────────────────────────────
                _SectionLabel('Purpose'),
                const SizedBox(height: spaceSm),
                Text(
                  practice.purpose,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: spaceLg),

                // ── Skills trained ────────────────────────────────────────
                if (practice.skillIds.isNotEmpty) ...[
                  _SectionLabel('Skills Trained'),
                  const SizedBox(height: spaceSm),
                  Wrap(
                    spacing: spaceSm,
                    runSpacing: spaceXs,
                    children: practice.skillIds
                        .map((id) => Chip(
                              label: Text(id),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                              side: BorderSide(
                                color: primaryTeal.withValues(alpha: 0.3),
                              ),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: spaceLg),
                ],

                // ── Steps ─────────────────────────────────────────────────
                _SectionLabel('How to Do It'),
                const SizedBox(height: spaceSm),
                ...practice.steps.asMap().entries.map(
                      (e) => _StepRow(
                        number: e.key + 1,
                        text: e.value,
                      ),
                    ),
                const SizedBox(height: spaceLg),

                // ── Research note ─────────────────────────────────────────
                if (practice.researchNote != null) ...[
                  _ResearchNoteCard(note: practice.researchNote!),
                  const SizedBox(height: spaceLg),
                ],

                // ── Safety card ───────────────────────────────────────────
                _SectionLabel('Before You Begin'),
                const SizedBox(height: spaceSm),
                _ArousalBeforeCard(practiceId: practiceId),
                const SizedBox(height: spaceMd),
                _SafetyLaunchCard(practice: practice),
                const SizedBox(height: 80),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Sub-widgets ─────────────────────────────────────────────────────────────

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.practice});
  final PracticeContent practice;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _MetaChip(Icons.schedule, '${practice.durationMinutes} min'),
        const SizedBox(width: spaceSm),
        _MetaChip(Icons.wb_sunny_outlined, _slotLabel(practice.scheduleSlot)),
        const SizedBox(width: spaceSm),
        _MetaChip(Icons.layers_outlined, 'Phase ${practice.phaseNumber}'),
      ],
    );
  }

  String _slotLabel(String slot) {
    return switch (slot) {
      'morning' => 'Morning',
      'midday' => 'Midday',
      'evening' => 'Evening',
      'triggered' => 'As triggered',
      _ => slot,
    };
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip(this.icon, this.label);
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: onSurfaceMuted),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: primaryTeal,
            letterSpacing: 1.1,
          ),
    );
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow({required this.number, required this.text});
  final int number;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: spaceMd),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 28,
            child: Text(
              '$number.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: primaryTeal,
                fontFamily: 'RobotoMono',
              ),
            ),
          ),
          Expanded(
            child: Text(text, style: theme.textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}

class _ResearchNoteCard extends StatelessWidget {
  const _ResearchNoteCard({required this.note});
  final String note;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(spaceMd),
      decoration: BoxDecoration(
        color: surfaceVariantDark,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border(
          left: BorderSide(color: primaryTeal, width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Research note',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: primaryTeal,
                ),
          ),
          const SizedBox(height: spaceXs),
          Text(note, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _ArousalBeforeCard extends ConsumerStatefulWidget {
  const _ArousalBeforeCard({required this.practiceId});
  final String practiceId;

  @override
  ConsumerState<_ArousalBeforeCard> createState() => _ArousalBeforeCardState();
}

class _ArousalBeforeCardState extends ConsumerState<_ArousalBeforeCard> {
  double _arousal = 5.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(spaceLg),
        child: ArousalSlider(
          value: _arousal,
          label: 'Arousal level now (0 = very calm, 10 = very activated)',
          onChanged: (v) {
            setState(() => _arousal = v);
            ref.read(sessionStateProvider.notifier).setArousalBefore(v);
          },
        ),
      ),
    );
  }
}

class _SafetyLaunchCard extends ConsumerStatefulWidget {
  const _SafetyLaunchCard({required this.practice});
  final PracticeContent practice;

  @override
  ConsumerState<_SafetyLaunchCard> createState() => _SafetyLaunchCardState();
}

class _SafetyLaunchCardState extends ConsumerState<_SafetyLaunchCard> {
  bool _acknowledged = false;

  void _acknowledge() {
    setState(() => _acknowledged = true);
    ref.read(sessionStateProvider.notifier).acknowledgeSafety();
  }

  @override
  Widget build(BuildContext context) {
    // After acknowledgment, show the Begin Session button.
    if (_acknowledged) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          icon: const Icon(Icons.play_arrow),
          label: const Text('Begin Session'),
          onPressed: () {
            ref
                .read(sessionStateProvider.notifier)
                .beginSafetyCheck(widget.practice.id);
            context.go('/practice/${widget.practice.id}/session');
          },
        ),
      );
    }

    // Choose card type based on session history.
    final modeAsync =
        ref.watch(safetyDisplayModeProvider(widget.practice.id));

    return modeAsync.when(
      loading: () => const SizedBox(
        height: 60,
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
      error: (_, __) => SafetyCard(
        signals: widget.practice.safetySignals,
        elevated: widget.practice.phaseNumber >= 5,
        onAcknowledged: _acknowledge,
      ),
      data: (mode) => switch (mode) {
        SafetyDisplayMode.fullPage => SafetyCard(
            signals: widget.practice.safetySignals,
            elevated: widget.practice.phaseNumber >= 5,
            onAcknowledged: _acknowledge,
          ),
        SafetyDisplayMode.summaryCard => _SummaryCard(
            signalCount: widget.practice.safetySignals.length,
            onAcknowledged: _acknowledge,
          ),
        SafetyDisplayMode.observational => _ObservationalFlashCard(
            onAcknowledged: _acknowledge,
          ),
      },
    );
  }
}

// ─── Compact safety cards ─────────────────────────────────────────────────────

/// Compact one-tap card for repeat sessions (subsequent visits to same track).
class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.signalCount,
    required this.onAcknowledged,
  });

  final int signalCount;
  final VoidCallback onAcknowledged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: spaceLg,
          vertical: spaceMd,
        ),
        child: Row(
          children: [
            Icon(Icons.warning_amber_rounded,
                size: 16, color: onSurfaceMuted),
            const SizedBox(width: spaceSm),
            Expanded(
              child: Text(
                '$signalCount stop ${signalCount == 1 ? 'criterion applies' : 'criteria apply'} — '
                'review on the practice detail page if needed.',
                style: theme.textTheme.bodySmall,
              ),
            ),
            const SizedBox(width: spaceSm),
            TextButton(
              onPressed: onAcknowledged,
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Single-tap flash card for practices with no documented stop criteria.
class _ObservationalFlashCard extends StatelessWidget {
  const _ObservationalFlashCard({required this.onAcknowledged});

  final VoidCallback onAcknowledged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: spaceLg,
          vertical: spaceMd,
        ),
        child: Row(
          children: [
            Icon(Icons.check_circle_outline,
                size: 16, color: gatePassGreen),
            const SizedBox(width: spaceSm),
            Expanded(
              child: Text(
                'No stop criteria required for this practice — '
                'it is observational only.',
                style: theme.textTheme.bodySmall,
              ),
            ),
            const SizedBox(width: spaceSm),
            TextButton(
              onPressed: onAcknowledged,
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}

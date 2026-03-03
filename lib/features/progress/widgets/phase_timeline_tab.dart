import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../content/phases/all_phases.dart';
import '../../../core/providers.dart';
import '../../../core/theme/tokens.dart';
import '../../../features/gates/gate_provider.dart';

/// Phase timeline tab: shows all 9 phases with unlock status and dates.
class PhaseTimelineTab extends ConsumerWidget {
  const PhaseTimelineTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phasesAsync = ref.watch(allPhasesProgressProvider);
    final gatesAsync = ref.watch(allGateStatesProvider);
    final theme = Theme.of(context);

    return phasesAsync.when(
      data: (phases) => gatesAsync.when(
        data: (gates) => ListView.separated(
          padding: const EdgeInsets.all(spaceMd),
          itemCount: kPhases.length,
          separatorBuilder: (_, __) => const SizedBox(height: spaceSm),
          itemBuilder: (_, i) {
            final phase = kPhases[i];
            final progress = phases
                .where((p) => p.phaseNumber == phase.phaseNumber)
                .firstOrNull;
            final gateOut = gates
                .where((g) => g.gateNumber == phase.phaseNumber + 1)
                .firstOrNull;

            return _PhaseRow(
              phase: phase,
              progressRow: progress,
              gateOutPassed: gateOut?.status == 'passed',
              theme: theme,
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}

class _PhaseRow extends StatelessWidget {
  const _PhaseRow({
    required this.phase,
    required this.progressRow,
    required this.gateOutPassed,
    required this.theme,
  });

  final dynamic phase; // PhaseContent
  final dynamic progressRow; // PhaseProgressTableData?
  final bool gateOutPassed;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final isComplete = progressRow?.status == 'complete';
    final isActive = progressRow?.status == 'active' ||
        progressRow?.status == 'gate_pending';
    final isLocked = progressRow == null;

    Color dotColor = isComplete
        ? gatePassGreen
        : isActive
            ? primaryTeal
            : onSurfaceMuted.withValues(alpha: 0.3);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline dot + line
        Column(
          children: [
            Container(
              width: 16,
              height: 16,
              margin: const EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: dotColor,
                border: isActive
                    ? Border.all(color: primaryTeal.withValues(alpha: 0.5), width: 2)
                    : null,
              ),
            ),
          ],
        ),
        const SizedBox(width: spaceMd),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(spaceMd),
            decoration: BoxDecoration(
              color: isActive ? surfaceVariantDark : surfaceDark,
              borderRadius: BorderRadius.circular(radiusMd),
              border: isActive
                  ? Border.all(color: primaryTeal.withValues(alpha: 0.2))
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Phase ${phase.phaseNumber}: ${phase.name}',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: isLocked ? onSurfaceMuted : onSurfaceDark,
                        ),
                      ),
                    ),
                    _StatusChip(
                      isComplete: isComplete,
                      isActive: isActive,
                      isLocked: isLocked,
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  phase.layer,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: onSurfaceMuted,
                  ),
                ),
                if (progressRow?.startedAt != null) ...[
                  const SizedBox(height: spaceSm),
                  Text(
                    'Started: ${_formatDate(progressRow!.startedAt)}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontFamily: 'RobotoMono',
                      color: onSurfaceMuted,
                    ),
                  ),
                ],
                if (progressRow?.completedAt != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    'Completed: ${_formatDate(progressRow!.completedAt!)}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontFamily: 'RobotoMono',
                      color: gatePassGreen,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime dt) =>
      '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.isComplete,
    required this.isActive,
    required this.isLocked,
  });

  final bool isComplete;
  final bool isActive;
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    final (label, color) = isComplete
        ? ('Complete', gatePassGreen)
        : isActive
            ? ('Active', primaryTeal)
            : ('Locked', onSurfaceMuted);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontSize: 10,
            ),
      ),
    );
  }
}

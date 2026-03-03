import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/tokens.dart';
import '../../../core/widgets/phase_badge.dart';
import '../phase_journey_provider.dart';

/// Shows a modal bottom sheet with details for a single phase.
void showPhaseDetailSheet(BuildContext context, PhaseJourneyItem item) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: surfaceDark,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusXl)),
    ),
    builder: (_) => _PhaseDetailSheet(item: item),
  );
}

class _PhaseDetailSheet extends StatelessWidget {
  const _PhaseDetailSheet({required this.item});

  final PhaseJourneyItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final phase = item.content;
    final maxHeight = MediaQuery.of(context).size.height * 0.75;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          spaceLg,
          spaceMd,
          spaceLg,
          spaceLg + MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Drag handle ───────────────────────────────────────────
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: onSurfaceMuted.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(radiusPill),
                ),
              ),
            ),
            const SizedBox(height: spaceLg),

            // ── Phase number + layer tag ───────────────────────────────
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: spaceSm, vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: surfaceVariantDark,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    'Phase ${phase.phaseNumber}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: primaryTeal,
                      fontFamily: 'RobotoMono',
                    ),
                  ),
                ),
                const SizedBox(width: spaceSm),
                Text(
                  phase.layer,
                  style: theme.textTheme.bodySmall,
                ),
                const Spacer(),
                PhaseBadge(status: item.status),
              ],
            ),
            const SizedBox(height: spaceMd),

            // ── Name ──────────────────────────────────────────────────
            Text(phase.name, style: theme.textTheme.headlineSmall),
            const SizedBox(height: spaceSm),

            // ── Duration ──────────────────────────────────────────────
            Row(
              children: [
                const Icon(Icons.schedule, size: 14, color: onSurfaceMuted),
                const SizedBox(width: 4),
                Text(
                  phase.durationNote,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: spaceMd),

            // ── Description ───────────────────────────────────────────
            Text(phase.description, style: theme.textTheme.bodyMedium),

            // ── Skills ───────────────────────────────────────────────
            if (phase.skillIds.isNotEmpty) ...[
              const SizedBox(height: spaceLg),
              Text(
                'Skills Trained',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: onSurfaceMuted,
                ),
              ),
              const SizedBox(height: spaceSm),
              Wrap(
                spacing: spaceSm,
                runSpacing: spaceXs,
                children: phase.skillIds
                    .map(
                      (id) => Chip(
                        label: Text(id),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                        side: BorderSide(
                          color: primaryTeal.withValues(alpha: 0.3),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],

            const SizedBox(height: spaceLg),

            // ── Gate info ─────────────────────────────────────────────
            if (phase.exitGateNumber != null) ...[
              _InfoRow(
                icon: Icons.transit_enterexit,
                label: 'Exits via Gate ${phase.exitGateNumber}',
              ),
              if (item.status == PhaseStatus.active) ...[
                const SizedBox(height: spaceLg),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.assignment_turned_in_outlined),
                    label: Text('Assess Gate ${phase.exitGateNumber}'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.go('/gate/${phase.exitGateNumber}');
                    },
                  ),
                ),
              ],
            ] else
              _InfoRow(
                icon: Icons.all_inclusive,
                label: 'No exit gate — ongoing practice',
              ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: onSurfaceMuted),
        const SizedBox(width: spaceSm),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

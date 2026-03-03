import 'package:flutter/material.dart';

import '../../../core/theme/tokens.dart';
import '../../../core/widgets/phase_badge.dart';
import '../phase_journey_provider.dart';
import 'phase_detail_sheet.dart';

/// A single node in the vertical timeline on the Phase Journey screen.
class PhaseNode extends StatelessWidget {
  const PhaseNode({
    super.key,
    required this.item,
    required this.isLast,
  });

  final PhaseJourneyItem item;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final phase = item.content;
    final isLocked = item.status == PhaseStatus.locked;
    final isActive = item.status == PhaseStatus.active;
    final isComplete = item.status == PhaseStatus.complete;

    final nodeColor = switch (item.status) {
      PhaseStatus.locked => phaseLocked,
      PhaseStatus.active => primaryTeal,
      PhaseStatus.complete => gatePassGreen,
    };

    final nodeRadius = isActive ? timelineNodeRadiusActive : timelineNodeRadius;

    return InkWell(
      onTap: () => showPhaseDetailSheet(context, item),
      borderRadius: BorderRadius.circular(radiusMd),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: spaceXs),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Left column: connector line + circle node ─────────────
            SizedBox(
              width: 40,
              child: Column(
                children: [
                  // Node circle
                  SizedBox(
                    width: nodeRadius * 2,
                    height: nodeRadius * 2,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isActive
                            ? nodeColor
                            : nodeColor.withValues(alpha: 0.25),
                        border: Border.all(
                          color: nodeColor,
                          width: isActive ? 2.5 : 1.5,
                        ),
                      ),
                      child: isComplete
                          ? Icon(
                              Icons.check,
                              size: 12,
                              color: gatePassGreen,
                            )
                          : isActive
                              ? Icon(
                                  Icons.radio_button_checked,
                                  size: 14,
                                  color: backgroundDark,
                                )
                              : null,
                    ),
                  ),
                  // Connector line down to next node
                  if (!isLast)
                    Container(
                      width: timelineLineWidth,
                      height: 56,
                      decoration: BoxDecoration(
                        color: isLocked
                            ? phaseLocked.withValues(alpha: 0.4)
                            : isComplete
                                ? gatePassGreen.withValues(alpha: 0.5)
                                : primaryTeal.withValues(alpha: 0.3),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(width: spaceMd),

            // ── Right column: phase info ───────────────────────────────
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 2, bottom: spaceMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Phase number + layer
                    Row(
                      children: [
                        Text(
                          'Phase ${phase.phaseNumber}',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: isLocked ? phaseLocked : primaryTeal,
                          ),
                        ),
                        const SizedBox(width: spaceSm),
                        Text(
                          '· ${phase.layer}',
                          style: theme.textTheme.labelSmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),

                    // Phase name
                    Text(
                      phase.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: isLocked ? onSurfaceMuted : onSurfaceDark,
                      ),
                    ),
                    const SizedBox(height: spaceXs),

                    // Duration + badge row
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 12,
                          color: onSurfaceMuted,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          phase.durationNote,
                          style: theme.textTheme.bodySmall,
                        ),
                        const SizedBox(width: spaceSm),
                        PhaseBadge(status: item.status),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // ── Chevron hint ──────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Icon(
                Icons.chevron_right,
                size: 18,
                color: isLocked
                    ? phaseLocked
                    : onSurfaceMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/theme/tokens.dart';

/// Full-width banner shown when the PHQ-9 hard block is active at Gate 7.
///
/// Replaces the submit button entirely — it cannot be dismissed.
class Phq9BlockBanner extends StatelessWidget {
  const Phq9BlockBanner({super.key, required this.score});

  final int? score;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(spaceLg),
      decoration: BoxDecoration(
        color: errorRed.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: errorRed.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.block, color: errorRed, size: 20),
              const SizedBox(width: spaceSm),
              Text(
                'GATE BLOCKED — PHQ-9',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: errorRed,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: spaceSm),
          if (score != null)
            Text(
              'PHQ-9 score: $score (threshold: ≤ 9)',
              style: theme.textTheme.bodySmall?.copyWith(
                fontFamily: 'RobotoMono',
                color: errorRed,
              ),
            ),
          const SizedBox(height: spaceSm),
          Text(
            'A PHQ-9 score of 10 or above indicates significant depressive '
            'symptoms that impair the perceptual accuracy Layer 3 requires. '
            'This gate cannot pass until PHQ-9 is ≤ 9.',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: spaceSm),
          Text(
            'This is a safety requirement, not a defeatable hint. '
            'Re-administer PHQ-9 after recovery, or seek professional support '
            'before continuing.',
            style: theme.textTheme.bodySmall?.copyWith(
              fontStyle: FontStyle.italic,
              color: onSurfaceMuted,
            ),
          ),
        ],
      ),
    );
  }
}

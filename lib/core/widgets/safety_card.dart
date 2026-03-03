import 'package:flutter/material.dart';
import '../theme/tokens.dart';

/// Displays stop/pause criteria before a practice session begins.
/// User must tap "Understood" before proceeding.
class SafetyCard extends StatelessWidget {
  const SafetyCard({
    super.key,
    required this.signals,
    required this.onAcknowledged,
    this.elevated = false,
  });

  final List<String> signals;
  final VoidCallback onAcknowledged;
  /// true for Layer 2/3 practices — uses a more prominent red-tinted border.
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = elevated
        ? errorRed.withValues(alpha: 0.6)
        : surfaceVariantDark;

    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusLg),
        side: BorderSide(color: borderColor, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(spaceLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: 18,
                  color: elevated ? errorRed : onSurfaceMuted,
                ),
                const SizedBox(width: spaceSm),
                Text(
                  'Stop or pause this practice if:',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: elevated ? errorRed : onSurfaceDark,
                  ),
                ),
              ],
            ),
            if (signals.isEmpty) ...[
              const SizedBox(height: spaceMd),
              Text(
                'No specific stop criteria documented for this practice. '
                'Use your own judgement — stop if you feel significantly distressed.',
                style: theme.textTheme.bodySmall,
              ),
            ] else ...[
              const SizedBox(height: spaceMd),
              ...signals.map(
                (s) => Padding(
                  padding: const EdgeInsets.only(bottom: spaceSm),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '· ',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: onSurfaceMuted,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          s,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: spaceLg),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onAcknowledged,
                child: const Text('I Understand'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

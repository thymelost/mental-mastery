import 'package:flutter/material.dart';
import '../theme/tokens.dart';

/// 0–10 arousal scale slider used in practice sessions and B3 assessments.
/// The framework specifies ±2 point error tolerance for this scale.
class ArousalSlider extends StatelessWidget {
  const ArousalSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
  });

  final double value;
  final ValueChanged<double> onChanged;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!, style: theme.textTheme.labelLarge),
          const SizedBox(height: spaceXs),
        ],
        Row(
          children: [
            Text('0', style: theme.textTheme.bodySmall),
            Expanded(
              child: Slider(
                value: value,
                min: 0,
                max: 10,
                divisions: 20,
                activeColor: primaryTeal,
                inactiveColor: surfaceVariantDark,
                onChanged: onChanged,
              ),
            ),
            Text('10', style: theme.textTheme.bodySmall),
          ],
        ),
        Center(
          child: Text(
            value.toStringAsFixed(1),
            style: theme.textTheme.headlineSmall?.copyWith(
              color: primaryTeal,
              fontFamily: 'RobotoMono',
            ),
          ),
        ),
      ],
    );
  }
}

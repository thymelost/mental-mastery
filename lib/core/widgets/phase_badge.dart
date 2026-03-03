import 'package:flutter/material.dart';
import '../theme/tokens.dart';

enum PhaseStatus { locked, active, complete }

class PhaseBadge extends StatelessWidget {
  const PhaseBadge({super.key, required this.status});

  final PhaseStatus status;

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      PhaseStatus.locked => _badge(
          label: 'Locked',
          icon: Icons.lock_outline,
          color: phaseLocked,
          textColor: onSurfaceMuted,
        ),
      PhaseStatus.active => _badge(
          label: 'Active',
          icon: Icons.radio_button_checked,
          color: primaryTeal.withValues(alpha: 0.18),
          textColor: primaryTeal,
          borderColor: primaryTeal,
        ),
      PhaseStatus.complete => _badge(
          label: 'Complete',
          icon: Icons.check_circle_outline,
          color: gatePassGreen.withValues(alpha: 0.14),
          textColor: gatePassGreen,
        ),
    };
  }

  Widget _badge({
    required String label,
    required IconData icon,
    required Color color,
    required Color textColor,
    Color? borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: spaceSm, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radiusPill),
        border: borderColor != null
            ? Border.all(color: borderColor, width: 1)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: textColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

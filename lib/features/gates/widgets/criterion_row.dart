import 'package:flutter/material.dart';

import '../../../content/gates/gate_model.dart';
import '../../../core/theme/tokens.dart';
import '../../../services/gate_evaluator/gate_evaluator_service.dart';
import '../gate_provider.dart';

/// Renders one gate criterion in the evaluation list.
///
/// - auto: shows pass / fail / no-data icon; no user interaction
/// - semiAuto / manual: shows a checkbox the user must tick
class CriterionRow extends StatelessWidget {
  const CriterionRow({
    super.key,
    required this.criterion,
    required this.evalResult,
    required this.confirmed,
    required this.onToggle,
  });

  final GateCriterion criterion;
  final CriterionEvalResult evalResult;
  final bool confirmed;
  final VoidCallback? onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isBlocking =
        criterion.blockingIfFailed && evalResult.autoStatus == CriterionAutoStatus.fail;

    return Container(
      margin: const EdgeInsets.only(bottom: spaceSm),
      padding: const EdgeInsets.all(spaceMd),
      decoration: BoxDecoration(
        color: isBlocking
            ? errorRed.withValues(alpha: 0.08)
            : surfaceVariantDark,
        borderRadius: BorderRadius.circular(radiusMd),
        border: isBlocking
            ? Border.all(color: errorRed.withValues(alpha: 0.4))
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _StatusIndicator(
                criterion: criterion,
                evalResult: evalResult,
                confirmed: confirmed,
                onToggle: onToggle,
              ),
              const SizedBox(width: spaceMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Track badge
                    Row(
                      children: [
                        _TrackBadge(track: criterion.track),
                        if (criterion.blockingIfFailed) ...[
                          const SizedBox(width: spaceXs),
                          _BlockBadge(),
                        ],
                      ],
                    ),
                    const SizedBox(height: spaceXs),
                    Text(
                      criterion.description,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Auto score display
          if (evalResult.displayValue != null) ...[
            const SizedBox(height: spaceXs),
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Text(
                evalResult.displayValue!,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontFamily: 'RobotoMono',
                  color: _statusColor(evalResult.autoStatus),
                ),
              ),
            ),
          ],
          // Notes
          if (criterion.notes != null) ...[
            const SizedBox(height: spaceXs),
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Text(
                criterion.notes!,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: onSurfaceMuted,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _statusColor(CriterionAutoStatus status) {
    return switch (status) {
      CriterionAutoStatus.pass => gatePassGreen,
      CriterionAutoStatus.fail => errorRed,
      _ => onSurfaceMuted,
    };
  }
}

// ─── Status indicator (icon or checkbox) ─────────────────────────────────────

class _StatusIndicator extends StatelessWidget {
  const _StatusIndicator({
    required this.criterion,
    required this.evalResult,
    required this.confirmed,
    required this.onToggle,
  });

  final GateCriterion criterion;
  final CriterionEvalResult evalResult;
  final bool confirmed;
  final VoidCallback? onToggle;

  @override
  Widget build(BuildContext context) {
    if (criterion.criterionType == GateCriterionType.auto) {
      return _AutoIcon(status: evalResult.autoStatus);
    }
    // manual or semiAuto: checkbox
    return SizedBox(
      width: 24,
      height: 24,
      child: Checkbox(
        value: confirmed,
        onChanged: onToggle != null ? (_) => onToggle!() : null,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        activeColor: gatePassGreen,
      ),
    );
  }
}

class _AutoIcon extends StatelessWidget {
  const _AutoIcon({required this.status});
  final CriterionAutoStatus status;

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      CriterionAutoStatus.pass => Icon(
          Icons.check_circle,
          color: gatePassGreen,
          size: 22,
        ),
      CriterionAutoStatus.fail => Icon(
          Icons.cancel,
          color: errorRed,
          size: 22,
        ),
      _ => Icon(
          Icons.radio_button_unchecked,
          color: onSurfaceMuted,
          size: 22,
        ),
    };
  }
}

class _TrackBadge extends StatelessWidget {
  const _TrackBadge({required this.track});
  final String track;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: primaryTeal.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'Track $track',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: primaryTeal,
              fontSize: 10,
            ),
      ),
    );
  }
}

class _BlockBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: errorRed.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'HARD BLOCK',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: errorRed,
              fontSize: 10,
              letterSpacing: 0.5,
            ),
      ),
    );
  }
}

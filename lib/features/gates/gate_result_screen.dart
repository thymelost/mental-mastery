import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../content/gates/gate_model.dart';
import '../../services/gate_evaluator/gate_evaluator_service.dart';
import '../../core/theme/tokens.dart';
import 'gate_provider.dart';

/// Shows the outcome of a gate assessment.
///
/// On pass: celebratory message + phase advancement confirmation.
/// On fail: lists unmet criteria with guidance on what to work on next.
class GateResultScreen extends ConsumerWidget {
  const GateResultScreen({super.key, required this.gateNumber});

  final int gateNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gateNotifierProvider(gateNumber));
    final gate = state.definition;
    final theme = Theme.of(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {},
      child: Scaffold(
        appBar: AppBar(
          title: Text('Gate $gateNumber Result'),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(spaceLg),
          child: state.passed
              ? _PassContent(gate: gate, theme: theme)
              : _FailContent(
                  gate: gate,
                  state: state,
                  theme: theme,
                ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(spaceLg),
            child: ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Return to Home'),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Pass ─────────────────────────────────────────────────────────────────────

class _PassContent extends StatelessWidget {
  const _PassContent({required this.gate, required this.theme});
  final GateDefinition gate;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: spaceXxl),
        Icon(Icons.check_circle_outline, color: gatePassGreen, size: 64),
        const SizedBox(height: spaceLg),
        Text(
          'Gate Passed',
          style: theme.textTheme.headlineMedium?.copyWith(color: gatePassGreen),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: spaceMd),
        Text(
          'Phase ${gate.toPhase} — ${_phaseName(gate.toPhase)} — is now unlocked.',
          style: theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: spaceSm),
        Text(
          'Return to the Phase Journey screen to begin Phase ${gate.toPhase}.',
          style: theme.textTheme.bodySmall?.copyWith(color: onSurfaceMuted),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: spaceXxl),
        if (gate.isCritical) ...[
          Container(
            padding: const EdgeInsets.all(spaceMd),
            decoration: BoxDecoration(
              color: primaryTeal.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: primaryTeal.withValues(alpha: 0.3)),
            ),
            child: Text(
              'You have crossed the Layer 2 → Layer 3 boundary. '
              'Layer 3 practices involve deliberate pattern modification. '
              'Continue to apply all Layer 2 monitoring throughout.',
              style: theme.textTheme.bodySmall,
            ),
          ),
        ],
      ],
    );
  }

  String _phaseName(int phase) {
    return switch (phase) {
      1 => 'Somatic & Attentional Foundation',
      2 => 'Emotional Literacy & Attentional Depth',
      3 => 'Metacognitive Foundation',
      4 => 'Metacognitive Core',
      5 => 'Self-Boundary & Dual Presence',
      6 => 'Layer 2 Verification',
      7 => 'State Modulation',
      8 => 'Pattern Work',
      _ => 'Phase $phase',
    };
  }
}

// ─── Fail ─────────────────────────────────────────────────────────────────────

class _FailContent extends StatelessWidget {
  const _FailContent({
    required this.gate,
    required this.state,
    required this.theme,
  });

  final GateDefinition gate;
  final GateEvalState state;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final unmetCriteria = _unmetCriteria();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.pending_outlined, color: onSurfaceMuted, size: 32),
            const SizedBox(width: spaceMd),
            Expanded(
              child: Text(
                'Not yet — ${unmetCriteria.length} criteria unmet',
                style: theme.textTheme.headlineSmall,
              ),
            ),
          ],
        ),
        const SizedBox(height: spaceSm),
        Text(
          'Gate ${gate.gateNumber} requires all criteria to pass. '
          'Continue practice and re-assess when ready.',
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: spaceLg),

        Text(
          'UNMET CRITERIA',
          style: theme.textTheme.labelSmall
              ?.copyWith(color: primaryTeal, letterSpacing: 1.1),
        ),
        const SizedBox(height: spaceSm),

        ...unmetCriteria.map(
          (c) => Container(
            margin: const EdgeInsets.only(bottom: spaceSm),
            padding: const EdgeInsets.all(spaceMd),
            decoration: BoxDecoration(
              color: surfaceVariantDark,
              borderRadius: BorderRadius.circular(radiusMd),
              border: c.blockingIfFailed
                  ? Border.all(color: errorRed.withValues(alpha: 0.4))
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (c.blockingIfFailed)
                      Icon(Icons.block, size: 14, color: errorRed)
                    else
                      Icon(Icons.circle, size: 8, color: onSurfaceMuted),
                    const SizedBox(width: spaceSm),
                    Text(
                      c.id,
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontFamily: 'RobotoMono',
                        color: c.blockingIfFailed ? errorRed : onSurfaceMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(c.description, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
        ),

        const SizedBox(height: spaceLg),

        // Track discrepancy note (shown if any Track B unmet while Track A passes)
        if (_hasTrackDiscrepancy()) ...[
          Container(
            padding: const EdgeInsets.all(spaceMd),
            decoration: BoxDecoration(
              color: surfaceVariantDark,
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TRACK A / TRACK B DISCREPANCY',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: primaryTeal,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: spaceXs),
                Text(
                  'Some Track A (self-reported) criteria are met while Track B '
                  '(objective performance) criteria are not, or vice versa. '
                  'This gap is meaningful data — not a simple error. '
                  'It may indicate that subjective experience and measurable '
                  'performance are not yet aligned. Review the discrepant skills '
                  'with both perspectives.',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  List<GateCriterion> _unmetCriteria() {
    final unmet = <GateCriterion>[];
    for (final c in gate.criteria) {
      final result = state.autoResults.firstWhere(
        (r) => r.criterionId == c.id,
        orElse: () => CriterionEvalResult(
          criterionId: c.id,
          autoStatus: CriterionAutoStatus.notEvaluated,
        ),
      );
      final isMet = c.criterionType == GateCriterionType.auto
          ? result.autoStatus == CriterionAutoStatus.pass
          : state.confirmedIds.contains(c.id);
      if (!isMet) unmet.add(c);
    }
    return unmet;
  }

  bool _hasTrackDiscrepancy() {
    final unmet = _unmetCriteria();
    final hasUnmetA = unmet.any((c) => c.track == 'A');
    final hasUnmetB = unmet.any((c) => c.track == 'B');
    final metCriteria = gate.criteria
        .where((c) => !unmet.contains(c))
        .toList();
    final hasMetA = metCriteria.any((c) => c.track == 'A');
    final hasMetB = metCriteria.any((c) => c.track == 'B');
    return (hasUnmetA && hasMetB) || (hasUnmetB && hasMetA);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../content/gates/all_gates.dart';
import '../../core/theme/tokens.dart';
import 'gate_provider.dart';

/// Landing screen for a gate assessment.
///
/// Shows the gate description, lists the number of criteria, and
/// routes the user to the evaluation screen when they are ready.
class GateScreen extends ConsumerWidget {
  const GateScreen({super.key, required this.gateNumber});

  final int gateNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gate = gateForNumber(gateNumber);
    final gateStateAsync = ref.watch(gateStateProvider(gateNumber));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Gate $gateNumber')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(spaceLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Gate header ────────────────────────────────────────────────
            if (gate.isCritical)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: spaceSm, vertical: 4),
                margin: const EdgeInsets.only(bottom: spaceMd),
                decoration: BoxDecoration(
                  color: errorRed.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: errorRed.withValues(alpha: 0.4)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.warning_amber_rounded,
                        size: 14, color: errorRed),
                    const SizedBox(width: 4),
                    Text(
                      'CRITICAL GATE',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: errorRed,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),

            Text(
              'Phase ${gate.fromPhase} → ${gate.toPhase}',
              style: theme.textTheme.labelSmall?.copyWith(
                color: primaryTeal,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: spaceXs),
            Text(gate.name, style: theme.textTheme.headlineSmall),
            const SizedBox(height: spaceMd),
            Text(gate.description, style: theme.textTheme.bodyMedium),
            const SizedBox(height: spaceLg),

            // ── Criteria summary ───────────────────────────────────────────
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(spaceMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CRITERIA',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: primaryTeal,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: spaceSm),
                    ...gate.criteria.map(
                      (c) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              c.blockingIfFailed
                                  ? Icons.block
                                  : Icons.radio_button_unchecked,
                              size: 14,
                              color: c.blockingIfFailed
                                  ? errorRed
                                  : onSurfaceMuted,
                            ),
                            const SizedBox(width: spaceSm),
                            Expanded(
                              child: Text(
                                c.description,
                                style: theme.textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: spaceLg),

            // ── Previous attempt note ──────────────────────────────────────
            gateStateAsync.when(
              data: (gs) {
                if (gs != null && gs.attemptCount > 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Previous attempts: ${gs.attemptCount}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: onSurfaceMuted,
                        ),
                      ),
                      const SizedBox(height: spaceLg),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),

            // ── Critical gate warning ──────────────────────────────────────
            if (gate.isCritical) ...[
              Container(
                padding: const EdgeInsets.all(spaceMd),
                decoration: BoxDecoration(
                  color: errorRed.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border:
                      Border.all(color: errorRed.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Before you proceed:',
                      style: theme.textTheme.labelSmall
                          ?.copyWith(color: errorRed),
                    ),
                    const SizedBox(height: spaceXs),
                    Text(
                      'Layer 3 involves deliberate self-modification. '
                      'This gate requires PHQ-9 ≤ 9 and the absence of '
                      'all crisis indicators. Both are hard blocks — not hints. '
                      'If you are experiencing significant distress, do not attempt this gate.',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: spaceLg),
            ],

            // ── Begin button ───────────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.assignment_outlined),
                label: const Text('Begin Gate Assessment'),
                onPressed: () =>
                    context.go('/gate/$gateNumber/evaluate'),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

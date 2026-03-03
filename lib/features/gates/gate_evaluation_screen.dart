import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../content/gates/gate_model.dart';
import '../../services/gate_evaluator/gate_evaluator_service.dart';
import '../../core/theme/tokens.dart';
import 'gate_provider.dart';
import 'widgets/criterion_row.dart';
import 'widgets/phq9_block_banner.dart';

/// Step-through evaluation screen for a gate.
///
/// On load it runs the auto evaluation and displays all criteria.
/// Manual and semiAuto criteria show checkboxes the user must tick.
/// The submit button is enabled only when [GateEvalState.allSatisfied] is true.
class GateEvaluationScreen extends ConsumerStatefulWidget {
  const GateEvaluationScreen({super.key, required this.gateNumber});

  final int gateNumber;

  @override
  ConsumerState<GateEvaluationScreen> createState() =>
      _GateEvaluationScreenState();
}

class _GateEvaluationScreenState
    extends ConsumerState<GateEvaluationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(gateNotifierProvider(widget.gateNumber).notifier)
          .initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(gateNotifierProvider(widget.gateNumber));
    final gate = state.definition;
    final theme = Theme.of(context);

    // Navigate to result screen once submission is complete.
    ref.listen(gateNotifierProvider(widget.gateNumber), (prev, next) {
      if (!prev!.submitted && next.submitted) {
        context.go('/gate/${widget.gateNumber}/result');
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Gate ${widget.gateNumber} Assessment'),
        automaticallyImplyLeading: false,
      ),
      body: state.evaluating
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(spaceLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gate name + phase
                  Text(
                    'Phase ${gate.fromPhase} → ${gate.toPhase}: ${gate.name}',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: spaceSm),

                  // Legend
                  _Legend(),
                  const SizedBox(height: spaceLg),

                  // Error banner
                  if (state.error != null) ...[
                    Container(
                      padding: const EdgeInsets.all(spaceMd),
                      decoration: BoxDecoration(
                        color: errorRed.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Text(
                        state.error!,
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: errorRed),
                      ),
                    ),
                    const SizedBox(height: spaceMd),
                  ],

                  // Criteria list
                  ...gate.criteria.map((criterion) {
                    final evalResult = state.autoResults.firstWhere(
                      (r) => r.criterionId == criterion.id,
                      orElse: () => CriterionEvalResult(
                        criterionId: criterion.id,
                        autoStatus: CriterionAutoStatus.notEvaluated,
                      ),
                    );
                    return CriterionRow(
                      criterion: criterion,
                      evalResult: evalResult,
                      confirmed: state.confirmedIds
                          .contains(criterion.id),
                      onToggle:
                          criterion.criterionType != GateCriterionType.auto
                              ? () => ref
                                  .read(gateNotifierProvider(
                                          widget.gateNumber)
                                      .notifier)
                                  .toggleConfirm(criterion.id)
                              : null,
                    );
                  }),

                  const SizedBox(height: spaceLg),

                  // PHQ-9 hard block banner (Gate 7 only)
                  if (state.hasHardBlock && widget.gateNumber == 7) ...[
                    Phq9BlockBanner(score: _extractPHQ9Score(state)),
                    const SizedBox(height: spaceLg),
                  ],

                  // Submit / block button
                  if (state.hasHardBlock)
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon: Icon(Icons.block, color: errorRed),
                        label: Text(
                          'Gate blocked — resolve hard blocks first',
                          style: TextStyle(color: errorRed),
                        ),
                        onPressed: null,
                      ),
                    )
                  else
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state.allSatisfied && !state.submitting
                            ? () => ref
                                .read(gateNotifierProvider(
                                        widget.gateNumber)
                                    .notifier)
                                .submit()
                            : null,
                        child: state.submitting
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2),
                              )
                            : Text(
                                state.allSatisfied
                                    ? 'Submit Assessment'
                                    : 'Complete all criteria to submit',
                              ),
                      ),
                    ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
    );
  }

  int? _extractPHQ9Score(GateEvalState state) {
    final r = state.autoResults.firstWhere(
      (r) => r.criterionId == 'g7_phq9',
      orElse: () => const CriterionEvalResult(
        criterionId: '',
        autoStatus: CriterionAutoStatus.noData,
      ),
    );
    if (r.displayValue == null) return null;
    final match = RegExp(r'Score: (\d+)').firstMatch(r.displayValue!);
    return match != null ? int.tryParse(match.group(1)!) : null;
  }
}

class _Legend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Wrap(
      spacing: spaceMd,
      runSpacing: spaceXs,
      children: [
        _LegendItem(
            icon: Icons.check_circle, color: gatePassGreen, label: 'Pass'),
        _LegendItem(icon: Icons.cancel, color: errorRed, label: 'Fail'),
        _LegendItem(
            icon: Icons.radio_button_unchecked,
            color: onSurfaceMuted,
            label: 'Not assessed / awaiting'),
        _LegendItem(
            icon: Icons.check_box_outline_blank,
            color: onSurfaceMuted,
            label: 'Confirm required'),
      ].map((w) => w).toList(),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({
    required this.icon,
    required this.color,
    required this.label,
  });

  final IconData icon;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(color: onSurfaceMuted),
        ),
      ],
    );
  }
}

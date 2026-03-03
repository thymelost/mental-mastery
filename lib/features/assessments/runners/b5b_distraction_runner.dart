import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../content/assessments/assessment_model.dart';
import '../../../core/theme/tokens.dart';
import 'runner_widgets.dart';

/// B5b Distraction Resistance Assessment runner.
/// Records unrecovered and recovered drifts across 3 distractor environments.
class B5bDistractionRunner extends StatefulWidget {
  const B5bDistractionRunner({
    super.key,
    required this.assessment,
    required this.onComplete,
  });

  final AssessmentContent assessment;
  final AssessmentCompleteCallback onComplete;

  @override
  State<B5bDistractionRunner> createState() => _B5bDistractionRunnerState();
}

class _B5bDistractionRunnerState extends State<B5bDistractionRunner> {
  static const _environments = ['Auditory', 'Visual', 'Internal'];
  static const _envDescriptions = [
    'Mild ambient noise (coffee shop, public transit, TV on low)',
    'Busy/visually complex environment (cluttered workspace, outdoor with movement)',
    'Deliberately recall a mild pending concern at the start, then maintain focus',
  ];

  final List<int> _unrecovered = [0, 0, 0];
  final List<int> _recovered = [0, 0, 0];
  final List<String?> _customEnv = [null, null, null];
  String? _error;

  bool get _allFilled => true; // All default to 0 which is valid.

  void _submit() {
    final maxUnrecovered = _unrecovered.reduce((a, b) => a > b ? a : b);
    final rawScores = <String, dynamic>{};
    for (var i = 0; i < 3; i++) {
      rawScores['session${i + 1}_env'] =
          _customEnv[i] ?? _environments[i];
      rawScores['session${i + 1}_unrecovered'] = _unrecovered[i];
      rawScores['session${i + 1}_recovered'] = _recovered[i];
      rawScores['session${i + 1}_pass'] = _unrecovered[i] <= 2;
    }
    setState(() => _error = null);
    widget.onComplete(rawScores, maxUnrecovered.toDouble(), null);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(spaceLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InstructionCard(steps: const [
            'Maintain focused attention on a single object (breath, body region, or neutral visual) '
                'for 5 continuous minutes per session.',
            'Unrecovered drifts: attention left the object for > 30 seconds without self-initiated return.',
            'Recovered drifts: attention left but returned within 30 seconds — do NOT count against threshold.',
            'Use 3 distinct environments as described below.',
          ]),
          const SizedBox(height: spaceLg),

          ...List.generate(3, (i) {
            final sessionPassed = _unrecovered[i] <= 2;
            return Card(
              margin: const EdgeInsets.only(bottom: spaceMd),
              child: Padding(
                padding: const EdgeInsets.all(spaceMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Session ${i + 1} — ${_environments[i]}',
                            style: theme.textTheme.titleSmall,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: sessionPassed
                                ? primaryTeal.withValues(alpha: 0.15)
                                : surfaceVariantDark,
                            borderRadius: BorderRadius.circular(radiusPill),
                          ),
                          child: Text(
                            sessionPassed ? 'PASS' : 'FAIL',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: sessionPassed ? primaryTeal : onSurfaceMuted,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _envDescriptions[i],
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: onSurfaceMuted),
                    ),
                    const SizedBox(height: spaceMd),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Unrecovered drifts',
                                  style: theme.textTheme.bodySmall),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    iconSize: 18,
                                    onPressed: _unrecovered[i] > 0
                                        ? () => setState(
                                            () => _unrecovered[i]--)
                                        : null,
                                  ),
                                  Text(
                                    '${_unrecovered[i]}',
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      fontFamily: 'RobotoMono',
                                      color: _unrecovered[i] <= 2
                                          ? primaryTeal
                                          : errorRed,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    iconSize: 18,
                                    onPressed: () => setState(
                                        () => _unrecovered[i]++),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Recovered drifts',
                                  style: theme.textTheme.bodySmall),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    iconSize: 18,
                                    onPressed: _recovered[i] > 0
                                        ? () => setState(
                                            () => _recovered[i]--)
                                        : null,
                                  ),
                                  Text(
                                    '${_recovered[i]}',
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      fontFamily: 'RobotoMono',
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    iconSize: 18,
                                    onPressed: () => setState(
                                        () => _recovered[i]++),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),

          ThresholdCard(
            text: 'Phase 2 exit: ≤ 2 unrecovered drifts per session, '
                'across ≥ 3 sessions in distinct environments.',
          ),
          const SizedBox(height: spaceLg),

          ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryTeal,
              foregroundColor: Colors.black,
              minimumSize: const Size.fromHeight(48),
            ),
            child: const Text('Save Result'),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

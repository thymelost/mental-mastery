import 'package:flutter/material.dart';

import '../../../content/assessments/assessment_model.dart';
import '../../../core/theme/tokens.dart';
import 'runner_widgets.dart';

/// B8 Load-Condition Assessment runner.
/// 6-skill × 5-condition (rested + 4 load types) rating matrix.
/// Condition D (physiological arousal) is required for the L2→L3 gate.
class B8LoadMatrixRunner extends StatefulWidget {
  const B8LoadMatrixRunner({
    super.key,
    required this.assessment,
    required this.onComplete,
  });

  final AssessmentContent assessment;
  final AssessmentCompleteCallback onComplete;

  @override
  State<B8LoadMatrixRunner> createState() => _B8LoadMatrixRunnerState();
}

class _B8LoadMatrixRunnerState extends State<B8LoadMatrixRunner> {
  static const _skills = [
    'A2.1 Meta-Attention',
    'A2.2 Dual Presence',
    'C2.1 Thought Observation',
    'C2.6 Narrative Monitoring',
    'B2.1 Self-Other Distinction',
    'B2.3 Value Anchoring',
  ];

  static const _conditions = [
    'Rested',
    'Cond A\n(Cognitive)',
    'Cond B\n(Emotional)',
    'Cond C\n(Social)',
    'Cond D\n(Physiological)',
  ];

  // [condition_index][skill_index] = 0–10 value
  final List<List<double>> _ratings =
      List.generate(5, (_) => List.generate(6, (_) => 5.0));

  void _submit() {
    final rawScores = <String, dynamic>{};
    final conditionMeans = <String, double>{};

    for (var c = 0; c < 5; c++) {
      final label = ['rested', 'condA', 'condB', 'condC', 'condD'][c];
      final skillMap = <String, double>{};
      double sum = 0;
      for (var s = 0; s < 6; s++) {
        skillMap[_skills[s]] = _ratings[c][s];
        sum += _ratings[c][s];
        rawScores['${label}_skill${s + 1}'] = _ratings[c][s];
      }
      final mean = sum / 6;
      conditionMeans[label] = mean;
      rawScores['${label}_mean'] = mean.toStringAsFixed(2);
    }

    final restedMean = conditionMeans['rested'] ?? 1;
    // Retention = average of condA/B/C/D means as % of rested
    final retentionPct = restedMean == 0
        ? 0.0
        : ((['condA', 'condB', 'condC', 'condD']
                .map((k) => conditionMeans[k] ?? 0)
                .reduce((a, b) => a + b) /
            4) /
            restedMean *
            100);

    widget.onComplete(
      rawScores,
      retentionPct,
      conditionMeans
          .map((k, v) => MapEntry(k, v)),
    );
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
            'Administer 4 conditions on SEPARATE occasions (not the same day).',
            'Cond A: Within 15 min of a cognitively demanding task. Do not rest first.',
            'Cond B: Within 30 min of a mild-moderate emotional event (arousal 4–6).',
            'Cond C: Within 15 min of completing a significant social interaction.',
            'Cond D: Within 5 min of brief vigorous exercise (5 min brisk walking/stairs) OR within 3 min of cold water face immersion (30 sec). HR must be visibly elevated above resting. Required for L2→L3 gate.',
            'Establish rested baseline in a calm state before running conditions.',
            'Rate each skill 0–10 for each condition.',
          ]),
          const SizedBox(height: spaceMd),

          // Condition D HR verification panel.
          Text(
            'CONDITION D — HR MONITOR (OPTIONAL)',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: primaryTeal,
                  letterSpacing: 1.1,
                ),
          ),
          const SizedBox(height: spaceXs),
          Text(
            'Connect an HR monitor to confirm your heart rate is elevated above '
            'resting before rating Condition D skills.',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: onSurfaceMuted),
          ),
          const SizedBox(height: spaceSm),
          const HrScanPanel(),
          const SizedBox(height: spaceLg),

          Text(
            'Skill ratings (0 = offline, 5 = partial, 10 = full)',
            style: theme.textTheme.labelLarge,
          ),
          const SizedBox(height: spaceSm),

          ..._skills.asMap().entries.map((skillEntry) {
            final s = skillEntry.key;
            final skillName = skillEntry.value;
            return Card(
              margin: const EdgeInsets.only(bottom: spaceMd),
              child: Padding(
                padding: const EdgeInsets.all(spaceMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(skillName, style: theme.textTheme.titleSmall),
                    const SizedBox(height: spaceSm),
                    ..._conditions.asMap().entries.map((condEntry) {
                      final c = condEntry.key;
                      final condLabel = condEntry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: spaceXs),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 80,
                              child: Text(
                                condLabel,
                                style: theme.textTheme.bodySmall,
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Expanded(
                              child: Slider(
                                value: _ratings[c][s],
                                min: 0,
                                max: 10,
                                divisions: 20,
                                activeColor: c == 0
                                    ? primaryTeal
                                    : primaryTeal.withValues(alpha: 0.6),
                                inactiveColor: surfaceVariantDark,
                                onChanged: (v) =>
                                    setState(() => _ratings[c][s] = v),
                              ),
                            ),
                            SizedBox(
                              width: 32,
                              child: Text(
                                _ratings[c][s].toStringAsFixed(1),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontFamily: 'RobotoMono',
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            );
          }),

          ThresholdCard(
            text: 'Full threshold (L2→L3 gate): mean ≥ 80% of rested baseline in ALL 4 conditions including Cond D (physiological arousal).\n'
                'Provisional (Phase 5): ≥ 80% in ≥ 2 conditions (Cond D attempted but not required to pass at threshold).',
          ),
          const SizedBox(height: spaceLg),

          ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryTeal,
              foregroundColor: Colors.black,
              minimumSize: const Size.fromHeight(48),
            ),
            child: const Text('Save Matrix'),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

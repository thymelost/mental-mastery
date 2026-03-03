import 'package:flutter/material.dart';

import '../../../content/assessments/assessment_model.dart';
import '../../../core/theme/tokens.dart';
import 'runner_widgets.dart';

/// B11 Calibration Honesty Check runner.
/// Self-rate vs. evidence-rate for all 41 framework skills.
class B11CalibrationRunner extends StatefulWidget {
  const B11CalibrationRunner({
    super.key,
    required this.assessment,
    required this.onComplete,
  });

  final AssessmentContent assessment;
  final AssessmentCompleteCallback onComplete;

  @override
  State<B11CalibrationRunner> createState() => _B11CalibrationRunnerState();
}

class _B11CalibrationRunnerState extends State<B11CalibrationRunner> {
  // Map of skillId → {self: 1–5, evidence: 1–5}
  final Map<String, Map<String, int>> _ratings = {};

  static const _layers = [
    (
      'Layer 1 — Foundational',
      [
        ('S1.1', 'Sensation Recognition', 'Body scan logs'),
        ('S1.2', 'Interoceptive Accuracy', 'HBD weekly scores'),
        ('S1.3', 'Physiological Baseline Mapping', 'Physiology journal 14-day review'),
        ('S1.4', 'Arousal Level Detection', 'Arousal crosscheck weekly data'),
        ('E1.1', 'Primary Emotion Identification', 'Emotion check-in log accuracy'),
        ('E1.2', 'Somatic-Emotion Mapping', 'Emotion-body map completeness'),
        ('E1.3', 'Emotional Vocabulary Expansion', 'Vocabulary audit count + granularity'),
        ('E1.4', 'Emotional Gradient Detection', 'Gradient log % of entries ≤ 4/10'),
        ('A1.1', 'Attention Sustaining', 'Session log duration + drift counts'),
        ('A1.2', 'Attention Directing', 'Directed vs. pulled discrimination %'),
        ('A1.3', 'Attention Recovery', 'Recovery latency trend in logs'),
        ('A1.4', 'Distraction Resistance', 'Distraction resistance session logs'),
        ('A1.5', 'Aperture Control', 'Aperture shifting practice log'),
      ]
    ),
    (
      'Layer 2 — Metacognitive',
      [
        ('A2.1', 'Meta-Attention', 'Probe assessment accuracy + latency'),
        ('A2.2', 'Dual Presence', 'Dual presence test scores'),
        ('C2.1', 'Thought Observation', 'SMS-Mind score; session logs'),
        ('C2.2', 'Cognitive State Labeling', 'Mode journal variety + accuracy'),
        ('C2.3', 'Process Awareness', 'Process journal specificity'),
        ('C2.4', 'Cognitive Load Sensing', 'Load check calibration data'),
        ('C2.5', 'Assumption Detection', 'Assumption log real-time catch rate'),
        ('C2.6', 'Narrative Monitoring', 'Narrative catch real-time rate; RRS'),
        ('E2.1', 'Emotional Source Attribution', 'Source log attribution %'),
        ('E2.2', 'Emotional Contagion Awareness', 'Contagion log predictive accuracy'),
        ('E2.3', 'Affect-Cognition Coupling Detection', 'Decision review coupling rate'),
        ('B2.1', 'Self-Other Signal Distinction', 'Boundary challenge assessment'),
        ('B2.2', 'Incongruence Detection', 'Values conflict real-time detection'),
        ('B2.3', 'Value Anchoring Under Pressure', 'Pressure scenario return latency'),
        ('B2.4', 'Identity Stability Monitoring', 'Weekly review log consistency'),
      ]
    ),
    (
      'Layer 3 — Intentional Plasticity',
      [
        ('M3.1', 'Voluntary Relaxation', 'Relaxation pre/post arousal data'),
        ('M3.2', 'State Shifting', 'State shifting verification'),
        ('M3.3', 'Arousal Calibration', 'Pre-task calibration error log'),
        ('M3.4', 'Emotional Response Modification', 'Modification session logs'),
        ('P3.1', 'Personal Pattern Recognition', 'Pattern library completeness'),
        ('P3.2', 'Pattern Interruption', 'Interruption success rate log'),
        ('P3.3', 'Deliberate Reframing', 'Reframing exercise logs'),
        ('P3.4', 'Belief Examination', 'Belief review depth logs'),
        ('P3.5', 'Adaptive Flexibility', 'Flexibility log across situations'),
      ]
    ),
    (
      'Cross-layer — Integration & Resilience',
      [
        ('I1.1', 'Skill-Under-Load', 'B8 load-condition assessment'),
        ('I1.2', 'Recovery Time', 'Recovery time log'),
        ('I1.3', 'Calibration Honesty', 'This assessment (meta)'),
        ('I1.4', 'Practice Quality Monitoring', 'Session quality ratings'),
      ]
    ),
  ];

  void _setRating(String skillId, String type, int value) {
    setState(() {
      _ratings.putIfAbsent(skillId, () => {'self': 0, 'evidence': 0})[type] =
          value;
    });
  }

  void _submit() {
    final rawScores = <String, dynamic>{};
    double totalGap = 0;
    int ratedCount = 0;

    for (final entry in _ratings.entries) {
      final self = entry.value['self'] ?? 0;
      final evidence = entry.value['evidence'] ?? 0;
      final gap = evidence - self;
      rawScores[entry.key] = {
        'selfRate': self,
        'evidenceRate': evidence,
        'gap': gap,
      };
      if (self > 0 && evidence > 0) {
        totalGap += gap.abs();
        ratedCount++;
      }
    }

    final meanAbsGap = ratedCount == 0 ? 0.0 : totalGap / ratedCount;
    widget.onComplete(rawScores, meanAbsGap, null);
  }

  int get _totalRated =>
      _ratings.values.where((m) => m['self']! > 0 && m['evidence']! > 0).length;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        LinearProgressIndicator(
          value: _totalRated / 41,
          backgroundColor: surfaceVariantDark,
          color: primaryTeal,
          minHeight: 3,
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(spaceLg),
            children: [
              InstructionCard(steps: const [
                '1. SELF-RATE independently before reviewing any data.',
                '2. EVIDENCE-RATE: review your actual logged data for this skill.',
                '3. Gap = Evidence − Self. Positive = underestimate; negative = overestimate.',
                'Rate 1–5: 1=no ability, 2=beginning, 3=developing, 4=functional, 5=solid.',
              ]),
              const SizedBox(height: spaceLg),

              ..._layers.map((layer) {
                final layerName = layer.$1;
                final skills = layer.$2;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: spaceSm),
                      child: Text(
                        layerName.toUpperCase(),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: primaryTeal,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                    ...skills.map((skill) {
                      final id = skill.$1;
                      final name = skill.$2;
                      final dataSource = skill.$3;
                      final selfRating = _ratings[id]?['self'] ?? 0;
                      final evidenceRating = _ratings[id]?['evidence'] ?? 0;
                      final gap = evidenceRating - selfRating;

                      return Card(
                        margin: const EdgeInsets.only(bottom: spaceSm),
                        child: Padding(
                          padding: const EdgeInsets.all(spaceMd),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    id,
                                    style: theme.textTheme.labelSmall
                                        ?.copyWith(color: primaryTeal),
                                  ),
                                  const SizedBox(width: spaceSm),
                                  Expanded(
                                    child: Text(name,
                                        style: theme.textTheme.titleSmall),
                                  ),
                                  if (selfRating > 0 && evidenceRating > 0)
                                    Text(
                                      gap >= 0
                                          ? '+$gap'
                                          : '$gap',
                                      style: theme.textTheme.labelMedium
                                          ?.copyWith(
                                        fontFamily: 'RobotoMono',
                                        color: gap == 0
                                            ? primaryTeal
                                            : gap > 0
                                                ? Colors.blue
                                                : errorRed,
                                      ),
                                    ),
                                ],
                              ),
                              Text(
                                'Data: $dataSource',
                                style: theme.textTheme.bodySmall
                                    ?.copyWith(color: onSurfaceMuted),
                              ),
                              const SizedBox(height: spaceXs),
                              Row(
                                children: [
                                  Expanded(
                                    child: _RatingRow(
                                      label: 'Self',
                                      value: selfRating,
                                      onChanged: (v) =>
                                          _setRating(id, 'self', v),
                                    ),
                                  ),
                                  const SizedBox(width: spaceSm),
                                  Expanded(
                                    child: _RatingRow(
                                      label: 'Evidence',
                                      value: evidenceRating,
                                      onChanged: (v) =>
                                          _setRating(id, 'evidence', v),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: spaceMd),
                  ],
                );
              }),

              Text(
                '$_totalRated / 41 skills rated',
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: onSurfaceMuted),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: spaceSm),

              ThresholdCard(
                text: 'Score = mean absolute gap. Lower is more calibrated. '
                    'Target: mean absolute gap ≤ 1.0.',
              ),
              const SizedBox(height: spaceLg),

              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryTeal,
                  foregroundColor: Colors.black,
                  minimumSize: const Size.fromHeight(48),
                ),
                child: const Text('Save Calibration Check'),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }
}

class _RatingRow extends StatelessWidget {
  const _RatingRow({required this.label, required this.value, required this.onChanged});
  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.bodySmall),
        const SizedBox(height: 2),
        Row(
          children: List.generate(5, (i) {
            final v = i + 1;
            final selected = value == v;
            return Expanded(
              child: GestureDetector(
                onTap: () => onChanged(v),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  height: 28,
                  decoration: BoxDecoration(
                    color: selected ? primaryTeal : surfaceVariantDark,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$v',
                    style: TextStyle(
                      fontSize: 11,
                      color: selected ? Colors.black : onSurfaceMuted,
                      fontFamily: 'RobotoMono',
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

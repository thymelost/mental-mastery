import 'package:flutter/material.dart';

import '../../../content/assessments/assessment_model.dart';
import '../../../core/theme/tokens.dart';

/// Paged Likert questionnaire runner.
/// Handles TAS-20, FFMQ Observing, PHQ-9, and DASS-21.
class QuestionnaireRunner extends StatefulWidget {
  const QuestionnaireRunner({
    super.key,
    required this.assessment,
    required this.definition,
    required this.onComplete,
  });

  final AssessmentContent assessment;
  final QuestionnaireDefinition definition;
  final AssessmentCompleteCallback onComplete;

  @override
  State<QuestionnaireRunner> createState() => _QuestionnaireRunnerState();
}

class _QuestionnaireRunnerState extends State<QuestionnaireRunner> {
  // 1-indexed item number → 1-indexed response value (1..N)
  final Map<int, int> _responses = {};

  bool get _allAnswered =>
      _responses.length == widget.definition.items.length;

  void _score() {
    final def = widget.definition;
    final n = def.scaleLabels.length; // scale max (e.g. 5 or 4)
    final rawScores = <String, dynamic>{};
    double total = 0;

    for (var i = 0; i < def.items.length; i++) {
      final itemNum = i + 1;
      final raw = _responses[itemNum] ?? 0;
      final item = def.items[i];
      final scored = (item.reversed && def.reverseMax != null)
          ? (def.reverseMax! - raw)
          : raw;
      rawScores['q$itemNum'] = raw;
      total += scored;
    }

    // Compute subscale scores.
    final subscaleScores = <String, double>{};
    for (final entry in def.subscales.entries) {
      final subscaleItems = entry.value;
      double sum = 0;
      for (final itemNum in subscaleItems) {
        final raw = _responses[itemNum] ?? 0;
        final item = def.items[itemNum - 1];
        final scored = (item.reversed && def.reverseMax != null)
            ? (def.reverseMax! - raw)
            : raw;
        sum += scored;
      }
      subscaleScores[entry.key] = sum * def.subscaleMultiplier;
    }

    rawScores['_scale_max'] = n;
    widget.onComplete(
      rawScores,
      total,
      subscaleScores.isEmpty ? null : subscaleScores,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final def = widget.definition;

    return Column(
      children: [
        // ── Progress bar ───────────────────────────────────────────────
        LinearProgressIndicator(
          value: _responses.length / def.items.length,
          backgroundColor: surfaceVariantDark,
          color: primaryTeal,
          minHeight: 3,
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(spaceLg),
            children: [
              // Instruction
              Card(
                color: surfaceVariantDark,
                child: Padding(
                  padding: const EdgeInsets.all(spaceMd),
                  child: Text(
                    def.instruction,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ),
              const SizedBox(height: spaceLg),

              // Scale legend
              _ScaleLegend(labels: def.scaleLabels),
              const SizedBox(height: spaceLg),

              // Items
              ...def.items.asMap().entries.map((entry) {
                final itemNum = entry.key + 1;
                final item = entry.value;
                return _ItemTile(
                  number: itemNum,
                  text: item.text,
                  scaleCount: def.scaleLabels.length,
                  selected: _responses[itemNum],
                  onSelected: (val) {
                    setState(() => _responses[itemNum] = val);
                  },
                );
              }),

              const SizedBox(height: spaceLg),
              // Submit
              if (!_allAnswered)
                Text(
                  '${def.items.length - _responses.length} items remaining',
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: onSurfaceMuted),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: spaceSm),
              ElevatedButton(
                onPressed: _allAnswered ? _score : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryTeal,
                  foregroundColor: Colors.black,
                  minimumSize: const Size.fromHeight(48),
                ),
                child: const Text('Submit & Score'),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Scale legend ─────────────────────────────────────────────────────────────

class _ScaleLegend extends StatelessWidget {
  const _ScaleLegend({required this.labels});
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: labels.asMap().entries.map((e) {
        return Expanded(
          child: Column(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: onSurfaceMuted),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${e.key + 1}',
                  style: theme.textTheme.labelMedium
                      ?.copyWith(fontFamily: 'RobotoMono'),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                e.value,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: onSurfaceMuted, fontSize: 9),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ─── Item tile ────────────────────────────────────────────────────────────────

class _ItemTile extends StatelessWidget {
  const _ItemTile({
    required this.number,
    required this.text,
    required this.scaleCount,
    required this.selected,
    required this.onSelected,
  });

  final int number;
  final String text;
  final int scaleCount;
  final int? selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: spaceLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number. $text',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: spaceXs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(scaleCount, (i) {
              final val = i + 1;
              final isSelected = selected == val;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onSelected(val),
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 2),
                    height: 36,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? primaryTeal
                          : surfaceVariantDark,
                      borderRadius:
                          BorderRadius.circular(radiusMd),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$val',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: isSelected ? Colors.black : onSurfaceMuted,
                        fontFamily: 'RobotoMono',
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

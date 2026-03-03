import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../content/assessments/assessment_model.dart';
import '../../../core/theme/tokens.dart';
import 'runner_widgets.dart';

/// B7 Dual Presence Performance Test runner.
/// Guided reading with concurrent internal monitoring; records comprehension scores.
class B7DualPresenceRunner extends StatefulWidget {
  const B7DualPresenceRunner({
    super.key,
    required this.assessment,
    required this.onComplete,
  });

  final AssessmentContent assessment;
  final AssessmentCompleteCallback onComplete;

  @override
  State<B7DualPresenceRunner> createState() => _B7DualPresenceRunnerState();
}

class _B7DualPresenceRunnerState extends State<B7DualPresenceRunner> {
  final _part1Ctrl = TextEditingController();
  final _part2Ctrl = TextEditingController();
  final List<TextEditingController> _reportCtrls =
      List.generate(5, (_) => TextEditingController());
  String? _error;

  @override
  void dispose() {
    _part1Ctrl.dispose();
    _part2Ctrl.dispose();
    for (final c in _reportCtrls) c.dispose();
    super.dispose();
  }

  void _submit() {
    final p1 = int.tryParse(_part1Ctrl.text.trim());
    final p2 = int.tryParse(_part2Ctrl.text.trim());
    if (p1 == null || p1 < 0 || p1 > 5) {
      setState(() => _error = 'Part 1 score must be 0–5.');
      return;
    }
    if (p2 == null || p2 < 0 || p2 > 5) {
      setState(() => _error = 'Part 2 score must be 0–5.');
      return;
    }
    setState(() => _error = null);

    final reports = _reportCtrls.map((c) => c.text.trim()).toList();
    final specificReports =
        reports.where((r) => r.length > 10 && !RegExp(r'^(fine|normal|ok|good)$', caseSensitive: false).hasMatch(r)).length;
    final distinctStates = reports.toSet().length;
    final ratio = p1 == 0 ? 0.0 : (p2 / p1) * 100;

    widget.onComplete(
      {
        'part1Score': p1,
        'part2Score': p2,
        'comprehensionRatioPct': ratio.toStringAsFixed(1),
        'specificReports': specificReports,
        'distinctStates': distinctStates,
        'stateReports': reports,
      },
      ratio,
      {
        'comprehensionRatio%': ratio,
        'specificReports': specificReports.toDouble(),
        'distinctStates': distinctStates.toDouble(),
      },
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
            'Part 1 (15 min): Read the first half of a 400–600 word text normally. '
                'Write 5 comprehension questions and score yourself (0–5).',
            'Part 2 (15 min): Read the second half while maintaining concurrent internal monitoring. '
                'Every 3 minutes, an alarm sounds — write a 1-sentence state report each time.',
            'Score Part 2 comprehension (0–5), then enter all results below.',
          ]),
          const SizedBox(height: spaceLg),

          Text('Part 1 comprehension score (0–5)',
              style: theme.textTheme.labelLarge),
          const SizedBox(height: spaceXs),
          TextField(
            controller: _part1Ctrl,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: runnerInputDecoration('e.g. 5').copyWith(errorText: _error),
            style: theme.textTheme.bodyLarge?.copyWith(fontFamily: 'RobotoMono'),
          ),
          const SizedBox(height: spaceMd),

          Text('Part 2 comprehension score (0–5)',
              style: theme.textTheme.labelLarge),
          const SizedBox(height: spaceXs),
          TextField(
            controller: _part2Ctrl,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: runnerInputDecoration('e.g. 4'),
            style: theme.textTheme.bodyLarge?.copyWith(fontFamily: 'RobotoMono'),
          ),
          const SizedBox(height: spaceLg),

          Text('Internal state reports (5 alarm probes)',
              style: theme.textTheme.labelLarge),
          Text(
            'Paste or type each state report. '
            'Format: "Emotional tone: ___, Arousal: ___, Attention quality: ___"',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: spaceSm),
          ...List.generate(5, (i) => Padding(
                padding: const EdgeInsets.only(bottom: spaceSm),
                child: TextField(
                  controller: _reportCtrls[i],
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: 'Probe ${i + 1}',
                    filled: true,
                    fillColor: surfaceVariantDark,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(radiusMd),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              )),

          ThresholdCard(
            text: 'Threshold: Part 2 / Part 1 ≥ 85% · ≥ 4 of 5 specific reports · '
                '≥ 2 distinct states across 5 probes.',
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../content/assessments/assessment_model.dart';
import '../../../core/theme/tokens.dart';
import 'runner_widgets.dart';

/// B1 Somatic Baseline Assessment runner.
/// Records sensation count, physical-language percentage, and blank body regions.
class B1BodyMapRunner extends StatefulWidget {
  const B1BodyMapRunner({
    super.key,
    required this.assessment,
    required this.onComplete,
  });

  final AssessmentContent assessment;
  final AssessmentCompleteCallback onComplete;

  @override
  State<B1BodyMapRunner> createState() => _B1BodyMapRunnerState();
}

class _B1BodyMapRunnerState extends State<B1BodyMapRunner> {
  final _sensationCountCtrl = TextEditingController();
  final _blankRegionsCtrl = TextEditingController();
  double _physicalLangPct = 50;
  String? _error;

  @override
  void dispose() {
    _sensationCountCtrl.dispose();
    _blankRegionsCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final count = int.tryParse(_sensationCountCtrl.text.trim());
    final blank = int.tryParse(_blankRegionsCtrl.text.trim()) ?? 0;
    if (count == null || count < 0) {
      setState(() => _error = 'Enter a valid sensation count.');
      return;
    }
    setState(() => _error = null);

    widget.onComplete(
      {
        'sensationCount': count,
        'physicalLangPct': _physicalLangPct.round(),
        'blankRegions': blank,
      },
      count.toDouble(),
      {'physicalLanguage%': _physicalLangPct},
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
          InstructionCard(
            steps: const [
              'Lie on your back on a firm surface. Set a timer for 10 minutes.',
              'Perform a slow body scan from head to feet. When you detect a '
                  'sensation, note it.',
              'For each sensation, record: (a) body location, (b) physical quality '
                  'using only physical terms (pressure, heat, tension…), '
                  '(c) intensity 1–5.',
              'After 10 minutes, take 5 minutes to review and complete your record.',
              'Return here to enter your scores.',
            ],
          ),
          const SizedBox(height: spaceLg),

          Text('Distinct sensations detected', style: theme.textTheme.labelLarge),
          const SizedBox(height: spaceXs),
          TextField(
            controller: _sensationCountCtrl,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: runnerInputDecoration('e.g. 7').copyWith(errorText: _error),
            style: theme.textTheme.bodyLarge
                ?.copyWith(fontFamily: 'RobotoMono'),
          ),
          const SizedBox(height: spaceMd),

          Text(
            'Physical language (%)',
            style: theme.textTheme.labelLarge,
          ),
          Text(
            'What % of sensations were described in purely physical terms '
            '(vs. emotional/interpretive like "tense", "nervous")?',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: spaceXs),
          Row(
            children: [
              Text('0%', style: theme.textTheme.bodySmall),
              Expanded(
                child: Slider(
                  value: _physicalLangPct,
                  min: 0,
                  max: 100,
                  divisions: 20,
                  activeColor: primaryTeal,
                  inactiveColor: surfaceVariantDark,
                  onChanged: (v) => setState(() => _physicalLangPct = v),
                ),
              ),
              Text('100%', style: theme.textTheme.bodySmall),
            ],
          ),
          Center(
            child: Text(
              '${_physicalLangPct.round()}%',
              style: theme.textTheme.titleLarge?.copyWith(
                color: primaryTeal,
                fontFamily: 'RobotoMono',
              ),
            ),
          ),
          const SizedBox(height: spaceMd),

          Text('Blank body regions', style: theme.textTheme.labelLarge),
          Text(
            'How many regions detected no sensation at all?',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: spaceXs),
          TextField(
            controller: _blankRegionsCtrl,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: runnerInputDecoration('e.g. 3'),
            style: theme.textTheme.bodyLarge
                ?.copyWith(fontFamily: 'RobotoMono'),
          ),
          const SizedBox(height: spaceMd),

          // Threshold reminder
          ThresholdCard(
            text: 'Phase 1 exit: ≥ 5 distinct sensations, ≥ 80% physical language, '
                'across 3 consecutive sessions in the same week.',
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


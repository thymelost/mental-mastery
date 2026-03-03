import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../content/assessments/assessment_model.dart';
import '../../../core/theme/tokens.dart';
import 'runner_widgets.dart';

/// B4 Emotional Vocabulary Audit runner.
/// Captures word count, granularity score, and valence balance.
class B4VocabRunner extends StatefulWidget {
  const B4VocabRunner({
    super.key,
    required this.assessment,
    required this.onComplete,
  });

  final AssessmentContent assessment;
  final AssessmentCompleteCallback onComplete;

  @override
  State<B4VocabRunner> createState() => _B4VocabRunnerState();
}

class _B4VocabRunnerState extends State<B4VocabRunner> {
  final _countCtrl = TextEditingController();
  final _posCtrl = TextEditingController();
  final _negCtrl = TextEditingController();
  final _neutCtrl = TextEditingController();
  double _granularity = 3.0;
  String? _error;

  @override
  void dispose() {
    _countCtrl.dispose();
    _posCtrl.dispose();
    _negCtrl.dispose();
    _neutCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final count = int.tryParse(_countCtrl.text.trim());
    if (count == null || count < 0) {
      setState(() => _error = 'Enter the total word count.');
      return;
    }
    setState(() => _error = null);

    final pos = int.tryParse(_posCtrl.text.trim()) ?? 0;
    final neg = int.tryParse(_negCtrl.text.trim()) ?? 0;
    final neut = int.tryParse(_neutCtrl.text.trim()) ?? 0;

    widget.onComplete(
      {
        'wordCount': count,
        'granularityScore': _granularity.round(),
        'positiveCount': pos,
        'negativeCount': neg,
        'neutralCount': neut,
      },
      count.toDouble(),
      {'granularity': _granularity},
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
            'Set a timer for 10 minutes.',
            'Without any reference, write every distinct emotional state you can name.',
            'States must be genuinely different in feel/function — not mere synonyms.',
            'After 10 minutes, count your list and score it on the dimensions below.',
            'Return here to enter your scores.',
          ]),
          const SizedBox(height: spaceLg),

          Text('Total distinct states named', style: theme.textTheme.labelLarge),
          const SizedBox(height: spaceXs),
          TextField(
            controller: _countCtrl,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: runnerInputDecoration('e.g. 24').copyWith(errorText: _error),
            style: theme.textTheme.bodyLarge?.copyWith(fontFamily: 'RobotoMono'),
          ),
          const SizedBox(height: spaceMd),

          Text('Granularity (1–5)', style: theme.textTheme.labelLarge),
          Text(
            '1 = only basic categories (happy, sad, angry) · '
            '3 = meaningfully differentiated · '
            '5 = nuanced across valences, intensity, and social dimensions',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: spaceXs),
          Row(
            children: [
              Text('1', style: theme.textTheme.bodySmall),
              Expanded(
                child: Slider(
                  value: _granularity,
                  min: 1,
                  max: 5,
                  divisions: 4,
                  activeColor: primaryTeal,
                  inactiveColor: surfaceVariantDark,
                  onChanged: (v) => setState(() => _granularity = v),
                ),
              ),
              Text('5', style: theme.textTheme.bodySmall),
            ],
          ),
          Center(
            child: Text(
              _granularity.round().toString(),
              style: theme.textTheme.titleLarge?.copyWith(
                color: primaryTeal,
                fontFamily: 'RobotoMono',
              ),
            ),
          ),
          const SizedBox(height: spaceMd),

          Text('Valence balance (optional)', style: theme.textTheme.labelLarge),
          const SizedBox(height: spaceXs),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Positive', style: theme.textTheme.bodySmall),
                    const SizedBox(height: 4),
                    TextField(
                      controller: _posCtrl,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: runnerInputDecoration('0'),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: spaceSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Negative', style: theme.textTheme.bodySmall),
                    const SizedBox(height: 4),
                    TextField(
                      controller: _negCtrl,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: runnerInputDecoration('0'),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: spaceSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Neutral', style: theme.textTheme.bodySmall),
                    const SizedBox(height: 4),
                    TextField(
                      controller: _neutCtrl,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: runnerInputDecoration('0'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: spaceMd),

          ThresholdCard(
            text: 'Phase 2 exit: ≥ 20 distinct states, granularity ≥ 3.',
          ),
          const SizedBox(height: spaceLg),

          ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryTeal,
              foregroundColor: Colors.black,
              minimumSize: const Size.fromHeight(48),
            ),
            child: const Text('Save Audit'),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

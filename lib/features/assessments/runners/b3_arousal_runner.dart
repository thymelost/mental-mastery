import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../content/assessments/assessment_model.dart';
import '../../../core/theme/tokens.dart';
import '../../../core/widgets/arousal_slider.dart';
import 'runner_widgets.dart';

/// B3 Arousal Calibration Crosscheck runner.
/// Captures subjective arousal estimate vs. actual HR for calibration tracking.
class B3ArousalRunner extends StatefulWidget {
  const B3ArousalRunner({
    super.key,
    required this.assessment,
    required this.onComplete,
  });

  final AssessmentContent assessment;
  final AssessmentCompleteCallback onComplete;

  @override
  State<B3ArousalRunner> createState() => _B3ArousalRunnerState();
}

class _B3ArousalRunnerState extends State<B3ArousalRunner> {
  double _subjectiveArousal = 5.0;
  final _hrCtrl = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _hrCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final hr = double.tryParse(_hrCtrl.text.trim());
    if (hr == null || hr <= 0) {
      setState(() => _error = 'Enter your actual measured HR.');
      return;
    }
    setState(() => _error = null);

    // Rough expected arousal from HR (individual calibration improves over time).
    final expectedRange = hr < 60
        ? '0–2'
        : hr < 70
            ? '2–4'
            : hr < 80
                ? '4–6'
                : hr < 95
                    ? '6–8'
                    : '8–10';

    widget.onComplete(
      {
        'subjectiveArousal': _subjectiveArousal,
        'actualHr': hr,
        'expectedArousalRange': expectedRange,
      },
      _subjectiveArousal,
      null,
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
            'Before measuring HR, estimate your current arousal (0–10).',
            'Sit quietly for 60 seconds. Do not try to change your state.',
            'Measure actual HR for 60 seconds.',
            'Record the pair below.',
          ]),
          const SizedBox(height: spaceLg),

          Text('Step 1 — Subjective arousal estimate',
              style: theme.textTheme.labelLarge),
          const SizedBox(height: spaceXs),
          ArousalSlider(
            value: _subjectiveArousal,
            onChanged: (v) => setState(() => _subjectiveArousal = v),
          ),
          const SizedBox(height: spaceLg),

          Text('Step 2 — Actual HR (bpm, measured after sitting 60 s)',
              style: theme.textTheme.labelLarge),
          const SizedBox(height: spaceXs),
          TextField(
            controller: _hrCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
            decoration: runnerInputDecoration('e.g. 74').copyWith(errorText: _error),
            style: theme.textTheme.bodyLarge?.copyWith(fontFamily: 'RobotoMono'),
          ),
          const SizedBox(height: spaceLg),

          ThresholdCard(
            text: 'Threshold: self-estimates within ±2 arousal points of HR-expected '
                'in ≥ 70% of weekly checks over 4 weeks.',
          ),
          const SizedBox(height: spaceLg),

          ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryTeal,
              foregroundColor: Colors.black,
              minimumSize: const Size.fromHeight(48),
            ),
            child: const Text('Save Crosscheck'),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

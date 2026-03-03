import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../content/assessments/assessment_model.dart';
import '../../../core/theme/tokens.dart';
import 'runner_widgets.dart';

/// B2 Heartbeat Detection Task runner.
/// Four intervals with expected vs. counted beats; computes mean accuracy.
class B2HbdRunner extends StatefulWidget {
  const B2HbdRunner({
    super.key,
    required this.assessment,
    required this.onComplete,
  });

  final AssessmentContent assessment;
  final AssessmentCompleteCallback onComplete;

  @override
  State<B2HbdRunner> createState() => _B2HbdRunnerState();
}

class _B2HbdRunnerState extends State<B2HbdRunner> {
  final _hrCtrl = TextEditingController();
  final _countCtrls = [
    TextEditingController(), // interval 1 (25s)
    TextEditingController(), // interval 2 (35s)
    TextEditingController(), // interval 3 (45s)
    TextEditingController(), // interval 4 (25s)
  ];
  final _deviceCtrls = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  bool _useDevice = false;
  String? _error;

  static const _intervals = [25, 35, 45, 25]; // seconds

  @override
  void dispose() {
    _hrCtrl.dispose();
    for (final c in _countCtrls) c.dispose();
    for (final c in _deviceCtrls) c.dispose();
    super.dispose();
  }

  void _submit() {
    final hr = double.tryParse(_hrCtrl.text.trim());
    if (hr == null || hr <= 0) {
      setState(() => _error = 'Enter a valid resting HR.');
      return;
    }
    final rawScores = <String, dynamic>{'restingHr': hr, 'usedDevice': _useDevice};
    double meanAcc = 0;
    final accList = <double>[];

    for (var i = 0; i < 4; i++) {
      final got = double.tryParse(_countCtrls[i].text.trim()) ?? 0;
      final expected = _useDevice
          ? (double.tryParse(_deviceCtrls[i].text.trim()) ?? 0)
          : (hr / 60.0) * _intervals[i];
      final acc = expected == 0
          ? 0.0
          : (1 - ((got - expected).abs() / expected)).clamp(0.0, 1.0);
      rawScores['i${i + 1}_got'] = got;
      rawScores['i${i + 1}_expected'] = expected.toStringAsFixed(1);
      rawScores['i${i + 1}_acc'] = (acc * 100).toStringAsFixed(1);
      accList.add(acc);
    }

    meanAcc = accList.reduce((a, b) => a + b) / accList.length;
    final meanPct = meanAcc * 100;
    rawScores['meanAccuracyPct'] = meanPct.toStringAsFixed(1);

    setState(() => _error = null);
    widget.onComplete(rawScores, meanPct, null);
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
            'Sit quietly. No caffeine within 90 minutes.',
            'Measure resting HR: count pulse at wrist for 60 seconds.',
            'Run 4 intervals (25s, 35s, 45s, 25s) with 30s rest between each.',
            'For each interval: count heartbeats felt internally (no touching). '
                'Write count immediately after each interval.',
            'Return here to enter your results.',
          ]),
          const SizedBox(height: spaceLg),

          Text('Resting HR (bpm)', style: theme.textTheme.labelLarge),
          const SizedBox(height: spaceXs),
          TextField(
            controller: _hrCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
            decoration: runnerInputDecoration('e.g. 72').copyWith(errorText: _error),
            style: theme.textTheme.bodyLarge?.copyWith(fontFamily: 'RobotoMono'),
          ),
          const SizedBox(height: spaceMd),

          Row(
            children: [
              Checkbox(
                value: _useDevice,
                activeColor: primaryTeal,
                onChanged: (v) => setState(() => _useDevice = v ?? false),
              ),
              Expanded(
                child: Text(
                  'Using an HR monitor (connect below to auto-fill resting HR '
                  'and enter device counts per interval)',
                  style: theme.textTheme.bodySmall,
                ),
              ),
            ],
          ),
          if (_useDevice) ...[
            const SizedBox(height: spaceSm),
            HrScanPanel(
              onHrChanged: (hr) {
                if (_hrCtrl.text.isEmpty) {
                  setState(() => _hrCtrl.text = '$hr');
                }
              },
            ),
          ],
          const SizedBox(height: spaceSm),

          ..._intervals.asMap().entries.map((e) {
            final i = e.key;
            final dur = e.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: spaceMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Interval ${i + 1} (${dur}s)',
                    style: theme.textTheme.labelMedium,
                  ),
                  const SizedBox(height: spaceXs),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _countCtrls[i],
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          decoration: runnerInputDecoration('Your count'),
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(fontFamily: 'RobotoMono'),
                        ),
                      ),
                      if (_useDevice) ...[
                        const SizedBox(width: spaceSm),
                        Expanded(
                          child: TextField(
                            controller: _deviceCtrls[i],
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            decoration: runnerInputDecoration('Device count'),
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(fontFamily: 'RobotoMono'),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            );
          }),

          ThresholdCard(
            text: 'Threshold: ≥ 70% mean accuracy across 3 consecutive weekly sessions = S1.2 met.',
          ),
          const SizedBox(height: spaceLg),

          ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryTeal,
              foregroundColor: Colors.black,
              minimumSize: const Size.fromHeight(48),
            ),
            child: const Text('Calculate & Save'),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';

import '../../../content/assessments/assessment_model.dart';
import '../../../core/theme/tokens.dart';
import 'runner_widgets.dart';

/// B10 State Shifting Verification runner.
/// 3 timed trials: shift to target state, sustain 10 minutes, rate fidelity.
class B10StateShiftingRunner extends StatefulWidget {
  const B10StateShiftingRunner({
    super.key,
    required this.assessment,
    required this.onComplete,
  });

  final AssessmentContent assessment;
  final AssessmentCompleteCallback onComplete;

  @override
  State<B10StateShiftingRunner> createState() => _B10StateShiftingRunnerState();
}

enum _B10Phase { instructions, shifting, sustaining, review }

class _B10StateShiftingRunnerState extends State<B10StateShiftingRunner> {
  int _currentTrial = 0; // 0–2
  _B10Phase _phase = _B10Phase.instructions;

  // Per trial data
  final List<String> _fromState = ['', '', ''];
  final List<String> _targetState = ['', '', ''];
  final List<int> _shiftSeconds = [0, 0, 0];
  final List<bool> _sustained = [false, false, false];
  final List<double> _fidelity = [3.0, 3.0, 3.0];
  final List<String> _somaticMarkers = ['', '', ''];

  // Live timer
  Timer? _timer;
  int _elapsed = 0;
  bool _timerRunning = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startShiftTimer() {
    setState(() {
      _elapsed = 0;
      _timerRunning = true;
      _phase = _B10Phase.shifting;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_timerRunning) setState(() => _elapsed++);
    });
  }

  void _markShiftComplete() {
    _timer?.cancel();
    setState(() {
      _shiftSeconds[_currentTrial] = _elapsed;
      _timerRunning = false;
      _phase = _B10Phase.sustaining;
      _elapsed = 0;
    });
    // Start sustain timer (10 min = 600s)
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _elapsed++;
        if (_elapsed >= 600) {
          _timer?.cancel();
          _sustained[_currentTrial] = true;
          _phase = _B10Phase.review;
        }
      });
    });
  }

  void _skipSustain() {
    _timer?.cancel();
    setState(() => _phase = _B10Phase.review);
  }

  void _finishTrial() {
    if (_currentTrial < 2) {
      setState(() {
        _currentTrial++;
        _phase = _B10Phase.instructions;
        _elapsed = 0;
      });
    } else {
      _submit();
    }
  }

  void _submit() {
    final trials = List.generate(3, (i) => {
      'fromState': _fromState[i],
      'targetState': _targetState[i],
      'shiftSeconds': _shiftSeconds[i],
      'shiftMinutes': (_shiftSeconds[i] / 60).toStringAsFixed(2),
      'sustained10Min': _sustained[i],
      'fidelity': _fidelity[i],
      'somaticMarkers': _somaticMarkers[i],
    });

    final avgFidelity =
        _fidelity.reduce((a, b) => a + b) / 3;
    final allShiftMet = _shiftSeconds.every((s) => s <= 300); // ≤ 5 min
    final allSustained = _sustained.every((s) => s);
    final allFidelityMet = _fidelity.every((f) => f >= 4.0);

    widget.onComplete(
      {
        'trials': trials,
        'avgFidelity': avgFidelity.toStringAsFixed(2),
        'allShiftWithin5Min': allShiftMet,
        'allSustained': allSustained,
        'allFidelityMet': allFidelityMet,
      },
      avgFidelity,
      {
        'avgFidelity': avgFidelity,
      },
    );
  }

  String _fmtTime(int s) {
    final m = (s ~/ 60).toString().padLeft(2, '0');
    final sec = (s % 60).toString().padLeft(2, '0');
    return '$m:$sec';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(spaceLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trial ${_currentTrial + 1} of 3',
            style: theme.textTheme.labelLarge?.copyWith(color: primaryTeal),
          ),
          const SizedBox(height: spaceSm),

          if (_phase == _B10Phase.instructions) ...[
            InstructionCard(steps: const [
              'You must have 3 target states defined from Phase 7 curriculum.',
              'Record your current state (name + somatic markers).',
              'Attempt to shift to the designated target state. Start the timer.',
              'When you believe you are in the target state, stop the timer.',
              'Sustain for exactly 10 minutes, then rate fidelity and record somatic confirmation.',
            ]),
            const SizedBox(height: spaceLg),

            Text('Current (from) state', style: theme.textTheme.labelLarge),
            const SizedBox(height: spaceXs),
            TextField(
              maxLines: 2,
              onChanged: (v) => _fromState[_currentTrial] = v,
              decoration: InputDecoration(
                hintText: 'e.g. "moderately aroused, planning mode"',
                filled: true,
                fillColor: surfaceVariantDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radiusMd),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: spaceMd),

            Text('Target state', style: theme.textTheme.labelLarge),
            const SizedBox(height: spaceXs),
            TextField(
              maxLines: 2,
              onChanged: (v) => _targetState[_currentTrial] = v,
              decoration: InputDecoration(
                hintText: 'e.g. "calm focus, low arousal, present"',
                filled: true,
                fillColor: surfaceVariantDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radiusMd),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: spaceLg),

            ElevatedButton(
              onPressed: _startShiftTimer,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryTeal,
                foregroundColor: Colors.black,
                minimumSize: const Size.fromHeight(48),
              ),
              child: const Text('Start Shift Timer'),
            ),
          ],

          if (_phase == _B10Phase.shifting) ...[
            Card(
              color: surfaceVariantDark,
              child: Padding(
                padding: const EdgeInsets.all(spaceLg),
                child: Column(
                  children: [
                    Text('Shifting to target…',
                        style: theme.textTheme.titleMedium),
                    const SizedBox(height: spaceMd),
                    Text(
                      _fmtTime(_elapsed),
                      style: theme.textTheme.displayMedium?.copyWith(
                        fontFamily: 'RobotoMono',
                        color: primaryTeal,
                      ),
                    ),
                    const SizedBox(height: spaceLg),
                    ElevatedButton(
                      onPressed: _markShiftComplete,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryTeal,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text('I am in the target state'),
                    ),
                  ],
                ),
              ),
            ),
          ],

          if (_phase == _B10Phase.sustaining) ...[
            Card(
              color: surfaceVariantDark,
              child: Padding(
                padding: const EdgeInsets.all(spaceLg),
                child: Column(
                  children: [
                    Text('Sustaining for 10 minutes…',
                        style: theme.textTheme.titleMedium),
                    const SizedBox(height: spaceMd),
                    CircularProgressIndicator(
                      value: _elapsed / 600,
                      strokeWidth: 6,
                      backgroundColor: surfaceVariantDark,
                      color: primaryTeal,
                    ),
                    const SizedBox(height: spaceSm),
                    Text(
                      '${_fmtTime(600 - _elapsed)} remaining',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontFamily: 'RobotoMono'),
                    ),
                    const SizedBox(height: spaceMd),
                    TextButton(
                      onPressed: _skipSustain,
                      child: const Text('Session ended early'),
                    ),
                  ],
                ),
              ),
            ),
          ],

          if (_phase == _B10Phase.review) ...[
            Card(
              color: surfaceVariantDark,
              child: Padding(
                padding: const EdgeInsets.all(spaceMd),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(children: [
                          const Text('SHIFT TIME'),
                          Text(
                            _fmtTime(_shiftSeconds[_currentTrial]),
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontFamily: 'RobotoMono',
                              color: _shiftSeconds[_currentTrial] <= 300
                                  ? primaryTeal
                                  : errorRed,
                            ),
                          ),
                        ]),
                        Column(children: [
                          const Text('SUSTAINED'),
                          Icon(
                            _sustained[_currentTrial]
                                ? Icons.check_circle_outline
                                : Icons.cancel_outlined,
                            color: _sustained[_currentTrial]
                                ? primaryTeal
                                : errorRed,
                          ),
                        ]),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: spaceMd),

            Text('Fidelity (1–5)', style: theme.textTheme.labelLarge),
            Text('1 = not in target state · 3 = partially · 5 = fully',
                style: theme.textTheme.bodySmall),
            Slider(
              value: _fidelity[_currentTrial],
              min: 1,
              max: 5,
              divisions: 4,
              activeColor: primaryTeal,
              inactiveColor: surfaceVariantDark,
              onChanged: (v) =>
                  setState(() => _fidelity[_currentTrial] = v),
            ),
            Center(
              child: Text(
                _fidelity[_currentTrial].round().toString(),
                style: theme.textTheme.titleLarge?.copyWith(
                  color: primaryTeal,
                  fontFamily: 'RobotoMono',
                ),
              ),
            ),
            const SizedBox(height: spaceMd),

            Text('Somatic confirmation (3 specific physical markers)',
                style: theme.textTheme.labelLarge),
            const SizedBox(height: spaceXs),
            TextField(
              maxLines: 3,
              onChanged: (v) => _somaticMarkers[_currentTrial] = v,
              decoration: InputDecoration(
                hintText:
                    'e.g. "breath rate slowed, jaw released, hands felt warmer"',
                filled: true,
                fillColor: surfaceVariantDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radiusMd),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: spaceMd),

            ThresholdCard(
              text: 'Threshold per trial: shift ≤5 min · sustained 10 min · '
                  'fidelity ≥4 · 3 specific somatic markers.',
            ),
            const SizedBox(height: spaceLg),

            ElevatedButton(
              onPressed: _finishTrial,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryTeal,
                foregroundColor: Colors.black,
                minimumSize: const Size.fromHeight(48),
              ),
              child: Text(_currentTrial < 2
                  ? 'Next Trial (${_currentTrial + 2} of 3)'
                  : 'Save All Results'),
            ),
          ],

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

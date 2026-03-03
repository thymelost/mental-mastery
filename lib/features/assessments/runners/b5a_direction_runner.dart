import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../content/assessments/assessment_model.dart';
import '../../../core/theme/tokens.dart';
import 'runner_widgets.dart';

/// B5a Attention Direction & Discrimination runner.
/// Sequential cue display + pass/fail + discrimination % entry.
class B5aDirectionRunner extends StatefulWidget {
  const B5aDirectionRunner({
    super.key,
    required this.assessment,
    required this.onComplete,
  });

  final AssessmentContent assessment;
  final AssessmentCompleteCallback onComplete;

  @override
  State<B5aDirectionRunner> createState() => _B5aDirectionRunnerState();
}

class _B5aDirectionRunnerState extends State<B5aDirectionRunner> {
  static const _cues = [
    'Left foot sole',
    'Right hand palm',
    'Chest center',
    'Belly',
    'Jaw',
    'Right shoulder',
    'Left knee',
    'Throat',
    'Forehead',
    'Lower back',
  ];

  final Map<int, bool?> _cueResults = {}; // index → pass/fail
  final _discCtrl = TextEditingController();
  bool _showDiscrimination = false;
  String? _error;

  int get _cuesPassed =>
      _cueResults.values.where((v) => v == true).length;

  bool get _allCuesDone =>
      _cueResults.length == _cues.length &&
      _cueResults.values.every((v) => v != null);

  @override
  void dispose() {
    _discCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final disc = double.tryParse(_discCtrl.text.trim());
    if (!_allCuesDone) {
      setState(() => _error = 'Complete all 10 direction cues first.');
      return;
    }
    if (!_showDiscrimination) {
      setState(() {
        _showDiscrimination = true;
        _error = null;
      });
      return;
    }
    if (disc == null || disc < 0 || disc > 100) {
      setState(() => _error = 'Enter discrimination accuracy (0–100%).');
      return;
    }
    setState(() => _error = null);

    widget.onComplete(
      {
        'cuesPassed': _cuesPassed,
        'discriminationAccuracyPct': disc,
        'cueResults': _cueResults.map((k, v) => MapEntry('cue${k + 1}', v)),
      },
      _cuesPassed.toDouble(),
      {'discriminationAccuracy%': disc},
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
            'Part 1 — Direction (10 min): For each cue, immediately redirect attention '
                'to the named target. Tap PASS if focus was established within 5 seconds, '
                'FAIL otherwise.',
            'Part 2 — Discrimination (10 min): Review the most recent 30 minutes of your '
                'experience. Identify each attention movement as Chosen (you decided) or '
                'Pulled (captured without intention).',
          ]),
          const SizedBox(height: spaceLg),

          Text('Part 1 — Direction cues',
              style: theme.textTheme.labelLarge),
          const SizedBox(height: spaceSm),

          ..._cues.asMap().entries.map((e) {
            final i = e.key;
            final cue = e.value;
            final result = _cueResults[i];
            return Card(
              margin: const EdgeInsets.only(bottom: spaceSm),
              color: result == true
                  ? primaryTeal.withValues(alpha: 0.1)
                  : result == false
                      ? errorRed.withValues(alpha: 0.1)
                      : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: spaceMd, vertical: spaceSm),
                child: Row(
                  children: [
                    Text(
                      '${i + 1}.',
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: onSurfaceMuted),
                    ),
                    const SizedBox(width: spaceSm),
                    Expanded(
                        child: Text(cue,
                            style: theme.textTheme.bodyMedium)),
                    TextButton(
                      onPressed: () =>
                          setState(() => _cueResults[i] = true),
                      child: Text(
                        'PASS',
                        style: TextStyle(
                          color: result == true
                              ? primaryTeal
                              : onSurfaceMuted,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          setState(() => _cueResults[i] = false),
                      child: Text(
                        'FAIL',
                        style: TextStyle(
                          color: result == false
                              ? errorRed
                              : onSurfaceMuted,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),

          Card(
            color: surfaceVariantDark,
            child: Padding(
              padding: const EdgeInsets.all(spaceMd),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(children: [
                    Text('PASSED', style: theme.textTheme.labelSmall),
                    Text(
                      '$_cuesPassed / 10',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color:
                            _cuesPassed >= 8 ? primaryTeal : onSurfaceMuted,
                        fontFamily: 'RobotoMono',
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
          const SizedBox(height: spaceLg),

          if (_showDiscrimination) ...[
            Text('Part 2 — Discrimination accuracy (%)',
                style: theme.textTheme.labelLarge),
            Text(
              'What % of recalled attention movements did you correctly '
              'categorize as Chosen vs. Pulled?',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: spaceXs),
            TextField(
              controller: _discCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
              ],
              decoration:
                  runnerInputDecoration('e.g. 80').copyWith(errorText: _error),
              style: theme.textTheme.bodyLarge
                  ?.copyWith(fontFamily: 'RobotoMono'),
            ),
            const SizedBox(height: spaceMd),
          ] else if (_error != null) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: spaceSm),
              child: Text(_error!,
                  style: TextStyle(color: errorRed, fontSize: 12)),
            ),
          ],

          ThresholdCard(
            text: 'Phase 1 exit: ≥ 8 of 10 cues ≤5 s; discrimination accuracy > 75%.',
          ),
          const SizedBox(height: spaceLg),

          ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryTeal,
              foregroundColor: Colors.black,
              minimumSize: const Size.fromHeight(48),
            ),
            child: Text(_allCuesDone && !_showDiscrimination
                ? 'Continue to Part 2'
                : 'Save Result'),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

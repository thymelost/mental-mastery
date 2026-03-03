import 'package:flutter/material.dart';

import '../../../content/assessments/assessment_model.dart';
import '../../../core/theme/tokens.dart';
import 'runner_widgets.dart';

/// B9 Boundary Challenge Assessment runner.
/// Attribution record across 3 media/social exposure scenarios.
class B9BoundaryRunner extends StatefulWidget {
  const B9BoundaryRunner({
    super.key,
    required this.assessment,
    required this.onComplete,
  });

  final AssessmentContent assessment;
  final AssessmentCompleteCallback onComplete;

  @override
  State<B9BoundaryRunner> createState() => _B9BoundaryRunnerState();
}

class _B9BoundaryRunnerState extends State<B9BoundaryRunner> {
  static const _sessionTypes = [
    'Session 1 — Media / persuasive content exposure',
    'Session 2 — Social pressure scenario recall',
    'Session 3 — Sustained perspective exposure',
  ];

  // Per session: emotionBefore, emotionAfter, attribution (internal/external/mixed),
  // evidence, thoughtShift (yes/no/uncertain), shiftSource (myReasoning/absorbed/unclear),
  // valuesConflict (yes/no), detectedInMoment (yes/no/na)
  final List<Map<String, String>> _sessions = List.generate(
    3,
    (_) => {
      'emotionBefore': '',
      'emotionAfter': '',
      'attribution': '',
      'evidence': '',
      'thoughtShift': '',
      'shiftSource': '',
      'valuesConflict': '',
      'detectedInMoment': 'na',
    },
  );

  int _currentSession = 0;
  String? _error;

  void _next() {
    final s = _sessions[_currentSession];
    if (s['attribution']!.isEmpty || s['thoughtShift']!.isEmpty ||
        s['valuesConflict']!.isEmpty) {
      setState(() => _error = 'Complete all required fields.');
      return;
    }
    setState(() {
      _error = null;
      if (_currentSession < 2) {
        _currentSession++;
      } else {
        _submit();
      }
    });
  }

  void _submit() {
    bool anyConflictRealtime = false;
    for (final s in _sessions) {
      if (s['valuesConflict'] == 'yes' && s['detectedInMoment'] == 'yes') {
        anyConflictRealtime = true;
        break;
      }
    }

    widget.onComplete(
      {
        'sessions': _sessions,
        'valuesConflictDetectedRealtime': anyConflictRealtime,
      },
      anyConflictRealtime ? 1.0 : 0.0,
      null,
    );
  }

  void _setField(String key, String value) {
    setState(() {
      _sessions[_currentSession][key] = value;
      _error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = _sessions[_currentSession];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(spaceLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_currentSession == 0)
            InstructionCard(steps: const [
              'Three sessions across 3 weeks (one per scenario type).',
              'After each session complete the attribution record below.',
              'Administer one session at a time; return for sessions 2 and 3.',
            ]),

          const SizedBox(height: spaceMd),
          LinearProgressIndicator(
            value: (_currentSession + 1) / 3,
            backgroundColor: surfaceVariantDark,
            color: primaryTeal,
            minHeight: 3,
          ),
          const SizedBox(height: spaceMd),

          Text(
            _sessionTypes[_currentSession],
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: spaceLg),

          _radioGroup(
            theme,
            label: 'Attribution (B2.1)',
            question: 'Was the emotional shift:',
            options: const [
              ('internal', 'Internal (from my prior state/beliefs/memories)'),
              ('external', 'External (from the content/person/environment)'),
              ('mixed', 'Mixed'),
            ],
            value: s['attribution']!,
            onChanged: (v) => _setField('attribution', v),
          ),
          const SizedBox(height: spaceMd),

          _radioGroup(
            theme,
            label: 'Thought shift',
            question: 'Did any thoughts or opinions shift during the session?',
            options: const [
              ('yes', 'Yes'),
              ('no', 'No'),
              ('uncertain', 'Uncertain'),
            ],
            value: s['thoughtShift']!,
            onChanged: (v) => _setField('thoughtShift', v),
          ),

          if (s['thoughtShift'] == 'yes') ...[
            const SizedBox(height: spaceMd),
            _radioGroup(
              theme,
              label: 'Shift source',
              question: 'Does the shift feel like:',
              options: const [
                ('myReasoning', 'My own reasoning'),
                ('absorbed', 'Absorbed content'),
                ('unclear', 'Unclear'),
              ],
              value: s['shiftSource']!,
              onChanged: (v) => _setField('shiftSource', v),
            ),
          ],

          const SizedBox(height: spaceMd),
          _radioGroup(
            theme,
            label: 'Values conflict (B2.2)',
            question:
                'Did any shifted thoughts/emotions conflict with your Values Document?',
            options: const [
              ('yes', 'Yes'),
              ('no', 'No'),
            ],
            value: s['valuesConflict']!,
            onChanged: (v) => _setField('valuesConflict', v),
          ),

          if (s['valuesConflict'] == 'yes') ...[
            const SizedBox(height: spaceMd),
            _radioGroup(
              theme,
              label: 'Real-time detection',
              question: 'Did you detect the conflict in the moment?',
              options: const [
                ('yes', 'Yes'),
                ('no', 'No'),
              ],
              value: s['detectedInMoment'] == 'na' ? '' : s['detectedInMoment']!,
              onChanged: (v) => _setField('detectedInMoment', v),
            ),
          ],

          if (_error != null) ...[
            const SizedBox(height: spaceSm),
            Text(_error!, style: TextStyle(color: errorRed, fontSize: 12)),
          ],

          const SizedBox(height: spaceMd),
          ThresholdCard(
            text: 'Threshold: Attribution made for all 3 sessions with stated evidence; '
                'not systematically defaulting one way; ≥ 1 values-conflict detected in real time.',
          ),
          const SizedBox(height: spaceLg),

          ElevatedButton(
            onPressed: _next,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryTeal,
              foregroundColor: Colors.black,
              minimumSize: const Size.fromHeight(48),
            ),
            child: Text(_currentSession < 2
                ? 'Next Session (${_currentSession + 2} of 3)'
                : 'Save All Results'),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _radioGroup(
    ThemeData theme, {
    required String label,
    required String question,
    required List<(String, String)> options,
    required String value,
    required void Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.labelMedium?.copyWith(color: primaryTeal)),
        const SizedBox(height: 4),
        Text(question, style: theme.textTheme.bodyMedium),
        ...options.map(
          (opt) => RadioListTile<String>(
            value: opt.$1,
            groupValue: value,
            activeColor: primaryTeal,
            contentPadding: EdgeInsets.zero,
            dense: true,
            title: Text(opt.$2, style: theme.textTheme.bodySmall),
            onChanged: (v) => onChanged(v ?? ''),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../../content/assessments/assessment_model.dart';
import '../../../core/theme/tokens.dart';
import 'runner_widgets.dart';

/// B6 Meta-Attention Probe runner.
/// Single alarm-triggered probe: names attentional object + rates latency.
class B6ProbeRunner extends StatefulWidget {
  const B6ProbeRunner({
    super.key,
    required this.assessment,
    required this.onComplete,
  });

  final AssessmentContent assessment;
  final AssessmentCompleteCallback onComplete;

  @override
  State<B6ProbeRunner> createState() => _B6ProbeRunnerState();
}

class _B6ProbeRunnerState extends State<B6ProbeRunner> {
  final _objectCtrl = TextEditingController();
  String? _latency; // 'A', 'B', or 'C'
  bool _identifiable = true;
  String? _error;

  @override
  void dispose() {
    _objectCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_objectCtrl.text.trim().isEmpty) {
      setState(() => _error = 'Describe the attentional object.');
      return;
    }
    if (_latency == null) {
      setState(() => _error = 'Select a latency rating.');
      return;
    }
    setState(() => _error = null);

    widget.onComplete(
      {
        'attentionalObject': _objectCtrl.text.trim(),
        'latency': _latency,
        'identifiable': _identifiable,
        'probeTimestamp': DateTime.now().toIso8601String(),
      },
      _identifiable ? 1.0 : 0.0,
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
          Card(
            color: surfaceVariantDark,
            child: Padding(
              padding: const EdgeInsets.all(spaceMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alarm triggered — respond immediately',
                    style: theme.textTheme.labelLarge
                        ?.copyWith(color: primaryTeal),
                  ),
                  const SizedBox(height: spaceSm),
                  Text(
                    'Before doing anything else: Where is your attention right now?',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: spaceLg),

          Text('Where is your attention right now?',
              style: theme.textTheme.labelLarge),
          const SizedBox(height: spaceXs),
          TextField(
            controller: _objectCtrl,
            maxLines: 2,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Name the attentional object or activity…',
              errorText: _error,
              filled: true,
              fillColor: surfaceVariantDark,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radiusMd),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radiusMd),
                borderSide: BorderSide(color: primaryTeal.withValues(alpha: 0.6)),
              ),
            ),
          ),
          const SizedBox(height: spaceMd),

          Row(
            children: [
              Checkbox(
                value: _identifiable,
                activeColor: primaryTeal,
                onChanged: (v) =>
                    setState(() => _identifiable = v ?? true),
              ),
              Expanded(
                child: Text(
                  'I could identify an attentional object',
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: spaceMd),

          Text('Latency to awareness', style: theme.textTheme.labelLarge),
          ...[
            ('A', 'I knew immediately'),
            ('B', 'Took 2–3 seconds to locate'),
            ('C', 'Took 5+ seconds or was genuinely unclear'),
          ].map(
            (opt) => RadioListTile<String>(
              value: opt.$1,
              groupValue: _latency,
              activeColor: primaryTeal,
              contentPadding: EdgeInsets.zero,
              title: Text(
                '${opt.$1}: ${opt.$2}',
                style: theme.textTheme.bodyMedium,
              ),
              onChanged: (v) => setState(() {
                _latency = v;
                _error = null;
              }),
            ),
          ),
          const SizedBox(height: spaceMd),

          ThresholdCard(
            text: 'Phase 3 exit: accuracy ≥ 80% (can name object in ≥ 8 of 10 probes) '
                'and improving A-latency trend over 5 days.',
          ),
          const SizedBox(height: spaceLg),

          ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryTeal,
              foregroundColor: Colors.black,
              minimumSize: const Size.fromHeight(48),
            ),
            child: const Text('Submit Probe'),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

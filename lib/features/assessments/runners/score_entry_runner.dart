import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../content/assessments/assessment_model.dart';
import '../../../core/theme/tokens.dart';

/// Score-entry runner for instruments administered externally.
/// Used for SMS-Mind and RRS where items are not reproduced in-app.
class ScoreEntryRunner extends StatefulWidget {
  const ScoreEntryRunner({
    super.key,
    required this.assessment,
    required this.onComplete,
  });

  final AssessmentContent assessment;
  final AssessmentCompleteCallback onComplete;

  @override
  State<ScoreEntryRunner> createState() => _ScoreEntryRunnerState();
}

class _ScoreEntryRunnerState extends State<ScoreEntryRunner> {
  final _controller = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text.trim();
    final value = double.tryParse(text);
    if (value == null) {
      setState(() => _error = 'Enter a valid number.');
      return;
    }
    setState(() => _error = null);
    widget.onComplete(
      {'total': value},
      value,
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
          // Instructions
          Card(
            color: surfaceVariantDark,
            child: Padding(
              padding: const EdgeInsets.all(spaceMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'External administration',
                    style: theme.textTheme.labelLarge
                        ?.copyWith(color: primaryTeal),
                  ),
                  const SizedBox(height: spaceSm),
                  Text(
                    'Complete this instrument externally using the '
                    'published version, then enter your total score below.',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: spaceMd),

          // Scoring notes / where to find
          if (widget.assessment.scoringNotes != null) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(spaceMd),
                child: Text(
                  widget.assessment.scoringNotes!,
                  style: theme.textTheme.bodySmall,
                ),
              ),
            ),
            const SizedBox(height: spaceMd),
          ],

          // Score input
          Text('Total score', style: theme.textTheme.labelLarge),
          const SizedBox(height: spaceXs),
          TextField(
            controller: _controller,
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp(r'[0-9.]')),
            ],
            decoration: InputDecoration(
              hintText: 'e.g. 42',
              errorText: _error,
              filled: true,
              fillColor: surfaceVariantDark,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radiusMd),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radiusMd),
                borderSide:
                    BorderSide(color: primaryTeal.withValues(alpha: 0.6)),
              ),
            ),
            style: theme.textTheme.bodyLarge
                ?.copyWith(fontFamily: 'RobotoMono'),
          ),
          const SizedBox(height: spaceLg),
          ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryTeal,
              foregroundColor: Colors.black,
              minimumSize: const Size.fromHeight(48),
            ),
            child: const Text('Save Score'),
          ),
        ],
      ),
    );
  }
}

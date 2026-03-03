import 'dart:async';
import 'package:flutter/material.dart';

import '../../../content/assessments/assessment_model.dart';
import '../../../core/theme/tokens.dart';
import 'runner_widgets.dart';

/// B5 Attention Sustaining Assessment runner.
/// 10-minute breath focus session with drift-tap counter.
class B5AttentionRunner extends StatefulWidget {
  const B5AttentionRunner({
    super.key,
    required this.assessment,
    required this.onComplete,
  });

  final AssessmentContent assessment;
  final AssessmentCompleteCallback onComplete;

  @override
  State<B5AttentionRunner> createState() => _B5AttentionRunnerState();
}

enum _B5Phase { instructions, running, review }

class _B5AttentionRunnerState extends State<B5AttentionRunner> {
  _B5Phase _phase = _B5Phase.instructions;
  Timer? _timer;
  int _elapsed = 0; // seconds
  static const _totalSeconds = 600; // 10 minutes
  int _driftCount = 0;
  bool _paused = false;

  // Review inputs
  double _longestStretchMin = 0;
  final _distractionCtrl = TextEditingController();

  @override
  void dispose() {
    _timer?.cancel();
    _distractionCtrl.dispose();
    super.dispose();
  }

  void _startSession() {
    setState(() {
      _phase = _B5Phase.running;
      _elapsed = 0;
      _driftCount = 0;
    });
    _resumeTimer();
  }

  void _resumeTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!_paused) {
        setState(() => _elapsed++);
        if (_elapsed >= _totalSeconds) {
          _timer?.cancel();
          setState(() => _phase = _B5Phase.review);
        }
      }
    });
  }

  void _tapDrift() => setState(() => _driftCount++);

  void _togglePause() {
    setState(() => _paused = !_paused);
  }

  void _submit() {
    widget.onComplete(
      {
        'driftCount': _driftCount,
        'longestStretchMin': _longestStretchMin,
        'mainDistraction': _distractionCtrl.text.trim(),
      },
      _driftCount.toDouble(),
      {'longestStretchMin': _longestStretchMin},
    );
  }

  String _timeStr(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return switch (_phase) {
      _B5Phase.instructions => _buildInstructions(),
      _B5Phase.running => _buildSession(),
      _B5Phase.review => _buildReview(),
    };
  }

  Widget _buildInstructions() {
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
                  Text('Instructions', style: theme.textTheme.labelLarge?.copyWith(color: primaryTeal)),
                  const SizedBox(height: spaceSm),
                  ...[
                    'Sit comfortably. Place attention on the physical sensation of breath at the nostrils or chest rise/fall.',
                    'Each time your attention leaves the sensation without you choosing to move it, tap the DRIFT button.',
                    'Return attention immediately after each drift tap.',
                    'The session is 10 minutes. You can pause if needed.',
                  ].map((s) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text('• $s', style: theme.textTheme.bodySmall),
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(height: spaceMd),
          ThresholdCard(
            text: 'Phase 1 exit: ≤ 3 drifts AND ≥ 10-min stretch, '
                'across 5 consecutive sessions in the same week.',
          ),
          const SizedBox(height: spaceLg),
          ElevatedButton(
            onPressed: _startSession,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryTeal,
              foregroundColor: Colors.black,
              minimumSize: const Size.fromHeight(52),
            ),
            child: const Text('Begin 10-Minute Session'),
          ),
        ],
      ),
    );
  }

  Widget _buildSession() {
    final theme = Theme.of(context);
    final remaining = _totalSeconds - _elapsed;
    final progress = _elapsed / _totalSeconds;

    return Padding(
      padding: const EdgeInsets.all(spaceLg),
      child: Column(
        children: [
          const Spacer(),
          // Timer ring
          SizedBox(
            width: 160,
            height: 160,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 8,
                  backgroundColor: surfaceVariantDark,
                  color: primaryTeal,
                ),
                Text(
                  _timeStr(remaining),
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontFamily: 'RobotoMono',
                    color: primaryTeal,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: spaceLg),

          // Drift count
          Text(
            'Drifts: $_driftCount',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontFamily: 'RobotoMono',
            ),
          ),
          const Spacer(),

          // Drift tap button
          GestureDetector(
            onTap: _tapDrift,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: surfaceVariantDark,
                shape: BoxShape.circle,
                border: Border.all(color: primaryTeal.withValues(alpha: 0.5), width: 2),
              ),
              alignment: Alignment.center,
              child: Text(
                'DRIFT',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: primaryTeal,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
          const SizedBox(height: spaceLg),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: _togglePause,
                icon: Icon(_paused ? Icons.play_arrow : Icons.pause),
                label: Text(_paused ? 'Resume' : 'Pause'),
              ),
            ],
          ),
          const SizedBox(height: spaceLg),
        ],
      ),
    );
  }

  Widget _buildReview() {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(spaceLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: surfaceVariantDark,
            child: Padding(
              padding: const EdgeInsets.all(spaceLg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text('DRIFTS', style: theme.textTheme.labelSmall?.copyWith(letterSpacing: 1)),
                      Text(
                        '$_driftCount',
                        style: theme.textTheme.displaySmall?.copyWith(
                          color: _driftCount <= 3 ? primaryTeal : errorRed,
                          fontFamily: 'RobotoMono',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: spaceLg),

          Text('Longest continuous stretch (minutes)',
              style: theme.textTheme.labelLarge),
          const SizedBox(height: spaceXs),
          Row(
            children: [
              Text('0', style: theme.textTheme.bodySmall),
              Expanded(
                child: Slider(
                  value: _longestStretchMin,
                  min: 0,
                  max: 10,
                  divisions: 20,
                  activeColor: primaryTeal,
                  inactiveColor: surfaceVariantDark,
                  onChanged: (v) => setState(() => _longestStretchMin = v),
                ),
              ),
              Text('10', style: theme.textTheme.bodySmall),
            ],
          ),
          Center(
            child: Text(
              '${_longestStretchMin.toStringAsFixed(1)} min',
              style: theme.textTheme.titleLarge?.copyWith(
                color: primaryTeal,
                fontFamily: 'RobotoMono',
              ),
            ),
          ),
          const SizedBox(height: spaceMd),

          Text('What pulled attention most?',
              style: theme.textTheme.labelLarge),
          const SizedBox(height: spaceXs),
          TextField(
            controller: _distractionCtrl,
            maxLines: 2,
            decoration: InputDecoration(
              hintText: 'e.g. planning thoughts, sounds…',
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

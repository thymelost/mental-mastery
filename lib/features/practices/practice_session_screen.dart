import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../content/practices/practice_model.dart';
import '../../core/theme/tokens.dart';
import '../../core/providers.dart';
import '../../services/hr_monitor/hr_monitor_service.dart';
import 'practice_provider.dart';

/// Active session screen: shows elapsed timer, drift tap button, and controls.
class PracticeSessionScreen extends ConsumerWidget {
  const PracticeSessionScreen({super.key, required this.practiceId});

  final String practiceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionStateProvider);
    final practice = practiceById(practiceId);
    final phaseNumber = ref.watch(currentPhaseProvider);
    final hrState = ref.watch(hrMonitorProvider);

    // Auto-start the session if it is still in safetyCheck state.
    if (session.status == SessionStatus.safetyCheck &&
        session.practiceId == practiceId) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(sessionStateProvider.notifier)
            .startSession(phaseNumber: phaseNumber);
      });
    }

    return PopScope(
      canPop: session.status == SessionStatus.idle ||
          session.status == SessionStatus.complete,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _confirmAbort(context, ref);
      },
      child: Scaffold(
        backgroundColor: backgroundDark,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(spaceLg),
            child: Column(
              children: [
                // ── Header ──────────────────────────────────────────────
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => _confirmAbort(context, ref),
                    ),
                    Expanded(
                      child: Text(
                        practice?.name ?? practiceId,
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // F7 — Safety reference icon (persistent mid-session).
                    IconButton(
                      icon: const Icon(Icons.health_and_safety_outlined),
                      iconSize: 20,
                      color: onSurfaceMuted,
                      tooltip: 'Safety signals',
                      onPressed: () =>
                          _showSafetySheet(context, practice),
                    ),
                    if (hrState.status == HrMonitorStatus.connected &&
                        hrState.heartRate != null)
                      _HrChip(bpm: hrState.heartRate!)
                    else
                      const SizedBox(width: 4),
                  ],
                ),
                const SizedBox(height: spaceLg),

                // ── Timer ────────────────────────────────────────────────
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _TimerDisplay(
                        elapsed: session.elapsedSeconds,
                        target: (practice?.durationMinutes ?? 0) * 60,
                      ),
                      const SizedBox(height: spaceXxl),

                      // ── Drift tap button ───────────────────────────────
                      _DriftButton(
                        driftCount: session.driftCount,
                        onTap: session.status == SessionStatus.running
                            ? () => ref
                                .read(sessionStateProvider.notifier)
                                .logDrift()
                            : null,
                      ),
                      const SizedBox(height: spaceXxl),

                      // ── Pause / resume ────────────────────────────────
                      _SessionControls(
                        status: session.status,
                        onPause: () =>
                            ref.read(sessionStateProvider.notifier).pauseSession(),
                        onResume: () =>
                            ref.read(sessionStateProvider.notifier).resumeSession(),
                        onFinish: () => context.go(
                          '/practice/$practiceId/session/complete',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Shows a read-only bottom sheet with this practice's safety signals.
  void _showSafetySheet(BuildContext context, PracticeContent? practice) {
    final theme = Theme.of(context);
    final signals = practice?.safetySignals ?? [];

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(spaceLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.health_and_safety_outlined,
                      size: 18, color: onSurfaceMuted),
                  const SizedBox(width: spaceSm),
                  Text(
                    'Safety Signals',
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
              const SizedBox(height: spaceMd),
              if (signals.isEmpty)
                Text(
                  'No stop criteria required for this practice — '
                  'it is observational only.',
                  style: theme.textTheme.bodyMedium,
                )
              else ...[
                Text(
                  'Stop or pause this practice if:',
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: onSurfaceMuted),
                ),
                const SizedBox(height: spaceSm),
                ...signals.map(
                  (s) => Padding(
                    padding: const EdgeInsets.only(bottom: spaceSm),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('· ',
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: onSurfaceMuted)),
                        Expanded(
                          child: Text(s,
                              style: theme.textTheme.bodyMedium),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: spaceMd),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmAbort(BuildContext context, WidgetRef ref) {
    showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('End session?'),
        content: const Text(
          'Progress will not be saved if you leave now.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Keep going'),
          ),
          TextButton(
            onPressed: () {
              ref.read(sessionStateProvider.notifier).reset();
              Navigator.of(ctx).pop(true);
              context.go('/');
            },
            child: Text(
              'End session',
              style: TextStyle(color: errorRed),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Sub-widgets ─────────────────────────────────────────────────────────────

class _TimerDisplay extends StatelessWidget {
  const _TimerDisplay({required this.elapsed, required this.target});

  final int elapsed;
  final int target;

  @override
  Widget build(BuildContext context) {
    final em = elapsed ~/ 60;
    final es = elapsed % 60;
    final progress = target > 0 ? (elapsed / target).clamp(0.0, 1.0) : 0.0;

    return Column(
      children: [
        SizedBox(
          width: 180,
          height: 180,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox.expand(
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 6,
                  backgroundColor: surfaceVariantDark,
                  valueColor: AlwaysStoppedAnimation(primaryTeal),
                ),
              ),
              Text(
                '${em.toString().padLeft(2, '0')}:${es.toString().padLeft(2, '0')}',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontFamily: 'RobotoMono',
                      color: onSurfaceDark,
                    ),
              ),
            ],
          ),
        ),
        if (target > 0) ...[
          const SizedBox(height: spaceSm),
          Text(
            'of ${target ~/ 60} min',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ],
    );
  }
}

class _DriftButton extends StatelessWidget {
  const _DriftButton({required this.driftCount, this.onTap});

  final int driftCount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          'TAP WHEN ATTENTION DRIFTS',
          style: theme.textTheme.labelSmall?.copyWith(letterSpacing: 1.2),
        ),
        const SizedBox(height: spaceMd),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: onTap != null
                  ? surfaceVariantDark
                  : surfaceVariantDark.withValues(alpha: 0.4),
              border: Border.all(
                color: onTap != null
                    ? primaryTeal.withValues(alpha: 0.5)
                    : surfaceVariantDark,
                width: 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.touch_app_outlined,
                  size: 32,
                  color: onTap != null ? primaryTeal : onSurfaceMuted,
                ),
                const SizedBox(height: spaceXs),
                Text(
                  '$driftCount',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontFamily: 'RobotoMono',
                    color: onTap != null ? onSurfaceDark : onSurfaceMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HrChip extends StatelessWidget {
  const _HrChip({required this.bpm});
  final int bpm;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.favorite, color: errorRed, size: 12),
          Text(
            '$bpm',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontFamily: 'RobotoMono',
                  color: errorRed,
                  fontSize: 10,
                ),
          ),
        ],
      ),
    );
  }
}

class _SessionControls extends StatelessWidget {
  const _SessionControls({
    required this.status,
    required this.onPause,
    required this.onResume,
    required this.onFinish,
  });

  final SessionStatus status;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (status == SessionStatus.running)
          OutlinedButton.icon(
            icon: const Icon(Icons.pause),
            label: const Text('Pause'),
            onPressed: onPause,
          )
        else if (status == SessionStatus.paused)
          OutlinedButton.icon(
            icon: const Icon(Icons.play_arrow),
            label: const Text('Resume'),
            onPressed: onResume,
          ),
        const SizedBox(width: spaceMd),
        ElevatedButton.icon(
          icon: const Icon(Icons.check),
          label: const Text('Finish'),
          onPressed: onFinish,
        ),
      ],
    );
  }
}

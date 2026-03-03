import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/tokens.dart';
import '../../services/alarm/alarm_service.dart';
import '../../services/hr_monitor/hr_monitor_service.dart';
import '../../services/whisper_model/whisper_model_provider.dart';
import '../../services/whisper_model/whisper_model_service.dart';
import '../../services/whisper_model/whisper_model_state.dart';

/// Settings screen: HR monitor pairing, alarm configuration, known limits.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(spaceMd),
        children: [
          // ── HR Monitor ──────────────────────────────────────────────────
          _SectionHeader(title: 'HEART RATE MONITOR'),
          const _HrMonitorCard(),
          const SizedBox(height: spaceLg),

          // ── Alarms ──────────────────────────────────────────────────────
          _SectionHeader(title: 'ALARMS & REMINDERS'),
          const _AlarmCard(),
          const SizedBox(height: spaceLg),

          // ── Whisper Model ─────────────────────────────────────────────────
          _SectionHeader(title: 'WHISPER BASE MODEL (OFFLINE TRANSCRIPTION)'),
          const _WhisperModelCard(),
          const SizedBox(height: spaceLg),

          // ── Known Limits ─────────────────────────────────────────────────
          _SectionHeader(title: 'KNOWN LIMITS OF THIS FRAMEWORK'),
          const _KnownLimitsCard(),
          const SizedBox(height: 40),

          // ── Developer (debug builds only — absent in release APKs) ───────
          if (kDebugMode) ...[
            _SectionHeader(title: 'DEVELOPER'),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 4),
              leading: const Icon(Icons.bug_report_outlined, color: errorRed),
              title: const Text('Test Mode'),
              subtitle: const Text('Navigate to any practice, assessment, or gate'),
              trailing:
                  const Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () => context.push('/dev-test'),
            ),
            const SizedBox(height: 40),
          ],
        ],
      ),
    );
  }
}

// ─── HR Monitor Card ──────────────────────────────────────────────────────────

class _HrMonitorCard extends ConsumerWidget {
  const _HrMonitorCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hr = ref.watch(hrMonitorProvider);
    final notifier = ref.read(hrMonitorProvider.notifier);
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(spaceMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Status row ────────────────────────────────────────────────
            Row(
              children: [
                _HrStatusDot(status: hr.status),
                const SizedBox(width: spaceSm),
                Expanded(
                  child: Text(
                    _statusLabel(hr),
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                if (hr.heartRate != null)
                  Text(
                    '${hr.heartRate} bpm',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: primaryTeal,
                      fontFamily: 'RobotoMono',
                    ),
                  ),
              ],
            ),

            // ── Error ─────────────────────────────────────────────────────
            if (hr.error != null) ...[
              const SizedBox(height: spaceSm),
              Text(
                hr.error!,
                style: theme.textTheme.bodySmall?.copyWith(color: errorRed),
              ),
            ],

            // ── Scan results ──────────────────────────────────────────────
            if (hr.status == HrMonitorStatus.scanning &&
                hr.scanResults.isNotEmpty) ...[
              const SizedBox(height: spaceMd),
              Text('Nearby devices:', style: theme.textTheme.labelSmall),
              const SizedBox(height: spaceXs),
              ...hr.scanResults
                  .where((r) => r.device.advName.isNotEmpty)
                  .map((r) => ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          r.device.advName,
                          style: theme.textTheme.bodySmall,
                        ),
                        subtitle: Text(
                          '${r.rssi} dBm',
                          style: theme.textTheme.labelSmall
                              ?.copyWith(color: onSurfaceMuted),
                        ),
                        trailing: TextButton(
                          onPressed: () =>
                              notifier.connectToDevice(r.device),
                          child: const Text('Connect'),
                        ),
                      )),
            ],

            const SizedBox(height: spaceMd),

            // ── Action buttons ────────────────────────────────────────────
            Row(
              children: [
                if (hr.status == HrMonitorStatus.disconnected ||
                    hr.status == HrMonitorStatus.error)
                  ElevatedButton.icon(
                    icon: const Icon(Icons.bluetooth_searching, size: 18),
                    label: const Text('Scan'),
                    onPressed: () => notifier.startScan(),
                  ),
                if (hr.status == HrMonitorStatus.scanning)
                  OutlinedButton(
                    onPressed: () => notifier.stopScan(),
                    child: const Text('Stop scan'),
                  ),
                if (hr.status == HrMonitorStatus.connected) ...[
                  const Icon(
                    Icons.favorite,
                    color: errorRed,
                    size: 16,
                  ),
                  const SizedBox(width: spaceXs),
                  Text(
                    hr.connectedDevice?.advName ?? 'HR Monitor',
                    style: theme.textTheme.bodySmall,
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => notifier.disconnect(),
                    child: Text(
                      'Disconnect',
                      style: TextStyle(color: errorRed),
                    ),
                  ),
                ],
              ],
            ),

            const SizedBox(height: spaceXs),
            Text(
              'Required for B5a/B7/B8 Condition D (L2→L3 gate). '
              'Supports Bluetooth LE heart rate monitors (Heart Rate Service).',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: onSurfaceMuted),
            ),
          ],
        ),
      ),
    );
  }

  String _statusLabel(HrMonitorState hr) {
    return switch (hr.status) {
      HrMonitorStatus.disconnected => 'No device connected',
      HrMonitorStatus.scanning => 'Scanning for devices…',
      HrMonitorStatus.connecting => 'Connecting…',
      HrMonitorStatus.connected =>
        'Connected — live HR',
      HrMonitorStatus.error => 'Error',
    };
  }
}

class _HrStatusDot extends StatelessWidget {
  const _HrStatusDot({required this.status});
  final HrMonitorStatus status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      HrMonitorStatus.connected => gatePassGreen,
      HrMonitorStatus.scanning || HrMonitorStatus.connecting => primaryTeal,
      HrMonitorStatus.error => errorRed,
      _ => onSurfaceMuted,
    };
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

// ─── Alarm Card ───────────────────────────────────────────────────────────────

class _AlarmCard extends StatefulWidget {
  const _AlarmCard();

  @override
  State<_AlarmCard> createState() => _AlarmCardState();
}

class _AlarmCardState extends State<_AlarmCard> {
  bool _probesEnabled = false;
  bool _reminderEnabled = false;
  TimeOfDay _reminderTime = const TimeOfDay(hour: 8, minute: 0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(spaceMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── B6 Probes ─────────────────────────────────────────────────
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'B6 Meta-Attention Probes',
                style: theme.textTheme.bodyMedium,
              ),
              subtitle: Text(
                '5 random probes per day during waking hours',
                style: theme.textTheme.bodySmall,
              ),
              value: _probesEnabled,
              activeColor: primaryTeal,
              onChanged: (v) {
                setState(() => _probesEnabled = v);
                if (v) {
                  AlarmService.instance.scheduleB6Probes();
                } else {
                  AlarmService.instance.cancelB6Probes();
                }
              },
            ),
            const Divider(height: 1),
            const SizedBox(height: spaceXs),

            // ── Practice reminder ─────────────────────────────────────────
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Daily Practice Reminder',
                style: theme.textTheme.bodyMedium,
              ),
              subtitle: Text(
                'Remind me at ${_reminderTime.format(context)}',
                style: theme.textTheme.bodySmall,
              ),
              value: _reminderEnabled,
              activeColor: primaryTeal,
              onChanged: (v) async {
                if (v) {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: _reminderTime,
                  );
                  if (picked != null) {
                    setState(() {
                      _reminderEnabled = true;
                      _reminderTime = picked;
                    });
                    await AlarmService.instance.scheduleDailyPracticeReminder(
                      hour: picked.hour,
                      minute: picked.minute,
                    );
                  }
                } else {
                  setState(() => _reminderEnabled = false);
                  await AlarmService.instance.cancelPracticeReminder();
                }
              },
            ),
            const SizedBox(height: spaceSm),

            // ── Test probe button ─────────────────────────────────────────
            OutlinedButton.icon(
              icon: const Icon(Icons.notifications_none, size: 16),
              label: const Text('Send test probe now'),
              onPressed: () => AlarmService.instance.showB6ProbeNow(),
              style: OutlinedButton.styleFrom(
                visualDensity: VisualDensity.compact,
              ),
            ),
            const SizedBox(height: spaceXs),
            Text(
              'Notification permission is required. '
              'Probes are scheduled daily at app start when enabled.',
              style:
                  theme.textTheme.bodySmall?.copyWith(color: onSurfaceMuted),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Known Limits Card ────────────────────────────────────────────────────────

class _KnownLimitsCard extends StatelessWidget {
  const _KnownLimitsCard();

  static const _limits = [
    'BCT and standard neuropsychological attention tests are unreliable skill proxies for this framework.',
    'Breath-focused meditation does NOT train Somatic Intelligence — dedicated body scan is required.',
    'Standard mindfulness does NOT reduce impulsivity — Pattern Interruption needs targeted practice.',
    'Brain change and subjective change are decoupled within the same measurement window.',
    '87% positive publication rate in MBT RCTs — effect sizes are likely inflated.',
    'Metacognitive training is domain-specific; transfer across domains is partial, not automatic.',
    'Stress-transfer (maintaining skills under physiological load) requires explicit training.',
    'Timescales: subjective change (weeks 1–4), FC reconfiguration (weeks 4–8), structural (8+ weeks).',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(spaceMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'These are honest limitations surfaced by 33 reviewed papers. '
              'They are features of the design, not bugs — see Research Grounding for details.',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: spaceMd),
            ..._limits.map(
              (limit) => Padding(
                padding: const EdgeInsets.only(bottom: spaceSm),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '·  ',
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: onSurfaceMuted),
                    ),
                    Expanded(
                      child: Text(
                        limit,
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Whisper Model Card ───────────────────────────────────────────────────────

class _WhisperModelCard extends ConsumerWidget {
  const _WhisperModelCard();

  static const _approxMb = 142;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modelState = ref.watch(whisperModelProvider);
    final notifier = ref.read(whisperModelProvider.notifier);
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(spaceMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Required for Offline High-Privacy mode. Downloaded once '
              '(~$_approxMb MB) and stored on device. '
              'Not transmitted to any server.',
              style:
                  theme.textTheme.bodySmall?.copyWith(color: onSurfaceMuted),
            ),
            const SizedBox(height: spaceMd),
            _buildBody(context, theme, modelState, notifier),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    ThemeData theme,
    WhisperModelState modelState,
    WhisperModelNotifier notifier,
  ) {
    return switch (modelState) {
      ModelNotDownloaded() => _NotDownloadedBody(notifier: notifier),
      ModelChecking() => const _CheckingBody(),
      ModelDownloading(:final progress) =>
        _DownloadingBody(progress: progress, notifier: notifier),
      ModelDownloaded(:final filePath) =>
        _DownloadedBody(filePath: filePath, notifier: notifier),
      ModelError(:final message) =>
        _ErrorBody(message: message, notifier: notifier),
    };
  }
}

// ── Sub-widgets for each state ────────────────────────────────────────────────

class _NotDownloadedBody extends StatelessWidget {
  const _NotDownloadedBody({required this.notifier});
  final WhisperModelNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      icon: const Icon(Icons.download_outlined, size: 18),
      label: const Text('Download Model (~142 MB)'),
      onPressed: () => notifier.startDownload(),
    );
  }
}

class _CheckingBody extends StatelessWidget {
  const _CheckingBody();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        const SizedBox(width: spaceSm),
        Text(
          'Checking…',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _DownloadingBody extends StatelessWidget {
  const _DownloadingBody({
    required this.progress,
    required this.notifier,
  });
  final double progress;
  final WhisperModelNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final downloadedMb = (progress * WhisperModelNotifier.approximateSizeBytes /
            (1024 * 1024))
        .toStringAsFixed(0);
    final percentLabel = '${(progress * 100).toStringAsFixed(0)}%'
        ' — $downloadedMb MB / 142 MB';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: progress,
          color: primaryTeal,
          backgroundColor: primaryTeal.withAlpha(51),
          minHeight: 6,
          borderRadius: BorderRadius.circular(radiusPill),
        ),
        const SizedBox(height: spaceSm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              percentLabel,
              style:
                  theme.textTheme.bodySmall?.copyWith(color: onSurfaceMuted),
            ),
            TextButton(
              onPressed: () => notifier.cancelDownload(),
              style: TextButton.styleFrom(
                foregroundColor: errorRed,
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
              ),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ],
    );
  }
}

class _DownloadedBody extends StatelessWidget {
  const _DownloadedBody({
    required this.filePath,
    required this.notifier,
  });
  final String filePath;
  final WhisperModelNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Show only the last two path segments to keep it readable.
    final parts = filePath.replaceAll('\\', '/').split('/');
    final shortPath = parts.length > 2
        ? '…/${parts[parts.length - 2]}/${parts.last}'
        : filePath;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.check_circle_outline,
                color: gatePassGreen, size: 18),
            const SizedBox(width: spaceSm),
            Text(
              'Model ready',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: gatePassGreen,
              ),
            ),
          ],
        ),
        const SizedBox(height: spaceXs),
        Text(
          shortPath,
          style: theme.textTheme.bodySmall?.copyWith(
            color: onSurfaceMuted,
            fontFamily: 'RobotoMono',
          ),
        ),
        const SizedBox(height: spaceMd),
        OutlinedButton.icon(
          icon: const Icon(Icons.delete_outline, size: 16),
          label: const Text('Delete Model'),
          onPressed: () => notifier.deleteModel(),
          style: OutlinedButton.styleFrom(
            foregroundColor: errorRed,
            side: const BorderSide(color: errorRed),
            visualDensity: VisualDensity.compact,
          ),
        ),
      ],
    );
  }
}

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.message, required this.notifier});
  final String message;
  final WhisperModelNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          message,
          style: theme.textTheme.bodySmall?.copyWith(color: errorRed),
        ),
        const SizedBox(height: spaceSm),
        FilledButton.icon(
          icon: const Icon(Icons.refresh, size: 16),
          label: const Text('Retry'),
          onPressed: () => notifier.startDownload(),
        ),
      ],
    );
  }
}

// ─── Shared ───────────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: spaceSm, left: 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: primaryTeal,
              letterSpacing: 1.2,
            ),
      ),
    );
  }
}

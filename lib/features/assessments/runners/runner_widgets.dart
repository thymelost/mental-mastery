import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/tokens.dart';
import '../../../services/hr_monitor/hr_monitor_service.dart';

/// Shared UI helpers used across all assessment runner widgets.
/// Extracted here so runner files can import them without depending on b1.

class InstructionCard extends StatelessWidget {
  const InstructionCard({super.key, required this.steps});
  final List<String> steps;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: surfaceVariantDark,
      child: Padding(
        padding: const EdgeInsets.all(spaceMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: steps.asMap().entries.map((e) {
            return Padding(
              padding: const EdgeInsets.only(bottom: spaceXs),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${e.key + 1}. ',
                    style: theme.textTheme.bodySmall?.copyWith(color: primaryTeal),
                  ),
                  Expanded(
                    child: Text(e.value, style: theme.textTheme.bodySmall),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ThresholdCard extends StatelessWidget {
  const ThresholdCard({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(spaceMd),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.flag_outlined, size: 16, color: primaryTeal),
            const SizedBox(width: spaceSm),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: onSurfaceMuted),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── HR Monitor Panel ─────────────────────────────────────────────────────────

/// Bluetooth LE HRM scan / connect panel with Samsung Galaxy Watch setup note.
///
/// Drop this widget into any assessment runner that uses an HR monitor (B2, B8).
/// Handles scanning, device selection, connection, and live BPM display.
///
/// [onHrChanged] is called each time a new BPM reading arrives — use it to
/// auto-populate resting-HR fields in runners that need a numeric HR value.
class HrScanPanel extends ConsumerWidget {
  const HrScanPanel({super.key, this.onHrChanged});

  final ValueChanged<int>? onHrChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hrState = ref.watch(hrMonitorProvider);
    final notifier = ref.read(hrMonitorProvider.notifier);
    final theme = Theme.of(context);

    ref.listen(hrMonitorProvider, (prev, next) {
      if (next.heartRate != null && next.heartRate != prev?.heartRate) {
        onHrChanged?.call(next.heartRate!);
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Samsung Galaxy Watch setup note.
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: spaceMd, vertical: spaceSm),
          decoration: BoxDecoration(
            color: primaryTeal.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(color: primaryTeal.withValues(alpha: 0.25)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.watch_outlined, size: 15, color: primaryTeal),
              const SizedBox(width: spaceSm),
              Expanded(
                child: Text(
                  'Samsung Galaxy Watch: open the workout app and start any '
                  'workout session before tapping Scan — the watch only '
                  'broadcasts its HR via Bluetooth LE while a workout is active.',
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: primaryTeal.withValues(alpha: 0.85)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: spaceSm),

        if (hrState.status == HrMonitorStatus.connected &&
            hrState.connectedDevice != null) ...[
          // Connected state — device name + live BPM.
          Card(
            color: surfaceVariantDark,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: spaceMd, vertical: spaceSm),
              child: Row(
                children: [
                  Icon(Icons.favorite, size: 16, color: errorRed),
                  const SizedBox(width: spaceSm),
                  Expanded(
                    child: Text(
                      _deviceName(hrState.connectedDevice!),
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                  Text(
                    hrState.heartRate != null
                        ? '${hrState.heartRate} bpm'
                        : '— bpm',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: primaryTeal,
                      fontFamily: 'RobotoMono',
                    ),
                  ),
                  const SizedBox(width: spaceSm),
                  TextButton(
                    onPressed: notifier.disconnect,
                    child: const Text('Disconnect'),
                  ),
                ],
              ),
            ),
          ),
        ] else ...[
          // Disconnected / scanning / connecting state.
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              icon: hrState.status == HrMonitorStatus.scanning
                  ? const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.bluetooth_searching, size: 18),
              label: Text(
                switch (hrState.status) {
                  HrMonitorStatus.scanning => 'Scanning…  (tap to stop)',
                  HrMonitorStatus.connecting => 'Connecting…',
                  _ => 'Scan for HR Monitor',
                },
              ),
              onPressed: switch (hrState.status) {
                HrMonitorStatus.scanning => notifier.stopScan,
                HrMonitorStatus.connecting => null,
                _ => notifier.startScan,
              },
            ),
          ),

          // Scan results — only devices that advertise a name.
          if (hrState.scanResults.isNotEmpty) ...[
            const SizedBox(height: spaceXs),
            ..._namedResults(hrState.scanResults).map(
              (r) => ListTile(
                dense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: spaceSm),
                leading:
                    const Icon(Icons.bluetooth, size: 18, color: primaryTeal),
                title: Text(_deviceName(r.device),
                    style: theme.textTheme.bodySmall),
                trailing: Text('${r.rssi} dBm',
                    style: theme.textTheme.labelSmall
                        ?.copyWith(color: onSurfaceMuted)),
                onTap: () => notifier.connectToDevice(r.device),
              ),
            ),
          ],

          // Error message.
          if (hrState.error != null) ...[
            const SizedBox(height: spaceXs),
            Text(
              hrState.error!,
              style: theme.textTheme.bodySmall?.copyWith(color: errorRed),
            ),
          ],
        ],
      ],
    );
  }

  String _deviceName(BluetoothDevice device) =>
      device.platformName.isNotEmpty ? device.platformName : 'Unknown device';

  List<ScanResult> _namedResults(List<ScanResult> results) =>
      results.where((r) => r.device.platformName.isNotEmpty).toList();
}

// ─── Input decoration ──────────────────────────────────────────────────────────

InputDecoration runnerInputDecoration(String hint) => InputDecoration(
      hintText: hint,
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
    );

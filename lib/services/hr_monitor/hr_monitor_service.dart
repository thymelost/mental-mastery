import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

// ─── State ────────────────────────────────────────────────────────────────────

enum HrMonitorStatus { disconnected, scanning, connecting, connected, error }

class HrMonitorState {
  const HrMonitorState({
    this.status = HrMonitorStatus.disconnected,
    this.scanResults = const [],
    this.connectedDevice,
    this.heartRate,
    this.error,
  });

  final HrMonitorStatus status;
  final List<ScanResult> scanResults;
  final BluetoothDevice? connectedDevice;
  final int? heartRate;
  final String? error;

  HrMonitorState copyWith({
    HrMonitorStatus? status,
    List<ScanResult>? scanResults,
    BluetoothDevice? connectedDevice,
    int? heartRate,
    String? error,
    bool clearDevice = false,
    bool clearHr = false,
    bool clearError = false,
  }) {
    return HrMonitorState(
      status: status ?? this.status,
      scanResults: scanResults ?? this.scanResults,
      connectedDevice: clearDevice ? null : (connectedDevice ?? this.connectedDevice),
      heartRate: clearHr ? null : (heartRate ?? this.heartRate),
      error: clearError ? null : (error ?? this.error),
    );
  }
}

// ─── Notifier ─────────────────────────────────────────────────────────────────

class HrMonitorNotifier extends StateNotifier<HrMonitorState> {
  HrMonitorNotifier() : super(const HrMonitorState());

  StreamSubscription? _scanSub;
  StreamSubscription? _hrSub;
  StreamSubscription? _connectionSub;
  BluetoothDevice? _device;

  // BLE UUID constants — Heart Rate Service and Measurement characteristic.
  static const _hrServiceUuid = '0000180d-0000-1000-8000-00805f9b34fb';
  static const _hrMeasurementUuid = '00002a37-0000-1000-8000-00805f9b34fb';

  // ── Public API ─────────────────────────────────────────────────────────────

  Future<void> startScan() async {
    if (state.status == HrMonitorStatus.scanning) return;

    // Request runtime permissions.
    final permGranted = await _requestPermissions();
    if (!permGranted) {
      state = state.copyWith(
        status: HrMonitorStatus.error,
        error: 'Bluetooth permissions not granted. Enable them in App Settings.',
      );
      return;
    }

    // Check adapter state.
    final adapterState = await FlutterBluePlus.adapterState.first;
    if (adapterState != BluetoothAdapterState.on) {
      state = state.copyWith(
        status: HrMonitorStatus.error,
        error: 'Bluetooth is off. Please enable Bluetooth and try again.',
      );
      return;
    }

    state = state.copyWith(
      status: HrMonitorStatus.scanning,
      scanResults: [],
      clearError: true,
    );

    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    _scanSub = FlutterBluePlus.scanResults.listen(
      (results) => state = state.copyWith(scanResults: results),
      onError: (_) => stopScan(),
    );
    // Auto-stop after timeout.
    FlutterBluePlus.isScanning.where((v) => !v).first.then((_) {
      if (state.status == HrMonitorStatus.scanning) {
        state = state.copyWith(status: HrMonitorStatus.disconnected);
      }
    });
  }

  Future<void> stopScan() async {
    await FlutterBluePlus.stopScan();
    _scanSub?.cancel();
    _scanSub = null;
    if (state.status == HrMonitorStatus.scanning) {
      state = state.copyWith(status: HrMonitorStatus.disconnected);
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    await stopScan();
    state = state.copyWith(
      status: HrMonitorStatus.connecting,
      clearError: true,
    );
    _device = device;

    try {
      await device.connect(timeout: const Duration(seconds: 15));
      _connectionSub = device.connectionState.listen((s) {
        if (s == BluetoothConnectionState.disconnected) {
          _hrSub?.cancel();
          _hrSub = null;
          _device = null;
          state = state.copyWith(
            status: HrMonitorStatus.disconnected,
            clearDevice: true,
            clearHr: true,
          );
        }
      });

      final services = await device.discoverServices();
      final hrService = services.where((s) {
        return s.serviceUuid.toString().toLowerCase() == _hrServiceUuid;
      }).firstOrNull;

      if (hrService == null) {
        await device.disconnect();
        state = state.copyWith(
          status: HrMonitorStatus.error,
          error: 'Device does not expose a Heart Rate service.',
          clearDevice: true,
        );
        return;
      }

      final hrChar = hrService.characteristics.where((c) {
        return c.characteristicUuid.toString().toLowerCase() ==
            _hrMeasurementUuid;
      }).firstOrNull;

      if (hrChar == null) {
        await device.disconnect();
        state = state.copyWith(
          status: HrMonitorStatus.error,
          error: 'Heart Rate Measurement characteristic not found.',
          clearDevice: true,
        );
        return;
      }

      await hrChar.setNotifyValue(true);
      state = state.copyWith(
        status: HrMonitorStatus.connected,
        connectedDevice: device,
      );

      _hrSub = hrChar.onValueReceived.listen(_parseHrData);
    } catch (e) {
      _device = null;
      state = state.copyWith(
        status: HrMonitorStatus.error,
        error: 'Connection failed: ${e.runtimeType}',
        clearDevice: true,
      );
    }
  }

  Future<void> disconnect() async {
    _hrSub?.cancel();
    _hrSub = null;
    _connectionSub?.cancel();
    _connectionSub = null;
    await _device?.disconnect();
    _device = null;
    state = state.copyWith(
      status: HrMonitorStatus.disconnected,
      clearDevice: true,
      clearHr: true,
      clearError: true,
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  /// Parse Heart Rate Measurement characteristic value (Bluetooth spec format).
  /// Byte 0: flags. Bit 0 = 0 → HR is uint8 at byte 1; bit 0 = 1 → HR is
  /// uint16 at bytes 1–2 (little-endian).
  void _parseHrData(List<int> data) {
    if (data.isEmpty) return;
    final flags = data[0];
    final is16bit = (flags & 0x01) != 0;
    final hr = is16bit
        ? ((data[2] << 8) | data[1])
        : data[1];
    state = state.copyWith(heartRate: hr);
  }

  Future<bool> _requestPermissions() async {
    final statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.locationWhenInUse,
    ].request();
    return statuses.values.every(
      (s) => s.isGranted || s.isLimited,
    );
  }

  @override
  void dispose() {
    _scanSub?.cancel();
    _hrSub?.cancel();
    _connectionSub?.cancel();
    _device?.disconnect();
    super.dispose();
  }
}

// ─── Provider ─────────────────────────────────────────────────────────────────

final hrMonitorProvider =
    StateNotifierProvider<HrMonitorNotifier, HrMonitorState>(
  (ref) => HrMonitorNotifier(),
);

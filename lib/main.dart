import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'app.dart';
import 'core/navigation_key.dart';
import 'services/alarm/alarm_service.dart';

void main() async {
  // Required before calling path_provider or any plugin before runApp.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize timezone data for scheduled notifications.
  tz.initializeTimeZones();

  // Initialize AlarmService. Notification taps navigate via the root key.
  await AlarmService.instance.initialize(
    onTap: (payload) {
      final context = rootNavigatorKey.currentContext;
      final route = AlarmService.routeForPayload(payload);
      if (context != null && route != null) {
        // ignore: use_build_context_synchronously
        context.go(route);
      }
    },
  );

  runApp(
    const ProviderScope(
      child: MentalMasteryApp(),
    ),
  );
}

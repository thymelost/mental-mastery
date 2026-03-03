import 'package:flutter/material.dart';

/// Root navigator key used by go_router.
/// Also accessed by AlarmService to navigate from notification taps
/// without needing a BuildContext.
final rootNavigatorKey = GlobalKey<NavigatorState>();

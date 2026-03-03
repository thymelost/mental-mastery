import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/tokens.dart';

/// Shown when a user attempts to access phase content that is not yet unlocked.
class PhaseLockScreen extends StatelessWidget {
  const PhaseLockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(spaceXl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.lock_outline,
                size: 64,
                color: phaseLocked,
              ),
              const SizedBox(height: spaceLg),
              Text(
                'Phase Not Yet Available',
                style: theme.textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: spaceMd),
              Text(
                'Complete the current phase and pass its gate assessment '
                'to unlock this content.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: onSurfaceMuted,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: spaceXl),
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('Return to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

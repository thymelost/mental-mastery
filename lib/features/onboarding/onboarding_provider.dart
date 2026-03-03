import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tracks scroll progress through the onboarding document (0.0 – 1.0).
/// Used to enable the "I Understand" button only after ~95% of the doc is read.
class ScrollProgressNotifier extends StateNotifier<double> {
  ScrollProgressNotifier() : super(0.0);

  void updateProgress(double fraction) {
    // Clamp to [0.0, 1.0] and only update if meaningfully changed.
    final clamped = fraction.clamp(0.0, 1.0);
    if ((clamped - state).abs() > 0.005) {
      state = clamped;
    }
  }
}

final onboardingScrollProvider =
    StateNotifierProvider<ScrollProgressNotifier, double>(
  (ref) => ScrollProgressNotifier(),
);

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../navigation_key.dart';
import '../providers.dart';
import '../../features/dev/dev_test_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/phase_journey/phase_journey_screen.dart';
import '../../features/practices/practice_detail_screen.dart';
import '../../features/practices/practice_session_screen.dart';
import '../../features/practices/session_complete_screen.dart';
import '../../features/assessments/assessment_hub_screen.dart';
import '../../features/assessments/assessment_runner_screen.dart';
import '../../features/assessments/assessment_result_screen.dart';
import '../../features/journal/journal_hub_screen.dart';
import '../../features/journal/journal_entry_screen.dart';
import '../../features/journal/journal_entry_view_screen.dart';
import '../../features/shared/phase_lock_screen.dart';
import '../../features/shared/doc_reader_screen.dart';
import '../../features/gates/gate_screen.dart';
import '../../features/gates/gate_evaluation_screen.dart';
import '../../features/gates/gate_result_screen.dart';
import '../../features/progress/progress_screen.dart';
import '../../features/settings/settings_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = _OnboardingNotifier(ref);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    refreshListenable: notifier,
    redirect: (context, state) {
      final onboarded = ref.read(onboardingCompleteProvider);
      final onOnboarding = state.fullPath == '/onboarding';

      if (!onboarded && !onOnboarding) return '/onboarding';
      if (onboarded && onOnboarding) return '/';
      return null;
    },
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (_, __) => const OnboardingScreen(),
      ),

      // ── Practice routes (outside shell — full-screen, no bottom nav) ──
      GoRoute(
        path: '/practice/:id',
        builder: (_, state) => PracticeDetailScreen(
          practiceId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/practice/:id/session',
        builder: (_, state) => PracticeSessionScreen(
          practiceId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/practice/:id/session/complete',
        builder: (_, state) => SessionCompleteScreen(
          practiceId: state.pathParameters['id']!,
        ),
      ),

      // ── Journal routes (outside shell — full-screen) ──────────────────
      GoRoute(
        path: '/journal/new',
        builder: (_, state) => JournalEntryScreen(
          templateId: state.uri.queryParameters['templateId'],
        ),
      ),
      GoRoute(
        path: '/journal/:id',
        builder: (_, state) => JournalEntryViewScreen(
          entryId: int.parse(state.pathParameters['id']!),
        ),
      ),

      // ── Assessment routes (outside shell — full-screen) ──────────────
      GoRoute(
        path: '/assessment/:id',
        builder: (_, state) => AssessmentRunnerScreen(
          assessmentId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/assessment/:id/result/:resultId',
        builder: (_, state) => AssessmentResultScreen(
          resultId: int.parse(state.pathParameters['resultId']!),
        ),
      ),

      // ── Shell routes — bottom navigation bar ──────────────────────────
      ShellRoute(
        builder: (_, __, child) => HomeShell(child: child),
        routes: [
          GoRoute(
            path: '/',
            builder: (_, __) => const HomeScreen(),
          ),
          GoRoute(
            path: '/phases',
            builder: (_, __) => const PhaseJourneyScreen(),
          ),
          GoRoute(
            path: '/journal',
            builder: (_, __) => const JournalHubScreen(),
          ),
          GoRoute(
            path: '/assessments',
            builder: (_, __) => const AssessmentHubScreen(),
          ),
          GoRoute(
            path: '/progress',
            builder: (_, __) => const ProgressScreen(),
          ),
        ],
      ),

      // ── Gate routes (full-screen, no bottom nav) ──────────────────────
      GoRoute(
        path: '/gate/:number',
        builder: (_, state) => GateScreen(
          gateNumber: int.parse(state.pathParameters['number']!),
        ),
      ),
      GoRoute(
        path: '/gate/:number/evaluate',
        builder: (_, state) => GateEvaluationScreen(
          gateNumber: int.parse(state.pathParameters['number']!),
        ),
      ),
      GoRoute(
        path: '/gate/:number/result',
        builder: (_, state) => GateResultScreen(
          gateNumber: int.parse(state.pathParameters['number']!),
        ),
      ),

      GoRoute(
        path: '/phase-locked',
        builder: (_, __) => const PhaseLockScreen(),
      ),

      // ── Reference library ─────────────────────────────────────────────
      GoRoute(
        path: '/doc/:filename',
        builder: (_, state) => DocReaderScreen(
          filename: state.pathParameters['filename']!,
        ),
      ),

      // ── Settings ──────────────────────────────────────────────────────
      GoRoute(
        path: '/settings',
        builder: (_, __) => const SettingsScreen(),
      ),

      // ── Developer test mode (debug builds only) ───────────────────────
      if (kDebugMode)
        GoRoute(
          path: '/dev-test',
          builder: (_, __) => const DevTestScreen(),
        ),
    ],
  );
});

class _OnboardingNotifier extends ChangeNotifier {
  _OnboardingNotifier(Ref ref) {
    ref.listen(onboardingCompleteProvider, (_, __) => notifyListeners());
  }
}

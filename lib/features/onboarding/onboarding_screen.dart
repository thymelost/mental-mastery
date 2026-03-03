import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/database/drift_provider.dart';
import '../../core/theme/tokens.dart';
import '../../core/widgets/markdown_viewer.dart';
import 'onboarding_provider.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _dbInitialized = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _initDb();
  }

  Future<void> _initDb() async {
    final db = ref.read(appDatabaseProvider);
    await db.userStateDao.ensureInitialized();
    await db.phaseProgressDao.ensurePhase0Active();
    if (mounted) setState(() => _dbInitialized = true);
  }

  void _onScroll() {
    final max = _scrollController.position.maxScrollExtent;
    if (max <= 0) return;
    final fraction = _scrollController.offset / max;
    ref.read(onboardingScrollProvider.notifier).updateProgress(fraction);
  }

  Future<void> _complete() async {
    final db = ref.read(appDatabaseProvider);
    await db.userStateDao.setOnboardingComplete();
    if (mounted) context.go('/');
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scrollProgress = ref.watch(onboardingScrollProvider);
    final canProceed = _dbInitialized && scrollProgress >= 0.95;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mental Mastery — Getting Started'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // ── Progress indicator ──────────────────────────────────────
          LinearProgressIndicator(
            value: scrollProgress,
            backgroundColor: surfaceVariantDark,
            valueColor: AlwaysStoppedAnimation<Color>(primaryTeal),
            minHeight: 3,
          ),

          // ── Scrollable guide ────────────────────────────────────────
          Expanded(
            child: MarkdownViewer(
              assetPath: 'assets/docs/onboarding-guide.md',
              scrollController: _scrollController,
              padding: const EdgeInsets.fromLTRB(
                spaceMd, spaceMd, spaceMd, spaceXxl,
              ),
            ),
          ),

          // ── Bottom bar with confirm button ──────────────────────────
          Container(
            color: surfaceDark,
            padding: EdgeInsets.fromLTRB(
              spaceMd,
              spaceSm,
              spaceMd,
              spaceMd + MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!canProceed && scrollProgress < 0.95)
                  Padding(
                    padding: const EdgeInsets.only(bottom: spaceSm),
                    child: Text(
                      'Scroll to the end to continue',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: canProceed ? _complete : null,
                    child: const Text('I have read and understood this guide'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

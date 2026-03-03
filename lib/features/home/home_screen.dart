import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../content/phases/all_phases.dart';
import '../../content/practices/practice_model.dart';
import '../../core/providers.dart';
import '../../core/theme/tokens.dart';
import '../../core/widgets/library_panel.dart';
import '../../core/widgets/phase_badge.dart';
import '../practices/practice_provider.dart';

// ─── HomeShell ───────────────────────────────────────────────────────────────

class HomeShell extends ConsumerStatefulWidget {
  const HomeShell({super.key, required this.child});
  final Widget child;

  @override
  ConsumerState<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends ConsumerState<HomeShell> {
  int _selectedIndex = 0;

  static const _destinations = [
    _NavDest(label: 'Home', icon: Icons.home_outlined, path: '/'),
    _NavDest(label: 'Phases', icon: Icons.account_tree_outlined, path: '/phases'),
    _NavDest(label: 'Journal', icon: Icons.book_outlined, path: '/journal'),
    _NavDest(label: 'Assessments', icon: Icons.assignment_outlined, path: '/assessments'),
    _NavDest(label: 'Progress', icon: Icons.show_chart, path: '/progress'),
  ];

  void _onNavTap(int index) {
    if (_destinations[index].disabled) return;
    setState(() => _selectedIndex = index);
    context.go(_destinations[index].path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const LibraryPanel(),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTap,
        items: _destinations
            .map(
              (d) => BottomNavigationBarItem(
                icon: Icon(d.icon),
                label: d.label,
                tooltip: d.disabled ? 'Coming in a later build' : null,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _NavDest {
  const _NavDest({
    required this.label,
    required this.icon,
    required this.path,
    this.disabled = false,
  });
  final String label;
  final IconData icon;
  final String path;
  final bool disabled;
}

// ─── HomeScreen ──────────────────────────────────────────────────────────────

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPhaseNum = ref.watch(currentPhaseProvider);
    final currentPhase = kPhases.firstWhere(
      (p) => p.phaseNumber == currentPhaseNum,
      orElse: () => kPhases.first,
    );
    final practices = ref.watch(practicesForPhaseProvider(currentPhaseNum));

    final morning = practices.where((p) => p.scheduleSlot == 'morning').toList();
    final midday = practices.where((p) => p.scheduleSlot == 'midday').toList();
    final evening = practices.where((p) => p.scheduleSlot == 'evening').toList();
    final triggered = practices.where((p) => p.scheduleSlot == 'triggered').toList();

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('Mental Mastery'),
          floating: true,
          snap: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.menu_book_outlined),
              tooltip: 'Reference Library',
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              tooltip: 'Settings',
              onPressed: () => context.push('/settings'),
            ),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.all(spaceMd),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // ── Active phase card ──────────────────────────────────────
              _ActivePhaseCard(
                phaseNumber: currentPhaseNum,
                phaseName: currentPhase.name,
                layer: currentPhase.layer,
                durationNote: currentPhase.durationNote,
              ),
              const SizedBox(height: spaceLg),

              // ── Schedule blocks ────────────────────────────────────────
              if (practices.isEmpty)
                _EmptyScheduleCard(phaseNumber: currentPhaseNum)
              else ...[
                if (morning.isNotEmpty) ...[
                  _ScheduleBlock(
                    slot: 'Morning',
                    icon: Icons.wb_sunny_outlined,
                    practices: morning,
                  ),
                  const SizedBox(height: spaceMd),
                ],
                if (midday.isNotEmpty) ...[
                  _ScheduleBlock(
                    slot: 'Midday',
                    icon: Icons.wb_cloudy_outlined,
                    practices: midday,
                  ),
                  const SizedBox(height: spaceMd),
                ],
                if (evening.isNotEmpty) ...[
                  _ScheduleBlock(
                    slot: 'Evening',
                    icon: Icons.nights_stay_outlined,
                    practices: evening,
                  ),
                  const SizedBox(height: spaceMd),
                ],
                if (triggered.isNotEmpty) ...[
                  _ScheduleBlock(
                    slot: 'As triggered',
                    icon: Icons.notifications_none_outlined,
                    practices: triggered,
                  ),
                  const SizedBox(height: spaceMd),
                ],
              ],
              const SizedBox(height: 80),
            ]),
          ),
        ),
      ],
    );
  }
}

// ─── Sub-widgets ──────────────────────────────────────────────────────────────

class _ActivePhaseCard extends StatelessWidget {
  const _ActivePhaseCard({
    required this.phaseNumber,
    required this.phaseName,
    required this.layer,
    required this.durationNote,
  });

  final int phaseNumber;
  final String phaseName;
  final String layer;
  final String durationNote;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(spaceLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'CURRENT PHASE',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: primaryTeal,
                    letterSpacing: 1.2,
                  ),
                ),
                const Spacer(),
                const PhaseBadge(status: PhaseStatus.active),
              ],
            ),
            const SizedBox(height: spaceSm),
            Text(
              'Phase $phaseNumber — $phaseName',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: spaceXs),
            Row(
              children: [
                Text(layer, style: theme.textTheme.bodySmall),
                const SizedBox(width: spaceSm),
                Text('·', style: theme.textTheme.bodySmall),
                const SizedBox(width: spaceSm),
                Icon(Icons.schedule, size: 12, color: onSurfaceMuted),
                const SizedBox(width: 4),
                Text(durationNote, style: theme.textTheme.bodySmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ScheduleBlock extends StatelessWidget {
  const _ScheduleBlock({
    required this.slot,
    required this.icon,
    required this.practices,
  });

  final String slot;
  final IconData icon;
  final List<PracticeContent> practices;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: onSurfaceMuted),
            const SizedBox(width: spaceSm),
            Text(
              slot.toUpperCase(),
              style: theme.textTheme.labelSmall?.copyWith(letterSpacing: 1.1),
            ),
          ],
        ),
        const SizedBox(height: spaceSm),
        ...practices.map((p) => _PracticeCard(practice: p)),
      ],
    );
  }
}

class _PracticeCard extends StatelessWidget {
  const _PracticeCard({required this.practice});
  final PracticeContent practice;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: spaceSm),
      child: InkWell(
        borderRadius: BorderRadius.circular(radiusLg),
        onTap: () => context.go('/practice/${practice.id}'),
        child: Padding(
          padding: const EdgeInsets.all(spaceMd),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(practice.name, style: theme.textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text(
                      '${practice.durationMinutes} min  ·  ${practice.skillIds.join(", ")}',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, size: 18, color: onSurfaceMuted),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyScheduleCard extends StatelessWidget {
  const _EmptyScheduleCard({required this.phaseNumber});
  final int phaseNumber;

  @override
  Widget build(BuildContext context) {
    final isAssessmentPhase = phaseNumber == 0 || phaseNumber == 6;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(spaceLg),
        child: Row(
          children: [
            Icon(
              isAssessmentPhase
                  ? Icons.assignment_outlined
                  : Icons.playlist_play_outlined,
              color: onSurfaceMuted,
              size: 28,
            ),
            const SizedBox(width: spaceMd),
            Expanded(
              child: Text(
                isAssessmentPhase
                    ? 'Phase $phaseNumber is assessment-focused. '
                        'Use the Assessments section to complete your protocols.'
                    : 'No practices found for Phase $phaseNumber.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

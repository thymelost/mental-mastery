import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../content/assessments/all_assessments.dart';
import '../../content/practices/all_practices.dart';
import '../../core/database/drift_provider.dart';
import '../../core/providers.dart';
import '../../core/theme/tokens.dart';

/// Developer test screen — only reachable in debug builds (kDebugMode == true).
/// Provides direct navigation to every practice, assessment, and gate,
/// plus phase override and DB reset controls.
///
/// NEVER included in release builds: the route and entry point are both
/// gated behind [kDebugMode] in router.dart and settings_screen.dart.
class DevTestScreen extends ConsumerStatefulWidget {
  const DevTestScreen({super.key});

  @override
  ConsumerState<DevTestScreen> createState() => _DevTestScreenState();
}

class _DevTestScreenState extends ConsumerState<DevTestScreen> {
  int _selectedPhase = 0;
  bool _phaseInitialized = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentPhase = ref.watch(currentPhaseProvider);

    // Sync dropdown once on first build.
    if (!_phaseInitialized) {
      _selectedPhase = currentPhase;
      _phaseInitialized = true;
    }

    return Scaffold(
      backgroundColor: backgroundDark,
      appBar: AppBar(
        title: const Text('Dev Test Mode'),
        backgroundColor: errorRed.withValues(alpha: 0.15),
        foregroundColor: errorRed,
      ),
      body: ListView(
        padding: const EdgeInsets.all(spaceMd),
        children: [
          // ── Warning banner ───────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: spaceMd, vertical: spaceSm),
            decoration: BoxDecoration(
              color: errorRed.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: errorRed.withValues(alpha: 0.4)),
            ),
            child: Row(
              children: [
                const Icon(Icons.bug_report_outlined,
                    size: 16, color: errorRed),
                const SizedBox(width: spaceSm),
                Expanded(
                  child: Text(
                    'DEBUG BUILD ONLY — not visible in release APKs.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: errorRed,
                      fontFamily: 'RobotoMono',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: spaceLg),

          // ── Phase control ────────────────────────────────────────────────
          _SectionLabel('PHASE CONTROL'),
          const SizedBox(height: spaceSm),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(spaceMd),
              child: Row(
                children: [
                  Text(
                    'Current phase: $currentPhase',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const Spacer(),
                  DropdownButton<int>(
                    value: _selectedPhase,
                    items: List.generate(
                      9,
                      (i) => DropdownMenuItem(
                        value: i,
                        child: Text('Phase $i'),
                      ),
                    ),
                    onChanged: (v) {
                      if (v != null) setState(() => _selectedPhase = v);
                    },
                  ),
                  const SizedBox(width: spaceSm),
                  ElevatedButton(
                    onPressed: () => _setPhase(_selectedPhase),
                    child: const Text('Set'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: spaceLg),

          // ── DB reset ─────────────────────────────────────────────────────
          _SectionLabel('DATABASE'),
          const SizedBox(height: spaceSm),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(spaceMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Wipes all rows from every table and re-initialises '
                    'the user state row. Navigation returns to onboarding.',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: onSurfaceMuted),
                  ),
                  const SizedBox(height: spaceMd),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.delete_forever_outlined,
                        size: 16, color: errorRed),
                    label: const Text(
                      'Reset Database',
                      style: TextStyle(color: errorRed),
                    ),
                    onPressed: () => _confirmReset(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: errorRed),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: spaceLg),

          // ── Practices ────────────────────────────────────────────────────
          _SectionLabel('PRACTICES (${kPractices.length} total)'),
          const SizedBox(height: spaceSm),
          ..._practicesByPhase(context),
          const SizedBox(height: spaceLg),

          // ── Assessments ──────────────────────────────────────────────────
          _SectionLabel('ASSESSMENTS (${kAssessments.length} total)'),
          const SizedBox(height: spaceSm),
          Card(
            child: Column(
              children: kAssessments.asMap().entries.map((e) {
                final a = e.value;
                return ListTile(
                  dense: true,
                  title: Text(a.id, style: theme.textTheme.bodyMedium),
                  subtitle: Text(
                    a.name,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: onSurfaceMuted),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      size: 12, color: onSurfaceMuted),
                  onTap: () =>
                      context.push('/assessment/${a.id}'),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: spaceLg),

          // ── Gates ────────────────────────────────────────────────────────
          _SectionLabel('GATES (1 – 7)'),
          const SizedBox(height: spaceSm),
          Card(
            child: Column(
              children: List.generate(7, (i) {
                final n = i + 1;
                return ListTile(
                  dense: true,
                  title: Text(
                    'Gate $n (Phase $n → Phase ${n + 1})',
                    style: theme.textTheme.bodyMedium,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      size: 12, color: onSurfaceMuted),
                  onTap: () => context.push('/gate/$n'),
                );
              }),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  List<Widget> _practicesByPhase(BuildContext context) {
    final theme = Theme.of(context);
    final byPhase = <int, List<_PracticeEntry>>{};
    for (final p in kPractices) {
      byPhase
          .putIfAbsent(p.phaseNumber, () => [])
          .add(_PracticeEntry(p.id, p.name));
    }
    final phases = byPhase.keys.toList()..sort();

    return phases.map((phase) {
      final entries = byPhase[phase]!;
      return Padding(
        padding: const EdgeInsets.only(bottom: spaceSm),
        child: ExpansionTile(
          title: Text(
            'Phase $phase  (${entries.length} practices)',
            style: theme.textTheme.bodyMedium,
          ),
          tilePadding:
              const EdgeInsets.symmetric(horizontal: spaceMd),
          childrenPadding: EdgeInsets.zero,
          backgroundColor: surfaceVariantDark,
          collapsedBackgroundColor: surfaceVariantDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          children: entries.map((e) {
            return ListTile(
              dense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: spaceLg),
              title: Text(
                e.id,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontFamily: 'RobotoMono',
                ),
              ),
              subtitle: Text(
                e.name,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: onSurfaceMuted),
              ),
              trailing: const Icon(Icons.arrow_forward_ios,
                  size: 12, color: onSurfaceMuted),
              onTap: () => context.push('/practice/${e.id}'),
            );
          }).toList(),
        ),
      );
    }).toList();
  }

  Future<void> _setPhase(int phase) async {
    final db = ref.read(appDatabaseProvider);
    await db.userStateDao.setCurrentPhase(phase);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Phase set to $phase')),
      );
    }
  }

  void _confirmReset(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset database?'),
        content: const Text(
          'All rows in all tables will be deleted. '
          'The app will return to onboarding. This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(true);
              _resetDatabase();
            },
            child: Text(
              'Reset',
              style: TextStyle(color: errorRed),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _resetDatabase() async {
    final db = ref.read(appDatabaseProvider);
    await db.transaction(() async {
      await db.delete(db.statsQueueTable).go();
      await db.delete(db.scheduledAlarmsTable).go();
      await db.delete(db.longitudinalMetricsTable).go();
      await db.delete(db.gateCriteriaStatesTable).go();
      await db.delete(db.gateStatesTable).go();
      await db.delete(db.journalEntriesTable).go();
      await db.delete(db.assessmentResultsTable).go();
      await db.delete(db.practiceSessionsTable).go();
      await db.delete(db.phaseProgressTable).go();
      await db.delete(db.userStateTable).go();
    });
    await db.userStateDao.ensureInitialized();
    if (mounted) {
      context.go('/');
    }
  }
}

// ── Internal helpers ──────────────────────────────────────────────────────────

class _PracticeEntry {
  const _PracticeEntry(this.id, this.name);
  final String id;
  final String name;
}

// ── Sub-widgets ───────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: errorRed,
            letterSpacing: 1.2,
          ),
    );
  }
}

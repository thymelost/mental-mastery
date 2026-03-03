import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/tokens.dart';

/// Slide-out reference library drawer.
/// Lists all 8 bundled framework documents. Each item navigates to
/// /doc/:filename which renders the markdown asset in DocReaderScreen.
class LibraryPanel extends StatelessWidget {
  const LibraryPanel({super.key});

  static const _docs = [
    _DocEntry(
      filename: 'onboarding-guide',
      title: 'Onboarding Guide',
      subtitle: 'Start here — Phase 0 walkthrough',
      icon: Icons.start_outlined,
    ),
    _DocEntry(
      filename: 'quick-reference',
      title: 'Quick Reference',
      subtitle: 'All 41 skills, gates, failure modes',
      icon: Icons.quick_contacts_dialer_outlined,
    ),
    _DocEntry(
      filename: 'skill-taxonomy',
      title: 'Skill Taxonomy',
      subtitle: '3 layers · 9 domains · 41 skills (v0.3)',
      icon: Icons.account_tree_outlined,
    ),
    _DocEntry(
      filename: 'progression-model',
      title: 'Progression Model',
      subtitle: 'Phase thresholds, gate criteria, failure modes',
      icon: Icons.show_chart,
    ),
    _DocEntry(
      filename: 'training-curriculum',
      title: 'Training Curriculum',
      subtitle: '39 practices, minimum effective dose',
      icon: Icons.fitness_center_outlined,
    ),
    _DocEntry(
      filename: 'assessment-tools',
      title: 'Assessment Tools',
      subtitle: 'All instruments, scoring, protocols',
      icon: Icons.assignment_outlined,
    ),
    _DocEntry(
      filename: 'scientific-foundation',
      title: 'Scientific Foundation',
      subtitle: 'Mechanisms, evidence, honest limits',
      icon: Icons.science_outlined,
    ),
    _DocEntry(
      filename: 'research-grounding',
      title: 'Research Grounding',
      subtitle: '33 papers — 7 original + 26 expansion',
      icon: Icons.library_books_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      backgroundColor: surfaceDark,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(spaceLg, spaceLg, spaceLg, spaceSm),
              child: Text(
                'REFERENCE LIBRARY',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: primaryTeal,
                  letterSpacing: 1.4,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: spaceLg),
              child: Text(
                'Framework documents — version 0.2',
                style: theme.textTheme.bodySmall,
              ),
            ),
            const SizedBox(height: spaceMd),
            const Divider(height: 1),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _docs.length,
                itemBuilder: (context, i) => _DocTile(doc: _docs[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DocTile extends StatelessWidget {
  const _DocTile({required this.doc});
  final _DocEntry doc;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(doc.icon, color: onSurfaceMuted, size: 20),
      title: Text(doc.title, style: Theme.of(context).textTheme.bodyMedium),
      subtitle: Text(
        doc.subtitle,
        style: Theme.of(context).textTheme.bodySmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        Navigator.of(context).pop(); // close drawer
        context.go('/doc/${doc.filename}');
      },
    );
  }
}

class _DocEntry {
  const _DocEntry({
    required this.filename,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
  final String filename;
  final String title;
  final String subtitle;
  final IconData icon;
}

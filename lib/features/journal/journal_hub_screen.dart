import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/database/app_database.dart';
import '../../core/providers.dart';
import '../../core/theme/tokens.dart';
import '../../content/templates/all_templates.dart';

class JournalHubScreen extends ConsumerWidget {
  const JournalHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesAsync = ref.watch(journalEntriesProvider);
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('Journal'),
          floating: true,
          snap: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'New entry',
              onPressed: () => _showTemplateSheet(context),
            ),
          ],
        ),
        entriesAsync.when(
          loading: () => const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) => SliverFillRemaining(
            child: Center(child: Text('Error: $e')),
          ),
          data: (entries) {
            if (entries.isEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.book_outlined,
                        size: 48,
                        color: onSurfaceMuted,
                      ),
                      const SizedBox(height: spaceMd),
                      Text(
                        'No entries yet.',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: onSurfaceMuted,
                        ),
                      ),
                      const SizedBox(height: spaceSm),
                      Text(
                        'Tap + to write your first entry.',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              );
            }

            return SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                spaceMd, spaceSm, spaceMd, 80,
              ),
              sliver: SliverList.builder(
                itemCount: entries.length,
                itemBuilder: (context, i) =>
                    _EntryCard(entry: entries[i]),
              ),
            );
          },
        ),
      ],
    );
  }

  void _showTemplateSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: surfaceDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(radiusXl),
        ),
      ),
      builder: (_) => const _TemplatePickerSheet(),
    );
  }
}

// ─── Template picker ─────────────────────────────────────────────────────────

class _TemplatePickerSheet extends StatelessWidget {
  const _TemplatePickerSheet();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      expand: false,
      builder: (ctx, scrollController) => Column(
        children: [
          // Drag handle
          Padding(
            padding: const EdgeInsets.symmetric(vertical: spaceMd),
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: onSurfaceMuted.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(radiusPill),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(spaceLg, 0, spaceLg, spaceMd),
            child: Row(
              children: [
                Text('New journal entry', style: theme.textTheme.headlineSmall),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    context.go('/journal/new');
                  },
                  child: const Text('Freeform'),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: kTemplates.length,
              itemBuilder: (_, i) {
                final t = kTemplates[i];
                return ListTile(
                  title: Text(t.name),
                  subtitle: Text(
                    '${t.fields.length} fields  ·  ${t.id}',
                    style: theme.textTheme.bodySmall,
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    size: 18,
                    color: onSurfaceMuted,
                  ),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    context.go('/journal/new?templateId=${t.id}');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Entry card ───────────────────────────────────────────────────────────────

class _EntryCard extends StatelessWidget {
  const _EntryCard({required this.entry});
  final JournalEntriesTableData entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final date = entry.createdAt;
    final dateStr =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

    final templateName = entry.templateId != null
        ? kTemplates
            .where((t) => t.id == entry.templateId)
            .map((t) => t.name)
            .firstOrNull
        : null;

    return Card(
      margin: const EdgeInsets.only(bottom: spaceSm),
      child: InkWell(
        borderRadius: BorderRadius.circular(radiusLg),
        onTap: () => context.go('/journal/${entry.id}'),
        child: Padding(
          padding: const EdgeInsets.all(spaceMd),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      templateName ?? 'Freeform entry',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$dateStr  ·  Phase ${entry.phaseNumber}'
                      '${entry.wordCount != null ? '  ·  ${entry.wordCount} words' : ''}',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                size: 18,
                color: onSurfaceMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

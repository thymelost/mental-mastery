import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/database/app_database.dart';
import '../../core/database/drift_provider.dart';
import '../../core/theme/tokens.dart';
import '../../content/templates/all_templates.dart';

/// Reads a saved journal entry's flat file and renders it as Markdown.
class JournalEntryViewScreen extends ConsumerWidget {
  const JournalEntryViewScreen({super.key, required this.entryId});

  final int entryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entryAsync = ref.watch(_entryProvider(entryId));

    return entryAsync.when(
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('Journal Entry')),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(title: const Text('Journal Entry')),
        body: Center(child: Text('Error: $e')),
      ),
      data: (entry) {
        if (entry == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Journal Entry')),
            body: const Center(child: Text('Entry not found.')),
          );
        }
        return _EntryView(entry: entry);
      },
    );
  }
}

// ─── Provider ─────────────────────────────────────────────────────────────────

final _entryProvider =
    StreamProvider.family<JournalEntriesTableData?, int>((ref, id) {
  return ref
      .watch(appDatabaseProvider)
      .journalEntriesDao
      .watchEntry(id);
});

// ─── View ─────────────────────────────────────────────────────────────────────

class _EntryView extends StatefulWidget {
  const _EntryView({required this.entry});
  final JournalEntriesTableData entry;

  @override
  State<_EntryView> createState() => _EntryViewState();
}

class _EntryViewState extends State<_EntryView> {
  late Future<String> _contentFuture;

  @override
  void initState() {
    super.initState();
    _contentFuture = _loadFile(widget.entry.filePath);
  }

  @override
  void didUpdateWidget(_EntryView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.entry.filePath != widget.entry.filePath) {
      setState(() {
        _contentFuture = _loadFile(widget.entry.filePath);
      });
    }
  }

  Future<String> _loadFile(String path) async {
    final file = File(path);
    if (!file.existsSync()) {
      return '_Entry file not found._\n\nPath: `$path`';
    }
    return file.readAsString();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entry = widget.entry;
    final date = entry.createdAt;
    final dateStr =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

    final templateName = entry.templateId != null
        ? kTemplates
            .where((t) => t.id == entry.templateId)
            .map((t) => t.name)
            .firstOrNull
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(templateName ?? 'Freeform Entry'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/journal'),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Metadata strip ───────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(spaceLg, spaceMd, spaceLg, 0),
            child: Row(
              children: [
                Text(
                  '$dateStr  ·  Phase ${entry.phaseNumber}',
                  style: theme.textTheme.bodySmall,
                ),
                if (entry.wordCount != null) ...[
                  Text('  ·  ', style: theme.textTheme.bodySmall),
                  Text(
                    '${entry.wordCount} words',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: spaceSm),
          const Divider(height: 1),
          // ── Markdown content ─────────────────────────────────────────────
          Expanded(
            child: FutureBuilder<String>(
              future: _contentFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Could not load entry file.\n${snapshot.error}',
                      style: TextStyle(color: errorRed),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return Markdown(
                  data: snapshot.data ?? '',
                  padding: const EdgeInsets.all(spaceLg),
                  styleSheet:
                      MarkdownStyleSheet.fromTheme(theme).copyWith(
                    h1: theme.textTheme.headlineMedium,
                    h2: theme.textTheme.headlineSmall,
                    h3: theme.textTheme.titleLarge,
                    p: theme.textTheme.bodyMedium,
                    code: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 13,
                      color: primaryTeal,
                      backgroundColor: surfaceVariantDark,
                    ),
                    codeblockDecoration: BoxDecoration(
                      color: surfaceVariantDark,
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

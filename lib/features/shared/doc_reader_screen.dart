import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../core/theme/tokens.dart';

/// Renders a bundled framework markdown document from assets/docs/.
class DocReaderScreen extends StatefulWidget {
  const DocReaderScreen({super.key, required this.filename});

  /// The asset filename without extension, e.g. 'quick-reference'.
  final String filename;

  @override
  State<DocReaderScreen> createState() => _DocReaderScreenState();
}

class _DocReaderScreenState extends State<DocReaderScreen> {
  late final Future<String> _contentFuture;

  @override
  void initState() {
    super.initState();
    _contentFuture = rootBundle.loadString(
      'assets/docs/${widget.filename}.md',
    );
  }

  String _titleFromFilename(String filename) {
    return filename
        .replaceAll('-', ' ')
        .split(' ')
        .map((w) => w.isEmpty ? w : w[0].toUpperCase() + w.substring(1))
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleFromFilename(widget.filename)),
        actions: [
          IconButton(
            icon: const Icon(Icons.vertical_align_top),
            tooltip: 'Back to top',
            onPressed: () {
              // Scroll controller would be needed for this — omitted for now.
            },
          ),
        ],
      ),
      body: FutureBuilder<String>(
        future: _contentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(spaceLg),
                child: Text(
                  'Could not load document: ${widget.filename}',
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: onSurfaceMuted),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return Markdown(
            data: snapshot.data ?? '',
            selectable: true,
            styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
              code: theme.textTheme.bodySmall?.copyWith(
                fontFamily: 'RobotoMono',
                backgroundColor: surfaceVariantDark,
              ),
              codeblockDecoration: BoxDecoration(
                color: surfaceVariantDark,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              blockquoteDecoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: primaryTeal.withValues(alpha: 0.5),
                    width: 3,
                  ),
                ),
              ),
              h1: theme.textTheme.headlineSmall,
              h2: theme.textTheme.titleLarge,
              h3: theme.textTheme.titleMedium,
            ),
          );
        },
      ),
    );
  }
}

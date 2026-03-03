import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../theme/tokens.dart';

/// Loads a markdown document from the Flutter asset bundle and renders it.
///
/// [assetPath] — e.g. 'assets/docs/onboarding-guide.md'
/// [padding] — optional content padding (default: spaceMd on all sides)
class MarkdownViewer extends StatefulWidget {
  const MarkdownViewer({
    super.key,
    required this.assetPath,
    this.padding,
    this.scrollController,
    this.onLoaded,
  });

  final String assetPath;
  final EdgeInsets? padding;
  final ScrollController? scrollController;

  /// Called once the markdown string has been loaded from assets.
  final void Function(String content)? onLoaded;

  @override
  State<MarkdownViewer> createState() => _MarkdownViewerState();
}

class _MarkdownViewerState extends State<MarkdownViewer> {
  late Future<String> _contentFuture;

  @override
  void initState() {
    super.initState();
    _contentFuture = _load();
  }

  Future<String> _load() async {
    final content = await rootBundle.loadString(widget.assetPath);
    widget.onLoaded?.call(content);
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _contentFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(spaceMd),
              child: Text(
                'Could not load document.\n${snapshot.error}',
                style: TextStyle(color: errorRed),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        return Markdown(
          controller: widget.scrollController,
          data: snapshot.data ?? '',
          padding: widget.padding ??
              const EdgeInsets.all(spaceMd),
          styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
            h1: Theme.of(context).textTheme.headlineMedium,
            h2: Theme.of(context).textTheme.headlineSmall,
            h3: Theme.of(context).textTheme.titleLarge,
            p: Theme.of(context).textTheme.bodyMedium,
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
            blockquoteDecoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: primaryTeal, width: 3),
              ),
            ),
            horizontalRuleDecoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: surfaceVariantDark, width: 1),
              ),
            ),
          ),
        );
      },
    );
  }
}

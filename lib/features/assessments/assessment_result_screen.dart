import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../content/assessments/all_assessments.dart';
import '../../content/assessments/assessment_model.dart';
import '../../core/database/app_database.dart';
import '../../core/theme/tokens.dart';
import 'assessment_provider.dart';

class AssessmentResultScreen extends ConsumerWidget {
  const AssessmentResultScreen({super.key, required this.resultId});
  final int resultId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch all results and find the one matching resultId.
    // (We don't have a watchById helper — use the notifier's cached state first.)
    final sessionState = ref.watch(assessmentNotifierProvider);
    final assessment = sessionState.assessmentId != null
        ? assessmentById(sessionState.assessmentId!)
        : null;

    if (assessment == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Result')),
        body: const Center(child: Text('Assessment data unavailable.')),
      );
    }

    return _ResultView(
      assessment: assessment,
      totalScore: sessionState.totalScore,
      subscaleScores: sessionState.subscaleScores,
      rawScores: sessionState.rawScores,
    );
  }
}

class _ResultView extends StatelessWidget {
  const _ResultView({
    required this.assessment,
    required this.rawScores,
    this.totalScore,
    this.subscaleScores,
  });

  final AssessmentContent assessment;
  final double? totalScore;
  final Map<String, double>? subscaleScores;
  final Map<String, dynamic> rawScores;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go('/assessments'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(spaceLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header card ───────────────────────────────────────────────
            Card(
              child: Padding(
                padding: const EdgeInsets.all(spaceLg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      assessment.name,
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: spaceSm),
                    Row(
                      children: [
                        Icon(Icons.check_circle_outline,
                            color: primaryTeal, size: 18),
                        const SizedBox(width: spaceSm),
                        Text(
                          'Completed ${_todayStr()}',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                    if (totalScore != null) ...[
                      const SizedBox(height: spaceLg),
                      Text(
                        'TOTAL SCORE',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: onSurfaceMuted,
                          letterSpacing: 1.1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        totalScore!.toStringAsFixed(
                            totalScore! == totalScore!.truncateToDouble() ? 0 : 1),
                        style: theme.textTheme.displaySmall?.copyWith(
                          color: primaryTeal,
                          fontFamily: 'RobotoMono',
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: spaceMd),

            // ── Subscale scores ───────────────────────────────────────────
            if (subscaleScores != null && subscaleScores!.isNotEmpty) ...[
              Text(
                'SUBSCALE SCORES',
                style: theme.textTheme.labelSmall?.copyWith(
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: spaceSm),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(spaceMd),
                  child: Column(
                    children: subscaleScores!.entries.map((e) {
                      return Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(e.key,
                                  style: theme.textTheme.bodyMedium),
                            ),
                            Text(
                              e.value.toStringAsFixed(
                                  e.value == e.value.truncateToDouble()
                                      ? 0
                                      : 1),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontFamily: 'RobotoMono',
                                color: primaryTeal,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: spaceMd),
            ],

            // ── Threshold comparison ──────────────────────────────────────
            if (assessment.thresholds != null &&
                assessment.thresholds!.isNotEmpty &&
                totalScore != null) ...[
              Text(
                'THRESHOLDS',
                style: theme.textTheme.labelSmall?.copyWith(
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: spaceSm),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(spaceMd),
                  child: Column(
                    children: assessment.thresholds!.entries.map((e) {
                      final met = totalScore! >= e.value;
                      return Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Icon(
                              met
                                  ? Icons.check_circle_outline
                                  : Icons.radio_button_unchecked,
                              size: 16,
                              color: met ? primaryTeal : onSurfaceMuted,
                            ),
                            const SizedBox(width: spaceSm),
                            Expanded(
                              child: Text(e.key,
                                  style: theme.textTheme.bodySmall),
                            ),
                            Text(
                              '≥ ${e.value.toStringAsFixed(e.value == e.value.truncateToDouble() ? 0 : 1)}',
                              style: theme.textTheme.bodySmall
                                  ?.copyWith(color: onSurfaceMuted),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: spaceMd),
            ],

            // ── Scoring notes / interpretation ────────────────────────────
            if (assessment.scoringNotes != null) ...[
              Text(
                'INTERPRETATION',
                style: theme.textTheme.labelSmall?.copyWith(
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: spaceSm),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(spaceMd),
                  child: Text(
                    assessment.scoringNotes!,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ),
              const SizedBox(height: spaceMd),
            ],

            // ── Raw data (collapsed) ──────────────────────────────────────
            _RawDataTile(rawScores: rawScores),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  String _todayStr() {
    final now = DateTime.now();
    return '${now.year}-'
        '${now.month.toString().padLeft(2, '0')}-'
        '${now.day.toString().padLeft(2, '0')}';
  }
}

class _RawDataTile extends StatefulWidget {
  const _RawDataTile({required this.rawScores});
  final Map<String, dynamic> rawScores;

  @override
  State<_RawDataTile> createState() => _RawDataTileState();
}

class _RawDataTileState extends State<_RawDataTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(radiusLg),
        onTap: () => setState(() => _expanded = !_expanded),
        child: Padding(
          padding: const EdgeInsets.all(spaceMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Raw data', style: theme.textTheme.labelMedium),
                  const Spacer(),
                  Icon(
                    _expanded
                        ? Icons.expand_less
                        : Icons.expand_more,
                    size: 18,
                    color: onSurfaceMuted,
                  ),
                ],
              ),
              if (_expanded) ...[
                const SizedBox(height: spaceSm),
                Text(
                  const JsonEncoder.withIndent('  ')
                      .convert(widget.rawScores),
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontFamily: 'RobotoMono',
                    color: onSurfaceMuted,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

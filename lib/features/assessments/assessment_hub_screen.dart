import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../content/assessments/assessment_model.dart';
import '../../core/providers.dart';
import '../../core/theme/tokens.dart';
import 'assessment_provider.dart';

class AssessmentHubScreen extends ConsumerWidget {
  const AssessmentHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPhase = ref.watch(currentPhaseProvider);
    final assessmentsAsync = ref.watch(phaseAssessmentsProvider(currentPhase));
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('Assessments'),
          floating: true,
          snap: true,
        ),
        assessmentsAsync.when(
          loading: () => const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) => SliverFillRemaining(
            child: Center(child: Text('Error: $e')),
          ),
          data: (items) {
            final sectionA = items
                .where((i) => i.$1.section == AssessmentSection.validatedInstrument)
                .toList();
            final sectionB = items
                .where((i) => i.$1.section == AssessmentSection.customProtocol)
                .toList();

            if (items.isEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(spaceLg),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.assignment_outlined,
                            size: 48, color: onSurfaceMuted),
                        const SizedBox(height: spaceMd),
                        Text(
                          'No assessments scheduled for Phase $currentPhase.',
                          style: theme.textTheme.titleMedium
                              ?.copyWith(color: onSurfaceMuted),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                  spaceMd, spaceSm, spaceMd, 80),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  if (sectionA.isNotEmpty) ...[
                    _SectionHeader(
                      title: 'Section A — Validated Instruments',
                      subtitle: 'Complete externally or in-app, then submit score.',
                    ),
                    const SizedBox(height: spaceSm),
                    ...sectionA.map((i) => _AssessmentCard(
                          assessment: i.$1,
                          lastAdminDate: i.$2,
                          currentPhase: currentPhase,
                        )),
                    const SizedBox(height: spaceLg),
                  ],
                  if (sectionB.isNotEmpty) ...[
                    _SectionHeader(
                      title: 'Section B — Custom Protocols',
                      subtitle: 'Guided in-app runners with step-by-step instructions.',
                    ),
                    const SizedBox(height: spaceSm),
                    ...sectionB.map((i) => _AssessmentCard(
                          assessment: i.$1,
                          lastAdminDate: i.$2,
                          currentPhase: currentPhase,
                        )),
                  ],
                ]),
              ),
            );
          },
        ),
      ],
    );
  }
}

// ─── Section header ────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: theme.textTheme.labelSmall?.copyWith(
            color: primaryTeal,
            letterSpacing: 1.1,
          ),
        ),
        Text(subtitle, style: theme.textTheme.bodySmall),
      ],
    );
  }
}

// ─── Assessment card ──────────────────────────────────────────────────────────

class _AssessmentCard extends StatelessWidget {
  const _AssessmentCard({
    required this.assessment,
    required this.lastAdminDate,
    required this.currentPhase,
  });

  final AssessmentContent assessment;
  final DateTime? lastAdminDate;
  final int currentPhase;

  bool get _isDue {
    if (assessment.phasesAdministered.contains(currentPhase)) return true;
    if (assessment.isWeekly && lastAdminDate != null) {
      return DateTime.now().difference(lastAdminDate!).inDays >= 7;
    }
    if (assessment.isWeekly && lastAdminDate == null) return true;
    return false;
  }

  String get _lastAdminText {
    if (lastAdminDate == null) return 'Not yet administered';
    final days = DateTime.now().difference(lastAdminDate!).inDays;
    if (days == 0) return 'Completed today';
    if (days == 1) return 'Completed yesterday';
    return 'Last: $days days ago';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: spaceSm),
      child: InkWell(
        borderRadius: BorderRadius.circular(radiusLg),
        onTap: () => context.go('/assessment/${assessment.id}'),
        child: Padding(
          padding: const EdgeInsets.all(spaceMd),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            assessment.name,
                            style: theme.textTheme.titleSmall,
                          ),
                        ),
                        if (_isDue)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: spaceSm, vertical: 2),
                            decoration: BoxDecoration(
                              color: primaryTeal.withValues(alpha: 0.15),
                              borderRadius:
                                  BorderRadius.circular(radiusPill),
                              border: Border.all(
                                  color: primaryTeal.withValues(alpha: 0.4)),
                            ),
                            child: Text(
                              'DUE',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: primaryTeal,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      assessment.shortDescription,
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.access_time,
                            size: 11, color: onSurfaceMuted),
                        const SizedBox(width: 3),
                        Text(
                          assessment.estimatedMinutes != null
                              ? '${assessment.estimatedMinutes} min'
                              : '',
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: onSurfaceMuted),
                        ),
                        const SizedBox(width: spaceSm),
                        Text(
                          _lastAdminText,
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: onSurfaceMuted),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: spaceSm),
              Icon(Icons.chevron_right, size: 18, color: onSurfaceMuted),
            ],
          ),
        ),
      ),
    );
  }
}

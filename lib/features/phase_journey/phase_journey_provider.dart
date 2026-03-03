import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../content/phases/all_phases.dart';
import '../../content/phases/phase_model.dart';
import '../../core/database/app_database.dart';
import '../../core/providers.dart';
import '../../core/widgets/phase_badge.dart';

@immutable
class PhaseJourneyItem {
  const PhaseJourneyItem({
    required this.content,
    required this.status,
    this.startedAt,
    this.completedAt,
  });

  final PhaseContent content;
  final PhaseStatus status;
  final DateTime? startedAt;
  final DateTime? completedAt;
}

/// Combines static phase content with live DB progress rows to build
/// the list used by the phase journey screen.
final phaseJourneyProvider = Provider<List<PhaseJourneyItem>>((ref) {
  final progressAsync = ref.watch(allPhasesProgressProvider);

  // Map phaseNumber → DB row for O(1) lookup.
  final Map<int, PhaseProgressTableData> progressMap = {};
  progressAsync.whenData((rows) {
    for (final row in rows) {
      progressMap[row.phaseNumber] = row;
    }
  });

  return kPhases.map((phase) {
    final row = progressMap[phase.phaseNumber];
    final PhaseStatus status;
    if (row == null) {
      status = PhaseStatus.locked;
    } else if (row.status == 'complete') {
      status = PhaseStatus.complete;
    } else {
      status = PhaseStatus.active;
    }

    return PhaseJourneyItem(
      content: phase,
      status: status,
      startedAt: row?.startedAt,
      completedAt: row?.completedAt,
    );
  }).toList();
});

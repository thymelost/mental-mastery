import 'package:flutter/foundation.dart';

@immutable
class PhaseContent {
  const PhaseContent({
    required this.phaseNumber,
    required this.name,
    required this.description,
    required this.layer,
    required this.durationNote,
    this.exitGateNumber,
    this.skillIds = const [],
    this.practiceIds = const [],
  });

  /// 0–8
  final int phaseNumber;

  /// Display name, e.g. "Entry Assessment"
  final String name;

  /// Short paragraph shown in the phase detail sheet.
  final String description;

  /// Layer label: 'Pre-training' | 'L1' | 'L1 → L2' | 'L2' |
  ///              'L2 Verification' | 'L3'
  final String layer;

  /// Human-readable time estimate, e.g. "4–8 weeks" or "Ongoing"
  final String durationNote;

  /// Gate number that closes this phase. null = Phase 8 (no exit).
  final int? exitGateNumber;

  /// Skill IDs trained in this phase (e.g. ['S1.1', 'A1.1']).
  final List<String> skillIds;

  /// Practice IDs scheduled in this phase (e.g. ['P1A', 'P1B']).
  final List<String> practiceIds;
}

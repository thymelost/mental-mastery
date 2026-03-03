/// Static data model for a single practice.
/// All instances are compile-time const objects in all_practices.dart.
class PracticeContent {
  const PracticeContent({
    required this.id,
    required this.name,
    required this.phaseNumber,
    required this.scheduleSlot,
    required this.durationMinutes,
    required this.skillIds,
    required this.purpose,
    required this.steps,
    required this.safetySignals,
    this.researchNote,
    this.requiresHrMonitor = false,
    this.qualityRatedPhase7Plus = false,
  });

  final String id;              // e.g. 'P1A'
  final String name;
  final int phaseNumber;        // 0–8
  // 'morning' | 'midday' | 'evening' | 'triggered'
  final String scheduleSlot;
  final int durationMinutes;
  final List<String> skillIds;  // e.g. ['S1.1', 'S1.2']
  final String purpose;
  final List<String> steps;     // Numbered step text (without numbers — list index = step number)
  final List<String> safetySignals;  // Stop/pause criteria for this practice
  final String? researchNote;
  final bool requiresHrMonitor;
  final bool qualityRatedPhase7Plus; // true for Phase 7+ I1.4 practices
}

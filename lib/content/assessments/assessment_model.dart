/// Static content models for assessments.
/// No business logic — only type-safe data structures for framework content.

// ─── Enums ────────────────────────────────────────────────────────────────────

enum AssessmentSection { validatedInstrument, customProtocol }

/// Maps each AssessmentContent to its runner widget.
enum AssessmentRunner {
  questionnaire,    // Paged Likert questionnaire (TAS-20, FFMQ, PHQ-9, DASS-21)
  scoreEntry,       // External completion; user enters total score (SMS-Mind, RRS)
  b1BodyMap,
  b2Hbd,
  b3Arousal,
  b4Vocab,
  b5Attention,
  b5aDirection,
  b5bDistraction,
  b6Probe,
  b7DualPresence,
  b8LoadMatrix,
  b9Boundary,
  b10StateShifting,
  b11Calibration,
}

// ─── Assessment content ────────────────────────────────────────────────────────

class AssessmentContent {
  const AssessmentContent({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.runner,
    required this.section,
    required this.phasesAdministered,
    this.isWeekly = false,
    this.estimatedMinutes,
    this.scoringNotes,
    this.thresholds,
  });

  /// Matches assessment_results.assessment_id (e.g. 'TAS20', 'B5a').
  final String id;
  final String name;
  final String shortDescription;
  final AssessmentRunner runner;
  final AssessmentSection section;

  /// Phase numbers at whose exit/gate boundary this assessment is due.
  /// Phase 0 = administered during onboarding/Phase 0.
  final List<int> phasesAdministered;

  /// True for B2 and B3 which are administered weekly within phases 1–2.
  final bool isWeekly;
  final int? estimatedMinutes;

  /// Framework interpretation notes shown on the result screen.
  final String? scoringNotes;

  /// Named thresholds for threshold comparison display (name → value).
  final Map<String, double>? thresholds;
}

// ─── Questionnaire types ───────────────────────────────────────────────────────

/// A single item in a validated questionnaire instrument.
class QuestionnaireItem {
  const QuestionnaireItem({required this.text, this.reversed = false});
  final String text;
  /// If true, scored as reverseMax - rawResponse (for TAS-20 items 4,5,10,18,19).
  final bool reversed;
}

/// Full definition of a validated questionnaire instrument.
class QuestionnaireDefinition {
  const QuestionnaireDefinition({
    required this.instruction,
    required this.scaleLabels,
    required this.items,
    this.subscales = const {},
    this.reverseMax,
    this.subscaleMultiplier = 1.0,
    this.scoringNotes,
  });

  /// Instructional text shown before items begin.
  final String instruction;

  /// Response option labels from lowest to highest value.
  /// Length determines the number of response options (e.g. 5 for Likert-5).
  final List<String> scaleLabels;

  final List<QuestionnaireItem> items;

  /// Map of subscale name → list of 1-indexed item numbers in that subscale.
  final Map<String, List<int>> subscales;

  /// For reverse-scored items: reversed value = reverseMax - rawValue.
  /// TAS-20 uses reverseMax = 6 (5-point scale, 6 - raw = reversed).
  final int? reverseMax;

  /// Multiplier applied to each subscale sum for the standard score.
  /// DASS-21 uses 2.0 to convert from 21-item to DASS-42 equivalent.
  final double subscaleMultiplier;

  /// Notes shown alongside score interpretation on result screen.
  final String? scoringNotes;
}

// ─── Callback typedef ─────────────────────────────────────────────────────────

typedef AssessmentCompleteCallback = void Function(
  Map<String, dynamic> rawScores,
  double? totalScore,
  Map<String, double>? subscaleScores,
);

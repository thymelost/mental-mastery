// Static data models for phase gate criteria and gate definitions.
// All instances are compile-time const objects in all_gates.dart.
//
// DESIGN SPLIT:
//   - Criterion DEFINITIONS (what is required) → static content here.
//   - Criterion EVALUATION STATE (pass/fail/pending per attempt) → gate_criteria_states DB table.
//   - Gate-level STATE (overall status, attempt count) → gate_states DB table.

// ─── Enums ────────────────────────────────────────────────────────────────────

enum GateCriterionType {
  /// Evaluated automatically from assessment_results or other DB data.
  /// The app computes pass/fail; no user interaction required.
  auto,

  /// Computed from available data but requires explicit user acknowledgment.
  /// Used for binary user confirmations (e.g. "all crisis indicators absent").
  semiAuto,

  /// User manually ticks a checkbox. Cannot be auto-evaluated from DB.
  /// Used for journal-based, longitudinal, and behavioural criteria.
  manual,
}

// ─── Criterion ────────────────────────────────────────────────────────────────

class GateCriterion {
  const GateCriterion({
    required this.id,
    required this.description,
    required this.track,
    required this.domain,
    required this.criterionType,
    this.blockingIfFailed = false,
    this.assessmentId,
    this.threshold,
    this.notes,
  });

  /// Unique ID within the gate. Stored in gate_criteria_states.criterion_id.
  /// Convention: 'g{gateNum}_{short_label}' e.g. 'g7_phq9'.
  final String id;

  /// Human-readable criterion description shown in the gate checklist UI.
  final String description;

  /// 'A' = subjective/behavioral track; 'B' = physiological/performance track.
  final String track;

  /// Framework domain for this criterion.
  /// Values: 'emotional_literacy' | 'somatic' | 'vocabulary' | 'attention' | 'integration'
  final String domain;

  final GateCriterionType criterionType;

  /// If true, the gate CANNOT pass if this criterion fails — even if all others pass.
  /// Used for PHQ-9 ≥ 10 and active crisis indicators at the L2→L3 gate.
  final bool blockingIfFailed;

  /// For [GateCriterionType.auto] and [GateCriterionType.semiAuto]:
  /// the assessment ID whose most recent result drives evaluation.
  /// Matches assessment_results.assessment_id (e.g. 'PHQ9', 'B8', 'B11', 'FFMQ').
  final String? assessmentId;

  /// For auto criteria: the threshold value for pass/fail determination.
  /// Interpretation is criterion-specific (≤ threshold for PHQ-9; ≥ threshold for B8/B11).
  final double? threshold;

  /// Optional explanatory notes shown alongside the criterion in the gate UI.
  final String? notes;
}

// ─── Gate definition ──────────────────────────────────────────────────────────

class GateDefinition {
  const GateDefinition({
    required this.gateNumber,
    required this.fromPhase,
    required this.toPhase,
    required this.name,
    required this.description,
    required this.criteria,
    this.isCritical = false,
  });

  /// 1–9. Matches gate_states.gate_number in the database.
  final int gateNumber;

  /// Phase the user is exiting (0–7).
  final int fromPhase;

  /// Phase the user is entering (1–8). Gate 9 uses toPhase 8 (ongoing checkpoint).
  final int toPhase;

  final String name;
  final String description;
  final List<GateCriterion> criteria;

  /// True only for Gate 7 (L2→L3). Activates extended pre-gate warning,
  /// mandatory PHQ-9 hard-block display, and the crisis indicators screen.
  final bool isCritical;
}

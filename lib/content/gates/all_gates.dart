import 'gate_model.dart';

/// All 9 phase gate definitions.
///
/// Gate numbering (matches gate_states.gate_number in DB):
///   Gate 1 = Phase 0 → 1   (Entry Assessment complete)
///   Gate 2 = Phase 1 → 2   (Somatic & Attentional Foundation exit)
///   Gate 3 = Phase 2 → 3   (Emotional Literacy & Attentional Depth exit)
///   Gate 4 = Phase 3 → 4   (Layer 1→2 Bridge exit)
///   Gate 5 = Phase 4 → 5   (Metacognitive Core exit)
///   Gate 6 = Phase 5 → 6   (Self-Boundary & Dual Presence exit)
///   Gate 7 = Phase 6 → 7   (L2→L3 CRITICAL gate — Layer 2 Verification)
///   Gate 8 = Phase 7 → 8   (State Modulation exit)
///   Gate 9 = Phase 8 12-wk  (Pattern Work 12-week checkpoint)
const List<GateDefinition> allGates = [
  _gate1,
  _gate2,
  _gate3,
  _gate4,
  _gate5,
  _gate6,
  _gate7,
  _gate8,
  _gate9,
];

GateDefinition gateForNumber(int n) =>
    allGates.firstWhere((g) => g.gateNumber == n);

// ─── Gate 1: Phase 0 → 1 ─────────────────────────────────────────────────────

const _gate1 = GateDefinition(
  gateNumber: 1,
  fromPhase: 0,
  toPhase: 1,
  name: 'Entry Assessment Complete',
  description:
      'All Phase 0 baseline assessments have been administered and recorded. '
      'Entry track has been assigned based on results.',
  criteria: [
    GateCriterion(
      id: 'g1_tas20',
      description: 'TAS-20 administered, scored, and recorded in journal.',
      track: 'A',
      domain: 'emotional_literacy',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g1_somatic',
      description:
          'Somatic baseline (guided body scan) completed. Sensation count and '
          'blank regions recorded.',
      track: 'B',
      domain: 'somatic',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g1_vocab',
      description:
          'Emotional vocabulary audit completed. Total count and list recorded.',
      track: 'A',
      domain: 'emotional_literacy',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g1_attention',
      description:
          'Attention sustaining baseline completed. Drift count and longest '
          'continuous stretch recorded.',
      track: 'B',
      domain: 'attention',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g1_hbd',
      description:
          'Heartbeat detection baseline (4 intervals) completed and scored. '
          'Accuracy % recorded.',
      track: 'B',
      domain: 'somatic',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g1_track',
      description:
          'Entry track assigned (standard / extended / somatic-priority) based '
          'on TAS-20 score, somatic baseline count, and vocabulary count.',
      track: 'A',
      domain: 'integration',
      criterionType: GateCriterionType.manual,
    ),
  ],
);

// ─── Gate 2: Phase 1 → 2 ─────────────────────────────────────────────────────

const _gate2 = GateDefinition(
  gateNumber: 2,
  fromPhase: 1,
  toPhase: 2,
  name: 'Somatic & Attentional Foundation Exit',
  description:
      'Layer 1 somatic and attentional foundation skills have reached '
      'provisional thresholds. Emotional literacy has begun.',
  criteria: [
    GateCriterion(
      id: 'g2_s11',
      description:
          'S1.1: Identifies and locates 5+ distinct physical sensations in a '
          '10-minute body scan using physical terms only (not emotional/interpretive). '
          'Consistent across 3 sessions in the same week.',
      track: 'B',
      domain: 'somatic',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g2_s12',
      description:
          'S1.2 (Track B): Heartbeat detection accuracy ≥ 70%, averaged across '
          '3 consecutive weekly checks.',
      track: 'B',
      domain: 'somatic',
      criterionType: GateCriterionType.auto,
      assessmentId: 'B2',
      threshold: 70.0,
    ),
    GateCriterion(
      id: 'g2_a11',
      description:
          'A1.1: Can maintain voluntary focus for 10+ continuous minutes with '
          '< 3 self-reported unrecovered drifts. Consistent across 5 consecutive '
          'sessions within the same week.',
      track: 'B',
      domain: 'attention',
      criterionType: GateCriterionType.manual,
      notes: 'B5a protocol: attention direction + discrimination probe also completed.',
    ),
    GateCriterion(
      id: 'g2_a12',
      description:
          'A1.2: Can correctly identify > 75% of chosen vs. pulled attention '
          'instances in a 20-minute session with post-session reflection.',
      track: 'A',
      domain: 'attention',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g2_a13',
      description:
          'A1.3: Drift-to-return latency shows a decreasing trend across the '
          'Phase 1 session log (not a fixed number — a trend).',
      track: 'A',
      domain: 'attention',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g2_e11',
      description:
          'E1.1: Correctly identifies current primary emotional state in > 80% '
          'of structured prompts across a 1-week EMA review.',
      track: 'A',
      domain: 'emotional_literacy',
      criterionType: GateCriterionType.manual,
    ),
  ],
);

// ─── Gate 3: Phase 2 → 3 ─────────────────────────────────────────────────────

const _gate3 = GateDefinition(
  gateNumber: 3,
  fromPhase: 2,
  toPhase: 3,
  name: 'Emotional Literacy & Attentional Depth Exit',
  description:
      'Somatic baseline mapping, emotional vocabulary, gradient detection, '
      'and attentional aperture control have reached threshold.',
  criteria: [
    GateCriterion(
      id: 'g3_s13',
      description:
          'S1.3: Has a documented personal neutral reference across ≥ 4 body '
          'systems. Can identify deviation from personal neutral reliably across '
          'different times of day. Documented over ≥ 2 consecutive weeks.',
      track: 'A',
      domain: 'somatic',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g3_s14',
      description:
          'S1.4 (Track B): Arousal rating within ≤ 2 points of HR-based '
          'estimate in ≥ 70% of weekly arousal crosschecks across 7+ days.',
      track: 'B',
      domain: 'somatic',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g3_e12',
      description:
          'E1.2: Personal emotion-body map covers ≥ 5 emotions with specific '
          'body locations and sensation types. Can identify emotional state from '
          'somatic cues alone in > 70% of trials.',
      track: 'A',
      domain: 'emotional_literacy',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g3_e13',
      description:
          'E1.3: Can name and distinguish ≥ 20 distinct emotional states. '
          'Can explain functional difference between similar states '
          '(e.g. dread vs. apprehension vs. anxiety).',
      track: 'A',
      domain: 'emotional_literacy',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g3_e14',
      description:
          'E1.4: ≥ 60% of EMA gradient log entries are at intensity ≤ 4/10. '
          'Real-time vs. retrospective reporting gap < 2 intensity points.',
      track: 'A',
      domain: 'emotional_literacy',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g3_a14',
      description:
          'A1.4: Can maintain attentional focus for 5 minutes with < 2 '
          'unrecovered drifts in the presence of ambient distraction. '
          'Tested in ≥ 3 distinct distraction environments.',
      track: 'B',
      domain: 'attention',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g3_a15',
      description:
          'A1.5: Can deliberately shift between point-focus and full field '
          'awareness. Transition time < 30 seconds. Can sustain each state '
          'for 60 seconds.',
      track: 'A',
      domain: 'attention',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g3_safety',
      description:
          'Safety instruments administered: PHQ-9 and DASS-21 completed and '
          'recorded as Phase 2 exit baselines. PHQ-9 < 15 to proceed '
          '(≥ 15: consult a clinician before continuing).',
      track: 'A',
      domain: 'integration',
      criterionType: GateCriterionType.manual,
      notes:
          'These are baseline measurements, not gate criteria per se. '
          'PHQ-9 ≥ 15 warrants clinical consultation but does not hard-block '
          'Phase 3 entry. The hard block is at the L2→L3 gate (PHQ-9 ≥ 10).',
    ),
  ],
);

// ─── Gate 4: Phase 3 → 4 ─────────────────────────────────────────────────────

const _gate4 = GateDefinition(
  gateNumber: 4,
  fromPhase: 3,
  toPhase: 4,
  name: 'Layer 1→2 Bridge Exit',
  description:
      'Meta-attention and initial thought observation have reached provisional '
      'thresholds. First calibration honesty check complete.',
  criteria: [
    GateCriterion(
      id: 'g4_a21',
      description:
          'A2.1: ≥ 80% accuracy on random meta-attention probes. Latency to '
          'meta-awareness < 10 seconds. Assessed over 5-day B6 formal probe.',
      track: 'B',
      domain: 'attention',
      criterionType: GateCriterionType.auto,
      assessmentId: 'B6',
      threshold: 80.0,
    ),
    GateCriterion(
      id: 'g4_c21',
      description:
          'C2.1: Can complete a 20-minute session reporting thoughts as events '
          '("I had the thought…") > 80% of the time. Catches identification '
          'in the moment (not only retrospectively) in > 5 instances per week.',
      track: 'A',
      domain: 'attention',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g4_c22',
      description:
          'C2.2: Can correctly label current cognitive mode in ≥ 70% of '
          'structured prompts. Can distinguish ≥ 5 distinct modes. Mode '
          'journal shows entries across > 10 days.',
      track: 'A',
      domain: 'attention',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g4_i13',
      description:
          'I1.3 provisional: Self-assessed skill levels are within ± 1 point '
          'of criterion assessment for ≥ 70% of Phase 1–2 skills reviewed. '
          'No systematic direction bias (not consistently over or under).',
      track: 'A',
      domain: 'integration',
      criterionType: GateCriterionType.auto,
      assessmentId: 'B11',
      threshold: 70.0,
      notes:
          'B11 calibration check administered at Phase 3 end. Mean gap and '
          'direction bias are computed from the assessment result.',
    ),
  ],
);

// ─── Gate 5: Phase 4 → 5 ─────────────────────────────────────────────────────

const _gate5 = GateDefinition(
  gateNumber: 5,
  fromPhase: 4,
  toPhase: 5,
  name: 'Metacognitive Core Exit',
  description:
      'Core Layer 2 cognitive and emotional monitoring skills have reached '
      'provisional thresholds.',
  criteria: [
    GateCriterion(
      id: 'g5_c23',
      description:
          'C2.3: Can identify 3+ reasoning shortcuts or collapsed inferences '
          'per week in own thinking, documented in journal for ≥ 4 consecutive '
          'weeks. Can name the type of shortcut.',
      track: 'A',
      domain: 'attention',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g5_c24',
      description:
          'C2.4: Can accurately rate current cognitive capacity (1–5) with '
          '≤ 1 point error against a task-based performance proxy, across '
          '≥ 10 paired assessments.',
      track: 'B',
      domain: 'attention',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g5_c25',
      description:
          'C2.5: Can tag ≥ 3 assumptions per week where inference was treated '
          'as direct observation. Can explain the distinction in real time, '
          'not only in retrospect.',
      track: 'A',
      domain: 'attention',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g5_c26',
      description:
          'C2.6: Catches a running narrative in real time in > 5 instances per '
          'week (documented). Can label the narrative theme. Rumination '
          'Response Scale shows measurable decrease from Phase 0 baseline.',
      track: 'A',
      domain: 'attention',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g5_e21',
      description:
          'E2.1: For ≥ 70% of logged emotional states, provides a reasoned '
          'source attribution within 60 seconds of noticing.',
      track: 'A',
      domain: 'emotional_literacy',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g5_e22',
      description:
          'E2.2: Documents ≥ 2 contagion instances per week. Can correctly '
          'anticipate high-contagion contexts (predictive accuracy > 50%).',
      track: 'A',
      domain: 'emotional_literacy',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g5_e23',
      description:
          'E2.3: Can identify affect-cognition coupling in real time (before '
          'the biased conclusion is finalised) in ≥ 3 instances per week. '
          'Can name the coupling pattern.',
      track: 'A',
      domain: 'emotional_literacy',
      criterionType: GateCriterionType.manual,
    ),
  ],
);

// ─── Gate 6: Phase 5 → 6 ─────────────────────────────────────────────────────

const _gate6 = GateDefinition(
  gateNumber: 6,
  fromPhase: 5,
  toPhase: 6,
  name: 'Self-Boundary & Dual Presence Exit',
  description:
      'Self-boundary integrity skills and dual presence have reached '
      'provisional thresholds. Skill-under-load begins here.',
  criteria: [
    GateCriterion(
      id: 'g6_b21',
      description:
          'B2.1: > 70% accuracy on self-other signal attribution in structured '
          'boundary challenge scenarios (B9). Can describe distinguishing '
          'features used.',
      track: 'A',
      domain: 'integration',
      criterionType: GateCriterionType.auto,
      assessmentId: 'B9',
      threshold: 70.0,
    ),
    GateCriterion(
      id: 'g6_b22',
      description:
          'B2.2: ≥ 80% detection rate in Incongruence Detection Drill across '
          '2 consecutive weeks. Values document is in place and current.',
      track: 'A',
      domain: 'integration',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g6_b23',
      description:
          'B2.3: Can return to values-alignment within 2 minutes of a load or '
          'social pressure challenge in ≥ 5 documented pressure scenarios. '
          'Does not require external prompt.',
      track: 'A',
      domain: 'integration',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g6_b24',
      description:
          'B2.4: Self-attribution consistency log — baseline self-description '
          'document complete, dated, and signed. Weekly review entries logged '
          'for ≥ 8 consecutive weeks. Unendorsed drift detection latency '
          'showing decreasing trend.',
      track: 'A',
      domain: 'integration',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g6_a22',
      description:
          'A2.2 (Track B): Dual presence test (B7) — reading comprehension '
          '≥ 85% of rested baseline; internal state probe accuracy ≥ 80%.',
      track: 'B',
      domain: 'attention',
      criterionType: GateCriterionType.auto,
      assessmentId: 'B7',
      threshold: 85.0,
    ),
    GateCriterion(
      id: 'g6_i11',
      description:
          'I1.1 provisional (Track B): B8 load-condition assessment — all 6 '
          'monitoring skills at ≥ 80% of rested baseline in ≥ 2 load condition '
          'types. Condition D (physiological arousal) attempted at least once.',
      track: 'B',
      domain: 'integration',
      criterionType: GateCriterionType.auto,
      assessmentId: 'B8',
      threshold: 80.0,
    ),
    GateCriterion(
      id: 'g6_i12',
      description:
          'I1.2 provisional (Track B): Recovery Time Log shows return to '
          'monitoring baseline within 15 minutes of disruption at ≥ 85% '
          'baseline quality. Tracking trend established across ≥ 6 entries.',
      track: 'B',
      domain: 'integration',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g6_ffmq',
      description:
          'FFMQ Observing subscale administered and recorded. Score shows '
          'increase from Phase 3 baseline.',
      track: 'A',
      domain: 'attention',
      criterionType: GateCriterionType.auto,
      assessmentId: 'FFMQ',
      notes:
          'Pass = current score > Phase 3 baseline score. Auto-evaluated if '
          'both assessments are recorded in assessment_results.',
    ),
  ],
);

// ─── Gate 7: Phase 6 → 7 — L2→L3 CRITICAL GATE ───────────────────────────────

const _gate7 = GateDefinition(
  gateNumber: 7,
  fromPhase: 6,
  toPhase: 7,
  name: 'L2→L3 Gate — Layer 2 Verification',
  description:
      'The highest-stakes boundary in the framework. Layer 3 involves '
      'deliberate self-modification. Entry is only safe when Layer 2 '
      'monitoring is fully functional — including under physiological stress. '
      'All 10 criteria must be met. Two criteria are hard blocks.',
  isCritical: true,
  criteria: [
    // Criterion 1
    GateCriterion(
      id: 'g7_l2_all',
      description:
          'All L2 skills (Phase 4 and Phase 5 exit criteria) confirmed met. '
          'No skill below threshold from either phase.',
      track: 'A',
      domain: 'integration',
      criterionType: GateCriterionType.manual,
    ),
    // Criterion 2
    GateCriterion(
      id: 'g7_i11_full',
      description:
          'I1.1 full (Track B): B8 load-condition assessment — all 6 monitoring '
          'skills at ≥ 80% of rested baseline in ALL 4 conditions (cognitive, '
          'emotional, social, and physiological arousal).',
      track: 'B',
      domain: 'integration',
      criterionType: GateCriterionType.auto,
      assessmentId: 'B8',
      threshold: 80.0,
      notes:
          'Condition D (physiological arousal) is a mandatory part of this '
          'criterion. Skills trained only under cognitive/emotional load may '
          'fail under noradrenergic stress (Raio et al., 2013).',
    ),
    // Criterion 3
    GateCriterion(
      id: 'g7_i13',
      description:
          'I1.3: B11 calibration honesty check — self-assessments within '
          '± 1 point for ≥ 80% of all L1 and L2 skills reviewed. No '
          'systematic direction bias.',
      track: 'A',
      domain: 'integration',
      criterionType: GateCriterionType.auto,
      assessmentId: 'B11',
      threshold: 80.0,
    ),
    // Criterion 4
    GateCriterion(
      id: 'g7_b24',
      description:
          'B2.4: Weekly self-attribution consistency reviews logged for '
          '≥ 8 consecutive weeks. No unendorsed self-description drift '
          'in the preceding 12 weeks.',
      track: 'A',
      domain: 'integration',
      criterionType: GateCriterionType.manual,
    ),
    // Criterion 5
    GateCriterion(
      id: 'g7_a22',
      description:
          'A2.2: Dual presence stable in ecologically valid conditions (not '
          'only controlled sessions) for ≥ 6 consecutive weeks. Session log '
          'evidence required.',
      track: 'B',
      domain: 'attention',
      criterionType: GateCriterionType.manual,
    ),
    // Criterion 6
    GateCriterion(
      id: 'g7_trackb',
      description:
          'Track B: At least 2 independent physiological/performance measures '
          'show threshold-level performance (e.g. B7 dual presence, B8 load '
          'retention, B9 attribution accuracy, HBD accuracy).',
      track: 'B',
      domain: 'integration',
      criterionType: GateCriterionType.manual,
    ),
    // Criterion 7
    GateCriterion(
      id: 'g7_self',
      description:
          'Written self-assessment (1–2 pages) completed. Covers strongest '
          'and weakest L2 skills, current failure modes, and honest evaluation '
          'of whether monitoring is reliable enough to function as a firewall.',
      track: 'A',
      domain: 'integration',
      criterionType: GateCriterionType.manual,
      notes: 'Failure modes must appear in the document — all-positive '
          'self-assessments signal I1.3 overestimation.',
    ),
    // Criterion 8 — HARD BLOCK
    GateCriterion(
      id: 'g7_phq9',
      description:
          'PHQ-9 score ≤ 9 (mild or below). Elevated depressive symptoms '
          'impair the perceptual accuracy Layer 3 requires.',
      track: 'A',
      domain: 'integration',
      criterionType: GateCriterionType.auto,
      blockingIfFailed: true,
      assessmentId: 'PHQ9',
      threshold: 9.0,
      notes: 'HARD BLOCK: gate cannot pass if PHQ-9 ≥ 10. '
          'Resolve before re-attempting. This is not a defeatable hint.',
    ),
    // Criterion 9 — HARD BLOCK
    GateCriterion(
      id: 'g7_crisis',
      description:
          'No active crisis indicators. All of the following must be absent '
          'or resolved: persistent sleep disruption, flashback-like experiences, '
          'dissociative episodes, significant worsening of distress across '
          'multiple weeks.',
      track: 'A',
      domain: 'integration',
      criterionType: GateCriterionType.semiAuto,
      blockingIfFailed: true,
      notes: 'HARD BLOCK: user must explicitly confirm all indicators are '
          'absent. Any unresolved indicator blocks Layer 3 entry. '
          'Layer 3 self-modification requires stable baseline function.',
    ),
    // Criterion 10 — NEW (physiological arousal condition)
    GateCriterion(
      id: 'g7_i11_physio',
      description:
          'I1.1 physiological arousal demonstrated: at least one B8 '
          'assessment completed immediately after mild physiological arousal '
          'induction (brief vigorous exercise or cold exposure). Condition D '
          'data must exist in assessment results.',
      track: 'B',
      domain: 'integration',
      criterionType: GateCriterionType.auto,
      assessmentId: 'B8',
      notes: 'Cognitive and emotional load testing alone is insufficient. '
          'Noradrenergic stress degrades PFC-dependent monitoring via a '
          'mechanism independent of effort and motivation (Raio et al., 2013). '
          'Skills must be tested at the level where the firewall must operate.',
    ),
  ],
);

// ─── Gate 8: Phase 7 → 8 ─────────────────────────────────────────────────────

const _gate8 = GateDefinition(
  gateNumber: 8,
  fromPhase: 7,
  toPhase: 8,
  name: 'State Modulation Exit',
  description:
      'Layer 3 state modulation skills and I1.4 practice quality monitoring '
      'have reached threshold. Ready for Pattern Work.',
  criteria: [
    GateCriterion(
      id: 'g8_m31',
      description:
          'M3.1: Can reduce subjective arousal by ≥ 2 points (0–10) within '
          '5 minutes. HR shows ≥ 5 bpm reduction. Consistent across ≥ 8 '
          'sessions in varied contexts.',
      track: 'B',
      domain: 'integration',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g8_m32',
      description:
          'M3.2: Can shift between 3 defined states within 5 minutes. Can '
          'sustain each state for 10 minutes. Can accurately report current '
          'state; somatic signature confirms reported state.',
      track: 'A',
      domain: 'integration',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g8_m33',
      description:
          'M3.3: Pre-task arousal calibration within ≤ 2 points (0–10 scale) '
          'of target, across ≥ 10 logged pre-task calibrations spanning '
          'diverse task types. Error rate shows decreasing trend.',
      track: 'B',
      domain: 'integration',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g8_m34',
      description:
          'M3.4: Can reduce emotional intensity by ≥ 2 points (0–10) within '
          '5 minutes after detection and attribution. Somatic signature '
          'remains detectable (not suppressed). Consistent across ≥ 5 '
          'emotion types.',
      track: 'A',
      domain: 'integration',
      criterionType: GateCriterionType.manual,
      notes: 'If somatic signature disappears entirely, this is suppression, '
          'not modification. Track B HR check confirms.',
    ),
    GateCriterion(
      id: 'g8_i14',
      description:
          'I1.4: Session quality assessment (7E) logs for ≥ 6 consecutive '
          'weeks show active adjustments on at least 1 quality dimension per '
          'week. Not consistently rated all-high without changes.',
      track: 'A',
      domain: 'integration',
      criterionType: GateCriterionType.manual,
    ),
  ],
);

// ─── Gate 9: Phase 8 — 12-week checkpoint ────────────────────────────────────

const _gate9 = GateDefinition(
  gateNumber: 9,
  fromPhase: 8,
  toPhase: 8,
  name: 'Pattern Work — 12-Week Checkpoint',
  description:
      'Phase 8 has no fixed endpoint. This checkpoint confirms that '
      'Pattern Work is proceeding with genuine depth. Not a gate to a new '
      'phase — a progress review within ongoing practice.',
  criteria: [
    GateCriterion(
      id: 'g9_p31',
      description:
          'P3.1: Pattern Library documents ≥ 5 recurring patterns with '
          'triggers, response sequences, somatic signatures, and context '
          'conditions. Predictive accuracy > 60% on documented patterns.',
      track: 'A',
      domain: 'integration',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g9_p32',
      description:
          'P3.2: Pattern interruption attempted for ≥ 3 patterns. Success '
          'rate > 50% on targeted patterns across 2 consecutive weeks. '
          'Successful interruptions confirmed distinct from suppression.',
      track: 'A',
      domain: 'integration',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g9_p33',
      description:
          'P3.3: ≥ 1 completed reframing exercise per week for ≥ 8 '
          'consecutive weeks. Can identify when reframing becomes motivated '
          'reframing (self-deception flag rate documented).',
      track: 'A',
      domain: 'integration',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g9_p34',
      description:
          'P3.4: Topology map has ≥ 10 connected nodes. At least 3 revision '
          'sessions documented. High-traffic clusters identified and '
          'operationally used for P3.2 and P3.3 decisions.',
      track: 'A',
      domain: 'integration',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g9_p35',
      description:
          'P3.5: ≥ 1 directed practice cycle in progress — target from '
          'topology map, ≥ 6 weeks executed, pre/post measures defined and '
          'documented. I1.4 quality monitoring applied throughout.',
      track: 'A',
      domain: 'integration',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g9_i11',
      description:
          'I1.1 full (Track B): B8 — all Layer 2 monitoring skills ≥ 80% '
          'rested quality across all 4 load types (including Cond D), in '
          'ecologically valid conditions, sustained across ≥ 4 consecutive '
          'weeks.',
      track: 'B',
      domain: 'integration',
      criterionType: GateCriterionType.auto,
      assessmentId: 'B8',
      threshold: 80.0,
    ),
    GateCriterion(
      id: 'g9_i12',
      description:
          'I1.2 full (Track B): Recovery within 10 minutes of disruption. '
          'Baseline quality ≥ 90% of pre-disruption level. Decreasing '
          'recovery time trend visible over 12 weeks.',
      track: 'B',
      domain: 'integration',
      criterionType: GateCriterionType.manual,
    ),
    GateCriterion(
      id: 'g9_i13',
      description:
          'I1.3: Calibration honesty check (B11) at 12-week checkpoint. '
          'No systematic overestimation bias. Self-description baseline '
          'reviewed and updated if genuine change has occurred.',
      track: 'A',
      domain: 'integration',
      criterionType: GateCriterionType.auto,
      assessmentId: 'B11',
      threshold: 80.0,
    ),
  ],
);

import 'assessment_model.dart';

/// All 19 assessments in the framework as compile-time constants.
/// Section A = validated instruments (A1–A6).
/// Section B = custom protocols (B1–B11, including B5a and B5b added in v0.2).
const List<AssessmentContent> kAssessments = [
  // ─── Section A — Validated instruments ──────────────────────────────────────

  AssessmentContent(
    id: 'TAS20',
    name: 'TAS-20 (Toronto Alexithymia Scale)',
    shortDescription: 'Measures difficulty identifying, describing, and externally orienting feelings.',
    runner: AssessmentRunner.questionnaire,
    section: AssessmentSection.validatedInstrument,
    phasesAdministered: [0],
    estimatedMinutes: 10,
    scoringNotes: '≤ 51 Standard  |  52–60 Extended  |  > 61 Priority track assignment.',
    thresholds: {'Standard': 51, 'Extended': 60, 'Priority': 61},
  ),

  AssessmentContent(
    id: 'FFMQ',
    name: 'FFMQ Observing Subscale',
    shortDescription: 'Tracks development of meta-attention (A2.1, A2.2) via observing facet.',
    runner: AssessmentRunner.questionnaire,
    section: AssessmentSection.validatedInstrument,
    phasesAdministered: [3, 5, 6, 8],
    estimatedMinutes: 5,
    scoringNotes: '8–20 Low  |  21–28 Developing  |  29–35 Functional  |  36–40 High.',
    thresholds: {'Phase 5 threshold': 29.0, 'High capacity': 36.0},
  ),

  AssessmentContent(
    id: 'SMSMind',
    name: 'SMS-Mind Subscale',
    shortDescription: 'Mindful awareness of thoughts as events — maps to C2.1 and C2.6.',
    runner: AssessmentRunner.scoreEntry,
    section: AssessmentSection.validatedInstrument,
    phasesAdministered: [3, 4, 6, 8],
    estimatedMinutes: 10,
    scoringNotes:
        'Track direction of change from Phase 3 baseline. No single clinical cutoff — '
        'a meaningful increase by Phase 4/6 confirms C2.1 and C2.6 are developing. '
        'Source: Chadwick et al. (2008). Search "Southampton Mindfulness Scale."',
  ),

  AssessmentContent(
    id: 'PHQ9',
    name: 'PHQ-9',
    shortDescription: 'Depression symptom severity — safety monitor and emotional regulation proxy.',
    runner: AssessmentRunner.questionnaire,
    section: AssessmentSection.validatedInstrument,
    phasesAdministered: [2, 4, 5, 6],
    estimatedMinutes: 5,
    scoringNotes: '0–4 Minimal  |  5–9 Mild  |  10–14 Moderate  |  15+ Seek clinical support.\n'
        'Score ≥ 10 hard-blocks the L2→L3 gate.',
    thresholds: {'Moderate': 10.0, 'Clinical caution': 15.0},
  ),

  AssessmentContent(
    id: 'DASS21',
    name: 'DASS-21',
    shortDescription: 'Depression, anxiety, and stress subscales — decompose distress profile.',
    runner: AssessmentRunner.questionnaire,
    section: AssessmentSection.validatedInstrument,
    phasesAdministered: [2, 4, 5, 6],
    estimatedMinutes: 10,
    scoringNotes:
        'Multiply each subscale sum × 2 for DASS-42 equivalent. '
        'Depression ≥ 21 / Anxiety ≥ 15 / Stress ≥ 26: consider clinical support.',
  ),

  AssessmentContent(
    id: 'RRS',
    name: 'Rumination Response Scale',
    shortDescription: 'Ruminative response tendency — tracks C2.6 (Narrative Monitoring).',
    runner: AssessmentRunner.scoreEntry,
    section: AssessmentSection.validatedInstrument,
    phasesAdministered: [4, 6],
    estimatedMinutes: 10,
    scoringNotes:
        'No standard cutoff — use as change score from Phase 4 baseline. '
        'Decrease of 5+ points by Phase 4 exit confirms C2.6 developing. '
        'Source: Nolen-Hoeksema & Morrow (1991). 22-item version. '
        'Search "Rumination Response Scale."',
  ),

  // ─── Section B — Custom protocols ───────────────────────────────────────────

  AssessmentContent(
    id: 'B1',
    name: 'B1 Somatic Baseline Assessment',
    shortDescription: 'Body scan: sensation count, language quality, and blank body regions.',
    runner: AssessmentRunner.b1BodyMap,
    section: AssessmentSection.customProtocol,
    phasesAdministered: [0, 1],
    estimatedMinutes: 15,
    scoringNotes:
        'Phase 1 exit threshold: ≥ 5 distinct sensations, ≥ 80% physical language, '
        'across 3 consecutive sessions in the same week.',
    thresholds: {'Phase 1 exit: sensation count': 5.0, 'Physical language %': 80.0},
  ),

  AssessmentContent(
    id: 'B2',
    name: 'B2 Heartbeat Detection Task',
    shortDescription: 'Interoceptive accuracy via counted vs. expected heartbeats.',
    runner: AssessmentRunner.b2Hbd,
    section: AssessmentSection.customProtocol,
    phasesAdministered: [0, 1, 2],
    isWeekly: true,
    estimatedMinutes: 15,
    scoringNotes:
        'Mean accuracy = average of 4 interval accuracies. '
        'Threshold: ≥ 70% across 3 consecutive weekly sessions = S1.2 met.',
    thresholds: {'Standard': 65.0, 'Threshold met': 70.0, 'High': 80.0},
  ),

  AssessmentContent(
    id: 'B3',
    name: 'B3 Arousal Calibration Crosscheck',
    shortDescription: 'Self-estimated arousal vs. actual HR — calibration accuracy.',
    runner: AssessmentRunner.b3Arousal,
    section: AssessmentSection.customProtocol,
    phasesAdministered: [1, 2],
    isWeekly: true,
    estimatedMinutes: 5,
    scoringNotes:
        'Threshold: self-estimates within ±2 arousal points of HR-expected '
        'in ≥ 70% of weekly checks over a 4-week period.',
    thresholds: {'Tolerance': 2.0, 'Weekly pass rate': 70.0},
  ),

  AssessmentContent(
    id: 'B4',
    name: 'B4 Emotional Vocabulary Audit',
    shortDescription: 'Count and granularity of named distinct emotional states.',
    runner: AssessmentRunner.b4Vocab,
    section: AssessmentSection.customProtocol,
    phasesAdministered: [0, 2],
    estimatedMinutes: 15,
    scoringNotes:
        'Phase 2 exit threshold: ≥ 20 distinct states, granularity ≥ 3.',
    thresholds: {'Phase 2 exit: word count': 20.0, 'Granularity': 3.0},
  ),

  AssessmentContent(
    id: 'B5',
    name: 'B5 Attention Sustaining Assessment',
    shortDescription: '10-minute breath focus: drift count and longest continuous stretch.',
    runner: AssessmentRunner.b5Attention,
    section: AssessmentSection.customProtocol,
    phasesAdministered: [0, 1],
    estimatedMinutes: 12,
    scoringNotes:
        'Phase 1 exit threshold: ≤ 3 drifts AND ≥ 10-min longest stretch, '
        'across 5 consecutive sessions within the same week.',
    thresholds: {'Phase 1 exit: max drifts': 3.0, 'Min stretch (min)': 10.0},
  ),

  AssessmentContent(
    id: 'B5a',
    name: 'B5a Attention Direction & Discrimination',
    shortDescription: 'Deliberate redirection accuracy and chosen vs. pulled discrimination.',
    runner: AssessmentRunner.b5aDirection,
    section: AssessmentSection.customProtocol,
    phasesAdministered: [1],
    estimatedMinutes: 20,
    scoringNotes:
        'Phase 1 exit threshold: ≥ 8 of 10 cues completed within 5 s; '
        'chosen vs. pulled discrimination > 75%.',
    thresholds: {'Direction cues passed': 8.0, 'Discrimination accuracy %': 75.0},
  ),

  AssessmentContent(
    id: 'B5b',
    name: 'B5b Distraction Resistance Assessment',
    shortDescription: 'Attention maintenance across 3 distractor environments.',
    runner: AssessmentRunner.b5bDistraction,
    section: AssessmentSection.customProtocol,
    phasesAdministered: [2],
    estimatedMinutes: 45,
    scoringNotes:
        'Phase 2 exit threshold: ≤ 2 unrecovered drifts per session, '
        'across ≥ 3 sessions in distinct distraction environments.',
    thresholds: {'Max unrecovered drifts/session': 2.0},
  ),

  AssessmentContent(
    id: 'B6',
    name: 'B6 Meta-Attention Probe',
    shortDescription: 'Alarm-triggered capture of current attentional object and latency.',
    runner: AssessmentRunner.b6Probe,
    section: AssessmentSection.customProtocol,
    phasesAdministered: [3],
    estimatedMinutes: 5,
    scoringNotes:
        'Phase 3 exit threshold: accuracy ≥ 80% and improving A-latency trend. '
        'This runner records a single probe; run 10 per day × 5 days.',
    thresholds: {'Accuracy threshold %': 80.0},
  ),

  AssessmentContent(
    id: 'B7',
    name: 'B7 Dual Presence Performance Test',
    shortDescription: 'Comprehension under concurrent internal monitoring — A2.2.',
    runner: AssessmentRunner.b7DualPresence,
    section: AssessmentSection.customProtocol,
    phasesAdministered: [5, 6],
    estimatedMinutes: 35,
    scoringNotes:
        'Threshold: Part 2 / Part 1 comprehension ≥ 85% ratio; '
        '≥ 4 of 5 state reports are specific; ≥ 2 distinct states across 5 probes.',
    thresholds: {'Comprehension ratio %': 85.0, 'Specific reports': 4.0},
  ),

  AssessmentContent(
    id: 'B8',
    name: 'B8 Load-Condition Assessment',
    shortDescription: 'Six metacognitive skills rated under 4 high-load conditions including physiological arousal — I1.1.',
    runner: AssessmentRunner.b8LoadMatrix,
    section: AssessmentSection.customProtocol,
    phasesAdministered: [5, 6, 8],
    estimatedMinutes: 30,
    scoringNotes:
        'Threshold: mean score ≥ 80% of rested baseline in all 4 conditions including Cond D — physiological arousal (full L2→L3 gate). '
        'Phase 5 provisional: ≥ 80% in ≥ 2 conditions (Cond D attempted but not required to pass).',
    thresholds: {'Retention threshold %': 80.0},
  ),

  AssessmentContent(
    id: 'B9',
    name: 'B9 Boundary Challenge Assessment',
    shortDescription: 'Attribution accuracy across 3 media/social exposure scenarios — B2.1, B2.2.',
    runner: AssessmentRunner.b9Boundary,
    section: AssessmentSection.customProtocol,
    phasesAdministered: [5],
    estimatedMinutes: 30,
    scoringNotes:
        'Threshold: attribution made for all 3 sessions with stated evidence; '
        'not systematically defaulting one way; ≥ 1 values-conflict detected in real time.',
  ),

  AssessmentContent(
    id: 'B10',
    name: 'B10 State Shifting Verification',
    shortDescription: '3 timed trials: shift to target state within 5 min, sustain 10 min.',
    runner: AssessmentRunner.b10StateShifting,
    section: AssessmentSection.customProtocol,
    phasesAdministered: [7],
    estimatedMinutes: 30,
    scoringNotes:
        'Threshold: shift ≤ 5 min; sustained 10 min; fidelity ≥ 4; '
        '3 specific somatic markers for each trial.',
    thresholds: {'Max shift time (min)': 5.0, 'Min fidelity': 4.0},
  ),

  AssessmentContent(
    id: 'B11',
    name: 'B11 Calibration Honesty Check',
    shortDescription: 'Self-rate vs. evidence-rate across all 41 framework skills — I1.3.',
    runner: AssessmentRunner.b11Calibration,
    section: AssessmentSection.customProtocol,
    phasesAdministered: [3, 6, 8],
    estimatedMinutes: 60,
    scoringNotes:
        'Gap = evidence-rate minus self-rate. Positive = underestimate; negative = overestimate. '
        'Score = mean absolute gap across rated skills. Lower is better.',
    thresholds: {'Target mean absolute gap': 1.0},
  ),
];

/// Lookup an assessment by id.
AssessmentContent? assessmentById(String id) {
  try {
    return kAssessments.firstWhere((a) => a.id == id);
  } catch (_) {
    return null;
  }
}

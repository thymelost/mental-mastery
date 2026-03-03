import 'phase_model.dart';

/// All 9 phases of the Mental Mastery framework, in order.
const List<PhaseContent> kPhases = [
  PhaseContent(
    phaseNumber: 0,
    name: 'Entry Assessment',
    description:
        'Establish your individual baseline across all Layer 1 domains. '
        'No recurring practices — assessment only. '
        'Administers TAS-20 and B1–B4 to assign your entry track '
        '(Standard or Accelerated).',
    layer: 'Pre-training',
    durationNote: '1–2 weeks',
    exitGateNumber: 1,
    skillIds: [],
    practiceIds: [],
  ),
  PhaseContent(
    phaseNumber: 1,
    name: 'Somatic & Attentional Foundation',
    description:
        'Develop core somatic awareness, interoceptive accuracy, '
        'and attention sustaining. First daily practice schedule. '
        'Builds S1.1, S1.2, A1.1, A1.2, A1.3, and E1.1 to provisional thresholds.',
    layer: 'L1',
    durationNote: '4–8 weeks',
    exitGateNumber: 2,
    skillIds: ['S1.1', 'S1.2', 'A1.1', 'A1.2', 'A1.3', 'E1.1'],
    practiceIds: ['P1A', 'P1B', 'P1C', 'P1D'],
  ),
  PhaseContent(
    phaseNumber: 2,
    name: 'Emotional Literacy & Attentional Depth',
    description:
        'Expand emotional vocabulary to ≥20 distinct states, '
        'map physiological baselines for each, '
        'and build attention depth under distraction. '
        'Completes Layer 1 Emotional Literacy and Attention domains.',
    layer: 'L1',
    durationNote: '4–8 weeks',
    exitGateNumber: 3,
    skillIds: ['S1.3', 'S1.4', 'E1.2', 'E1.3', 'E1.4', 'A1.4', 'A1.5'],
    practiceIds: ['P2A', 'P2B', 'P2C', 'P2D', 'P2E', 'P2F'],
  ),
  PhaseContent(
    phaseNumber: 3,
    name: 'Layer 1 → 2 Bridge',
    description:
        'Introduce metacognitive observation skills while Layer 1 consolidates. '
        'Formal introduction of I1.3 Calibration Honesty — '
        'the ability to accurately assess your own skill level. '
        'First exposure to thought observation (A2.1).',
    layer: 'L1 → L2',
    durationNote: '4–8 weeks',
    exitGateNumber: 4,
    skillIds: ['A2.1', 'C2.1', 'C2.2', 'I1.3'],
    practiceIds: ['P3A', 'P3B', 'P3C'],
  ),
  PhaseContent(
    phaseNumber: 4,
    name: 'Metacognitive Core',
    description:
        'Build full metacognitive monitoring, cognitive load sensing, '
        'and emotional source attribution. '
        'Covers all Cognitive Monitoring (C2) and '
        'Emotional Self-Monitoring (E2) domains.',
    layer: 'L2',
    durationNote: '8–12 weeks',
    exitGateNumber: 5,
    skillIds: ['C2.3', 'C2.4', 'C2.5', 'C2.6', 'E2.1', 'E2.2', 'E2.3'],
    practiceIds: ['P4A', 'P4B', 'P4C', 'P4D', 'P4E', 'P4F', 'P4G'],
  ),
  PhaseContent(
    phaseNumber: 5,
    name: 'Self-Boundary & Dual Presence',
    description:
        'Develop self-boundary integrity (B2.1–B2.4), dual presence (A2.2), '
        'and skill performance under cognitive load. '
        'Introduces recovery speed training (I1.2) and incongruence detection (B2.2). '
        'Prepares all Layer 2 skills for verification.',
    layer: 'L2',
    durationNote: '8–12 weeks',
    exitGateNumber: 6,
    skillIds: ['B2.1', 'B2.2', 'B2.3', 'B2.4', 'A2.2', 'I1.1', 'I1.2'],
    practiceIds: ['P5A', 'P5B', 'P5C', 'P5D', 'P5E', 'P5F', 'P5G', 'P5H'],
  ),
  PhaseContent(
    phaseNumber: 6,
    name: 'Layer 2 Verification',
    description:
        'Stability verification — no new skill acquisition. '
        'Confirms that all Layer 2 skills function reliably under '
        'realistic conditions before granting Layer 3 access. '
        'This is the critical L2→L3 gate. PHQ-9 ≥ 10 is a hard block.',
    layer: 'L2 Verification',
    durationNote: '2–4 weeks',
    exitGateNumber: 7,
    skillIds: [],
    practiceIds: [],
  ),
  PhaseContent(
    phaseNumber: 7,
    name: 'State Modulation',
    description:
        'Develop voluntary state regulation (M3.1–M3.4), arousal calibration, '
        'and emotional response modification. '
        'Formal introduction of I1.4 Practice Quality Monitoring — '
        'behavioral relevance as a necessary gate for plasticity.',
    layer: 'L3',
    durationNote: '8–12 weeks',
    exitGateNumber: 8,
    skillIds: ['M3.1', 'M3.2', 'M3.3', 'M3.4', 'I1.4'],
    practiceIds: ['P7A', 'P7B', 'P7C', 'P7D', 'P7E'],
  ),
  PhaseContent(
    phaseNumber: 8,
    name: 'Pattern Work',
    description:
        'Recognize, interrupt, and reshape recurring cognitive-emotional patterns '
        '(P3.1–P3.5). Ongoing without ceiling. '
        'Progress checkpoints at 12 weeks and 24 weeks. '
        'Completion is defined by sustained performance, not a final gate.',
    layer: 'L3',
    durationNote: 'Ongoing',
    exitGateNumber: null,
    skillIds: ['P3.1', 'P3.2', 'P3.3', 'P3.4', 'P3.5'],
    practiceIds: ['P8A', 'P8B', 'P8C', 'P8D', 'P8E'],
  ),
];

# Mental Mastery — Skill Taxonomy

**Version:** 0.3
**Purpose:** Define the complete skill set required for cognitive self-governance and safe interaction with advanced cognitive/neural influence technologies.
**Design principle:** Skills are trainable mechanisms, not personality traits. All skills have observable behavioral correlates and can, in principle, be measured.
**Research base:** 33 papers reviewed (7 original + 26 expansion — see `research-grounding.md`). Revisions from research marked with `[R]` inline.
**Updated:** 2026-03-02 — B2 domain grounded in source monitoring theory; domain-specificity of metacognition added; stress-transfer constraint named.

---

## Architecture Overview

The taxonomy is organized into three layers and eight domains. Layers are not strictly sequential — some Layer 2 skills can begin development before all Layer 1 skills are complete — but no Layer 3 skill is safe to pursue without a solid Layer 2 foundation.

```
LAYER 3: Intentional Plasticity     ← deliberate reshaping of cognitive patterns
LAYER 2: Metacognitive Monitoring   ← real-time observation of one's own processing
LAYER 1: Foundational Literacy      ← bodily, emotional, attentional baseline

DOMAINS: Somatic | Emotional | Attention | Cognitive | Self-Boundary | Modulation | Pattern | Integration
```

Dependencies flow upward. A skill marked with `→` enables the skills listed after the arrow.

---

## LAYER 1 — Foundational Literacy

> Goal: Establish stable, accurate internal signal reception. You cannot monitor what you cannot first perceive.

---

### Domain 1: Somatic Intelligence

Skills in this domain build the body as an information source. Emotional literacy depends on this domain. Everything above it does too.

> **[R] Research note:** The salience network (insula + ACC) shows specifically improved functional reconfiguration efficiency after 8-week mindfulness therapy (Yue et al., 2023). Insula cortical thickness increases with concurrent alexithymia decrease after 8-week MBSR (Calderone et al., 2024). **Critical:** Focused-attention breath meditation does NOT reliably develop somatic awareness — the SMS-Body subscale showed no group improvement in fMRI neurofeedback RCT (Ganesan et al., 2025). Somatic skills require dedicated somatic practices (body scan, interoceptive tracking), not breath-focused meditation alone.

| ID | Skill | Description | Prerequisites | Enables |
|----|-------|-------------|---------------|---------|
| S1.1 | Sensation Recognition | Identify and locate discrete physical sensations (pressure, heat, tension, vibration, etc.) without interpretation. | None | S1.2, E1.1 |
| S1.2 | Interoceptive Accuracy | Accurately perceive internal body states (heart rate, breath depth, gut tension, facial muscle state). Distinguish signal from ambient noise. | S1.1 | S1.3, S1.4, E1.2 |
| S1.3 | Physiological Baseline Mapping | Establish and maintain an internal reference model of personal "neutral" across multiple body systems. Deviation becomes detectable only when baseline is known. | S1.2 | S2.1, C2.1 |
| S1.4 | Arousal Level Detection | Read current nervous system activation level (low / mid / high) with reasonable accuracy in real time. | S1.2 | A1.4, M1.1, P1.1 |

---

### Domain 2: Emotional Literacy

Without this domain, internal signals are noise. Individuals vary significantly in native ability here — training must begin from wherever the individual actually is.

> **[R] Research note:** Somatic-emotion mapping (E1.2) has the strongest neuroanatomical support in this corpus: insula thickness increase + alexithymia decrease after 8-week MBSR (Calderone et al., 2024). Amygdala reactivity decrease after MBSR (Gkintoni et al., 2025) supports emotional gradient detection (E1.4) at the level of automatic processing, prior to explicit labeling. Estimated timescale: structural/functional changes at 8 weeks.

| ID | Skill | Description | Prerequisites | Enables |
|----|-------|-------------|---------------|---------|
| E1.1 | Primary Emotion Identification | Name the seven primary emotional states (fear, anger, sadness, joy, disgust, surprise, contempt) when they occur. | S1.1 | E1.2 |
| E1.2 | Somatic-Emotion Mapping | Connect specific emotions to their reliable physical signatures in *your* body. (e.g., anxiety = chest tightness + shallow breath for this person.) | S1.2, E1.1 | E1.3, E1.4 |
| E1.3 | Emotional Vocabulary Expansion | Build sufficient vocabulary to distinguish subtle emotional states — not just "bad" but whether it is anxiety, dread, shame, unease, grief, or contempt. Precision reduces misattribution. | E1.2 | E1.4, C2.2 |
| E1.4 | Emotional Gradient Detection | Detect emotional state changes *early* — before they reach intensity. This is the early-warning system. Fine-grained perception of intensity changes (0→2, not 0→8). | E1.2, E1.3 | E2.1, B1.2 |

---

### Domain 3: Attention

Attention is the instrument through which all other skills operate. An unstable attention instrument makes all readings unreliable.

> **[R] Research note (important):** There is a critical split between neural-level and behavioral-test-level evidence. **Neural efficiency gains ARE supported:** ECN functional reconfiguration efficiency increases after 8-week mindfulness (Yue et al., 2023); PCC-DLPFC coupling increases with NF-guided meditation (Ganesan et al., 2025). **Behavioral test performance is NOT reliably supported:** BCT accuracy declined in the group with the strongest neural/subjective improvement (Ganesan et al., 2025); Lao et al. 2016 found short-term mindfulness did not improve objective attentional measures (cited in Gkintoni et al., 2025). **Do not use BCT accuracy or standard neuropsychological attention tests as primary skill progress markers.** Use ecological validity measures or neural efficiency proxies.

| ID | Skill | Description | Prerequisites | Enables |
|----|-------|-------------|---------------|---------|
| A1.1 | Attention Sustaining | Hold voluntary focus on a single object (breath, sound, sensation) for increasing durations without involuntary drift. | None | A1.2, A1.3 |
| A1.2 | Attention Directing | Move attention voluntarily and precisely to a chosen target, internal or external. Distinguish "chose to attend" from "was pulled to attend." | A1.1 | A1.4, A1.5, C2.1 |
| A1.3 | Attention Recovery | Notice when attention has drifted and return it to target without judgment. Speed and consistency of recovery is the measurable output. | A1.1 | A2.1 |
| A1.4 | Distraction Resistance | Maintain chosen attentional focus in the presence of competing stimuli. Recognize pull without following it. | A1.2, S1.4 | A2.2, B1.1 |
| A1.5 | Aperture Control | Narrow attention to a point or widen it to a field deliberately. Peripheral awareness without focal drift. | A1.2 | A2.2, C2.1 |

---

## LAYER 2 — Metacognitive Monitoring

> Goal: Develop the ability to observe one's own cognitive and emotional processing in real time — not just *what* is happening, but *how* and *from where*.

This is the core protective layer. A person operating here can notice influence before it completes. It is not enough to have the skills; they must be available under normal conditions, not just in quiet practice.

> **[R] Critical constraint — domain-specificity of metacognition:** Metacognitive accuracy is NOT a general capacity that transfers across domains. Three converging fMRI/TMS studies (Morales et al., 2018; Shekhar & Rahnev, 2018; Fleming et al., 2014) and a large-sample study (Molenberghs et al., 2016, n=308) establish that the precision monitoring layer (aPFC/right rostrolateral PFC) carries domain-specific representations that do not generalise. Individual metacognitive scores for perception and memory are uncorrelated. Anterior PFC lesions selectively impair perceptual metacognition while leaving memory metacognition intact. **Practical implication:** High Cognitive Monitoring skill (C2 domain) does NOT substitute for Emotional Self-Monitoring skill (E2 domain), which does NOT substitute for Somatic monitoring (S1 domain), which does NOT substitute for Self-Boundary monitoring (B2 domain). Each domain requires its own dedicated training and independent assessment. A practitioner who has excellent thought observation cannot be assumed to have equivalent emotional source attribution or boundary integrity. These are mechanistically separate capacities.
>
> **[R] Critical constraint — metacognitive unavailability under load:** Maniscalco & Lau (2015) demonstrated that active working memory manipulation (not mere WM maintenance) specifically degrades metacognitive sensitivity — the ability to accurately judge the correctness of one's own cognitive outputs. Ruminative, planning, and worry states involve exactly this kind of active manipulation. The states in which practitioners most want to self-monitor are the states in which self-monitoring is least reliable. Somatic grounding and attentional stabilisation (Layer 1) must precede metacognitive attempts when the individual is in an active-manipulation cognitive state. This is not a skill failure — it is a state-dependent neurobiological constraint.

---

### Domain 4: Cognitive Process Monitoring

> **[R] Research note:** This is the best-evidenced Layer 2 domain. Thought observation (C2.1) and narrative monitoring (C2.6) are the primary mechanisms in MBCT — teaching practitioners to observe negative thought patterns as events rather than facts. The 87-study review (Gkintoni et al., 2025) shows this mechanism underlies the strongest clinical outcomes: relapse prevention in recurrent depression (60-week maintenance, Kuyken et al. cited). SMS-Mind subscale (mindful awareness of thinking) showed specific group improvement in fMRI NF RCT (Ganesan et al., 2025), with PCC deactivation as the neural correlate.

| ID | Skill | Description | Prerequisites | Enables |
|----|-------|-------------|---------------|---------|
| C2.1 | Thought Observation | Watch thoughts arise and pass as discrete events without identification. "I am having the thought that X" rather than "X is true." | A1.2, A1.5, S1.3 | C2.2, C2.3, B2.1 |
| C2.2 | Cognitive State Labeling | Name the current mode of thinking in real time: analyzing, ruminating, daydreaming, narratizing, problem-solving, etc. Each mode has a different signature. | C2.1, E1.3 | C2.3, C2.4 |
| C2.3 | Process Awareness | Notice *how* thinking is occurring, not only *what* is being thought. Detecting shortcuts, assumptions-as-facts, collapsed reasoning. | C2.1, C2.2 | C2.5, B2.2 |
| C2.4 | Cognitive Load Sensing | Accurately assess current mental capacity — recognize when reasoning is degraded by fatigue, emotion, or overload. A degraded processor cannot trust its own outputs. | C2.2, S1.4 | B2.3, I1.1 |
| C2.5 | Assumption Detection | Notice when inference is being treated as observation. Distinguish "I see X" from "I concluded X from Y." | C2.3 | C2.6, B2.2 |
| C2.6 | Narrative Monitoring | Detect when an internal story is running — a coherent sequence of meaning being generated, often automatically. Stories feel like reality; monitoring exposes them as construction. | C2.5 | B2.1, P3.2 |

---

### Domain 5: Emotional Self-Monitoring

| ID | Skill | Description | Prerequisites | Enables |
|----|-------|-------------|---------------|---------|
| E2.1 | Emotional Source Attribution | Determine where an emotional state likely originated: internal (memory, belief, anticipation) vs. external (environmental trigger, social influence). | E1.4, C2.1 | B2.1, B2.2 |
| E2.2 | Emotional Contagion Awareness | Recognize when emotional states are being transferred from others (or media, environments) vs. arising from within. | E2.1 | B2.1 |
| E2.3 | Affect-Cognition Coupling Detection | Notice when emotional state is shaping reasoning — specifically when it is generating biases, distortions, or motivated conclusions. | E2.1, C2.3 | C2.6, P3.1 |

---

### Domain 6: Self-Boundary Integrity

This domain is the direct firewall mechanism. It answers the question: *Is this thought/feeling/impulse mine?*

> **[R] Research note — Source Monitoring as the domain mechanism:** The B2 domain is now grounded in source monitoring theory (Johnson, Hashtroudi & Lindsay, 1993; Mitchell & Johnson, 2009; Simons et al., 2008; Brandt et al., 2014). Source monitoring is the cognitive mechanism through which people attribute the origins of their mental content to a particular source. When it fails, externally introduced content feels self-generated. The five failure modes the B2 domain trains against are: **(1) source amnesia** — content retrieved without source; **(2) misattributed familiarity** — processing fluency from repeated exposure misread as authentic prior belief (the mechanism of propaganda and advertising); **(3) cryptomnesia** — externally encountered ideas experienced as original thought; **(4) incorporation of fiction as fact** — narratively processed content integrated as factual belief; **(5) criteria relaxation under stress** — systematic monitoring bypassed under load, lax criteria allow external content to pass as self-generated.
>
> **[R] Neural substrate — origin monitoring (self vs. other):** Medial anterior PFC (BA10) is specifically recruited for self/other origin monitoring and functionally couples with right lateral PFC during source attribution (Simons et al., 2008). This is distinct from context monitoring (self-generated vs. perceived), which is less medial-PFC dependent and easier to train. The B2.1 prerequisite chain (C2.1 → E2.1 → B2.1) reflects context-monitoring-first, then origin-monitoring: a neurobiologically supported sequencing. Individual differences in this capacity correlate with psychosis-proneness (r = −0.56) across the healthy population — this is a continuous trait, not a clinical binary. Bilateral paracingulate sulcus absence (~13% of population) creates a structural floor on reality monitoring capacity AND reduces metacognitive awareness of that deficit — for these individuals, Track B performance assessment is the only reliable measurement channel (Buda et al., 2011; Garrison et al., 2021).
>
> **[R] Trainability confirmed:** Subramaniam et al. (2012) demonstrated that 80 hours of bottom-up perceptual precision training (not direct B2 training) restored mPFC activation and normalised origin monitoring accuracy in schizophrenia patients. Neural normalisation predicted social functioning at 6-month follow-up. This confirms the L1→L2→B2 architecture: building the perceptual and attentional substrate enables higher-order boundary monitoring through transfer.
>
> **[R] aPFC contamination is the influence mechanism:** Shekhar & Rahnev (2018) showed aPFC confidence judgments are contaminated by confidence history, arousal state, and social context — nonperceptual factors that degrade source attribution accuracy. B2 training is, at this mechanistic level, aPFC decontamination through strengthened systematic monitoring habits. The five B2 skills operationalise specific decontamination strategies.
>
> **[R] Design warning — imagery vividness:** Moseley et al. (2018) found that internally generated content encoded with high vividness was more likely to be subsequently misattributed as externally perceived. Any B2 or P3 practice using mental imagery must include an explicit source-marking step ("this is self-generated content") to prevent the vividness-misattribution coupling from strengthening.

| ID | Skill | Description | Prerequisites | Enables |
|----|-------|-------------|---------------|---------|
| B2.1 | Self-Other Signal Distinction | Distinguish internally-generated from externally-introduced cognitive and emotional content in real time. Requires stable baseline (S1.3) and source attribution (E2.1, C2.6). | S1.3, E2.1, C2.1, C2.6 | B2.2, B2.3 |
| B2.2 | Incongruence Detection | Detect when a thought, impulse, or feeling is inconsistent with established values, beliefs, or identity patterns. Flags potential intrusion or manipulation. | B2.1, C2.5, C2.3 | B2.3, P3.1 |
| B2.3 | Value Anchoring Under Pressure | Maintain contact with core values when under cognitive load, emotional activation, or social pressure. Not stubbornness — a practiced return-to-self. | B2.2, C2.4 | B2.4 |
| B2.4 | Self-Attribution Consistency Monitoring | Monitor whether shifts in self-description are consciously noticed and endorsed — across hours, days, extended influence. The skill targets metacognitive awareness of unendorsed attribution changes, not preservation of static identity. Slow drift is hardest to detect because it evades moment-to-moment monitoring. | B2.3, S1.3 | P3.2 |

---

### Domain 7: Meta-Attention

> **[R] Research note:** FFMQ Observing subscale (noticing internal experiences) increased specifically in the mindfulness group, not the active sleep hygiene control (Yue et al., 2023) — the closest self-report marker of meta-attention. Salience network reconfiguration efficiency improved specifically in the mindfulness group; the salience network is the neural substrate for switching between internal and external attention (dual presence, A2.2). PCC-DLPFC coupling (Ganesan et al., 2025) is the neuroimaging correlate of meta-awareness running concurrently with object-level focus.

Second-order attention skills — attention directed at attention itself.

| ID | Skill | Description | Prerequisites | Enables |
|----|-------|-------------|---------------|---------|
| A2.1 | Meta-Attention | Know where attention currently is without redirecting it. "I notice I have been attending to X." | A1.3 | A2.2, C2.1 |
| A2.2 | Dual Presence | Maintain background monitoring of internal state while engaged in normal external tasks. The observer does not interrupt function — it runs concurrently. | A1.4, A1.5, A2.1 | B2.1, I1.1 |

---

## LAYER 3 — Intentional Plasticity

> Goal: Deliberate, structured reshaping of cognitive and emotional patterns. This layer is not for defense — it is for intentional change. It is only safe when Layer 2 skills are stable and reliable.

**Warning:** Operating here without solid Layer 2 capability means modifying patterns you cannot accurately perceive. This is the layer where harm becomes possible.

---

### Domain 8: State Modulation

> **[R] Research note:** Rest-to-task FC reconfiguration efficiency is a direct neural measure of state-shifting ease — the most direct neuroimaging evidence for state shifting as trainable (Yue et al., 2023). Alpha/theta EEG during mindfulness corresponds to a distinct "relaxed alertness" state distinguishable from ordinary rest and task states (Gkintoni et al., 2025). Stress/anxiety reduction effect sizes at 8 weeks: SMD ~0.57 (treat as upper estimates given 87% publication positive rate). Training at too-difficult a performance level impedes learning (Beyeler et al., 2017) — state modulation training must be within the learner's window of tolerance.

| ID | Skill | Description | Prerequisites | Enables |
|----|-------|-------------|---------------|---------|
| M3.1 | Voluntary Relaxation | Deliberately reduce physiological arousal below ambient level using practiced methods. Distinct from passive relaxation. | S1.4, A1.2 | M3.2, M3.3 |
| M3.2 | State Shifting | Move between defined cognitive/emotional states (alert-focused, open-curious, calm-stable, etc.) on demand. Not mood management — deliberate state selection. | M3.1, C2.2, E2.3 | M3.3, P3.3 |
| M3.3 | Arousal Calibration | Set activation level to match task requirements — neither over- nor under-activated for the context. | M3.2, C2.4 | P3.3 |
| M3.4 | Emotional Response Modification | After detecting and attributing an emotion (Layer 2 prerequisite), modify its intensity or duration through deliberate intervention. Not suppression — modulation with awareness. | E2.1, E2.3, M3.1 | P3.1 |

---

### Domain 9: Pattern Work

> **[R] Research note:** MBCT's 87-study evidence base rests fundamentally on P3.1–P3.3 mechanisms (pattern recognition → interruption → reframing). Hippocampal volume increase (Calderone et al., 2024) and insula/PFC thickness changes support P3.5 (directed neuroplastic practice) with structural evidence. **Critical qualification on P3.2 (Pattern Interruption):** Standard mindfulness does NOT reliably reduce impulsivity in naive practitioners at 8 weeks (Korponay et al. cited in Calderone et al., 2024; Gkintoni et al., 2025). Targeted training formats required — not general MBI. **Plasticity gate (from Fallon et al., 2009; Beyeler et al., 2017):** Behavioral relevance is necessary for directed plasticity — mere repetition is insufficient. Practice must be actively meaningful, contextually varied, and at appropriate difficulty.

| ID | Skill | Description | Prerequisites | Enables |
|----|-------|-------------|---------------|---------|
| P3.1 | Personal Pattern Recognition | Identify recurring cognitive-emotional patterns across time and context. "When X occurs, I reliably do/feel/think Y." | C2.6, E2.3, B2.4 | P3.2, P3.3 |
| P3.2 | Pattern Interruption | Consciously break automated response chains before completion. Requires advance detection (E1.4, C2.6) and the trained capacity to not-complete a pattern. | P3.1, B2.3 | P3.3, P3.4 |
| P3.3 | Deliberate Reframing | Intentionally change meaning-making structures while maintaining awareness of doing so. Distinguish deliberate reframe from self-deception. | P3.2, M3.2, B2.2 | P3.4 |
| P3.4 | Topology Mapping | Build and maintain an explicit internal model of one's cognitive architecture — how beliefs, emotions, habits, and patterns connect and reinforce each other. | P3.1, P3.3, B2.4 | P3.5 |
| P3.5 | Directed Neuroplastic Practice | Structured, consistent repetition aimed at specific pattern changes identified via Topology Mapping. This is deliberate reshaping — not incidental change. | P3.4, M3.3 | — |

---

## Cross-Layer Skills

These skills do not belong to a single layer — they are performance conditions that must develop alongside and across all layers.

| ID | Skill | Description | Depends On |
|----|-------|-------------|------------|
| I1.1 | Skill-Under-Load | Maintain Layer 2 monitoring capability under cognitive load, emotional activation, time pressure, or physical stress. Skills that only work in calm are not reliable safeguards. Perceptual learning specificity (Beyeler et al., 2017) confirms that skills trained without varied contexts remain context-specific. **[R] Critical addition:** Raio et al. (2013) demonstrated experimentally that PFC-dependent cognitive regulation strategies fail under acute physiological stress — a noradrenergic mechanism, not a motivation or effort problem. I1.1 assessment must include at least one evaluation conducted immediately after mild physiological arousal induction (exercise, cold exposure), not only under cognitive or emotional load at rest. Skills trained to automaticity (reduced PFC cost per deployment) are more stress-resistant than effortful deliberate strategies — this is the mechanism underlying Layer 3's progression toward habitual regulation. | A2.2, C2.4, B2.3 |
| I1.2 | Recovery Speed | Return to stable monitoring baseline after disruption (acute stress, emotional event, environmental overwhelm). Measured by time and quality of return. MBCT depression relapse prevention over 60 weeks implies trained practitioners recover more rapidly from mood perturbation — indirect evidence for this construct. | M3.1, B2.3 |
| I1.3 | Calibration Honesty | Accurately assess one's own current skill level rather than ideal or desired level. Prevents overconfidence in protection that isn't yet reliable. Supported by cortical prosthetics data: even under ideal laboratory conditions, self-report correlates with neural state at R=0.71–0.87 — strong but imperfect. Intrinsic variance in self-report is real even in competent practitioners. | C2.5, B2.2 |
| I1.4 | Practice Quality Monitoring | [R: Added from research] Assess and sustain the quality conditions that make practice neuroplastically effective: behavioral relevance, appropriate challenge level, contextual variety, and intentional engagement. Research convergence (Fallon et al., 2009; Beyeler et al., 2017; Ganesan et al., 2025): "behaviorally important information" is a necessary gate for cortical plasticity. Quantity of practice without quality does not produce structural change. Gamification of practice contexts enhances learning durability (effects at 2 years) by recruiting dopamine/acetylcholine systems. | C2.4, A2.2 |

---

## Dependency Graph Summary

```
LAYER 1 FOUNDATIONS
S1.1 → S1.2 → S1.3 → (enables Layer 2 B-domain)
              S1.4 → (feeds A, M domains)
E1.1 → E1.2 → E1.3 → E1.4 → (Layer 2 E-domain)
A1.1 → A1.2 → A1.3 → A2.1 → A2.2 → (Dual Presence)
       A1.4 ─┘
       A1.5 ─┘

LAYER 2 MONITORING
C2.1 → C2.2 → C2.3 → C2.5 → C2.6 → (B-domain, P-domain)
                      C2.4
E2.1 → E2.2
       E2.3 → (feeds P3.1)
B2.1 → B2.2 → B2.3 → B2.4 → (P3.1, P3.2)
A2.1 → A2.2 (Dual Presence — critical bridge to I1.1)

LAYER 3 PLASTICITY
M3.1 → M3.2 → M3.3 → (P3.3)
       M3.4
P3.1 → P3.2 → P3.3 → P3.4 → P3.5

CROSS-LAYER
I1.1 (requires A2.2, C2.4, B2.3 all stable)
I1.2 (requires M3.1, B2.3)
I1.3 (requires C2.5, B2.2)
I1.4 (requires C2.4, A2.2 — both must be functional before quality monitoring is meaningful)
```

---

## Skill Count Summary

| Layer | Domain | Skills |
|-------|--------|--------|
| L1 | Somatic Intelligence | 4 |
| L1 | Emotional Literacy | 4 |
| L1 | Attention | 5 |
| L2 | Cognitive Process Monitoring | 6 |
| L2 | Emotional Self-Monitoring | 3 |
| L2 | Self-Boundary Integrity | 4 |
| L2 | Meta-Attention | 2 |
| L3 | State Modulation | 4 |
| L3 | Pattern Work | 5 |
| Cross | Integration & Resilience | 4 |
| **Total** | | **41** |

---

## Design Notes for Progression Model (Next Phase)

1. **Entry point is not fixed.** Individuals enter at different points in L1. Assessment before assignment.
2. **Layer overlap is normal.** A2.2 (Dual Presence) begins in L1 practice but matures in L2. The layers describe *function*, not strictly sequential phases.
3. **I1.3 (Calibration Honesty) must be developed early.** Overconfidence in incomplete skills is the primary failure mode. It should be introduced at the L1→L2 transition.
4. **B2.4 (Self-Attribution Consistency Monitoring) is the most exposed skill.** Slow drift is the hardest attack surface. It requires longitudinal data — progress tracking is not optional for this skill.
5. **P3.5 (Directed Neuroplastic Practice) has no ceiling.** All other skills have functional thresholds; this one scales indefinitely. Treat as a gateway to open-ended advanced work.
6. **[R] Somatic Intelligence requires dedicated practices.** Do not rely on breath-focused meditation to develop S1.1–S1.4. Body scan and somatic tracking practices must be explicitly included.
7. **[R] Two independent measurement tracks required.** Neural efficiency proxies and subjective/behavioral measures must be tracked separately. They are not correlated within the same training window (Yue et al., 2023). Progress in one does not confirm progress in the other.
8. **[R] Do not use BCT accuracy or standard neuropsychological attention tests** as primary markers for Layer 1 Attention domain. Neural efficiency measures (ECN reconfiguration, PCC-DLPFC coupling) or ecologically valid tasks are preferred.
9. **[R] I1.4 (Practice Quality Monitoring) should be introduced at the same time as P3.5.** Without quality monitoring, hours of practice may produce no plasticity. This pairing is mandatory for Layer 3 work.
10. **[R] Timescale expectations:** Subjective improvements (1–4 weeks early), functional connectivity changes (4–8 weeks mid), structural changes (cortical thickness, 8+ weeks late). Relapse prevention and pattern stability require months. Expert effects (sustained prefrontal activation without habituation) require years.

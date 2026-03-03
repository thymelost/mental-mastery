import "practice_model.dart";

const List<PracticeContent> kPractices = [
  // ─────────────────────────────────────────────────────────────────────────
  // PHASE 1 — Somatic & Attentional Foundation
  // ─────────────────────────────────────────────────────────────────────────

  PracticeContent(
    id: "P1A",
    name: "Body Scan",
    phaseNumber: 1,
    scheduleSlot: "morning",
    durationMinutes: 30,
    skillIds: ["S1.1", "S1.2"],
    purpose: "Develop systematic somatic awareness by moving attention through the body and naming physical sensations using purely physical terms. Builds the foundational interoceptive signal that all later skills depend on.",
    steps: [
      "Lie on your back on a firm surface (floor or firm bed). Legs uncrossed, arms at sides, palms up.",
      "Take three slow breaths. On each exhale, allow your body to settle — do not force relaxation, just stop holding.",
      "Begin at the crown of your head. Place your attention there. You are not looking for anything specific — just sensing what is present. Stay for 20–30 seconds.",
      "Move slowly downward: forehead, eyes, jaw, throat, shoulders, upper arms, elbows, forearms, wrists, hands (pause on the hands — many sensations are detectable here), fingers. Then move to the chest, upper back, mid-back, lower back, abdomen, hips, pelvis.",
      "Continue through the thighs, knees, calves, ankles, feet, toes.",
      "When you find a sensation, name it silently using physical terms only: pulsing, warm, tight, heavy, numb, tingling, cool, pressure, vibrating, hollow. Avoid interpretive or emotional words such as tense, nervous, good, or bad.",
      "If an area is blank (no sensation detectable), that is data too. Note it. Do not force.",
      "If your attention wanders to thought, gently return to the body region where you left off. No judgment.",
      "After the scan, write 2–3 sentences in your journal: which regions were clearest, which were blank, anything unusual. Note the date and session number.",
    ],
    safetySignals: [
      "Pause and seek support if you experience flashback-like experiences during the body scan.",
      "Pause if dissociative episodes occur — feeling detached from your body in ways that do not resolve quickly.",
      "Pause if the practice consistently increases distress over multiple sessions rather than producing clarity.",
    ],
  ),

  PracticeContent(
    id: "P1B",
    name: "Sensation Labeling",
    phaseNumber: 1,
    scheduleSlot: "midday",
    durationMinutes: 10,
    skillIds: ["S1.1"],
    purpose: "Develop dwell-time — the ability to sustain attention on a single body region long enough for subtle sensations to become perceptible. Complements the moving scan of P1A with focused, sustained attention on one area at a time.",
    steps: [
      "Sit comfortably with eyes closed. Choose one body region (not breath — pick something else: hands, face, abdomen, feet).",
      "Place your entire attention on that region. Your only job is to notice sensations and name them, one by one, as they arise. Say the names silently.",
      "If a sensation is subtle, lean into it — approach with curiosity rather than effort. Forcing does not help.",
      "After 5 minutes, shift to a different body region for the remaining 5 minutes.",
      "Note after the session: did sensations that were initially absent begin to appear after 60–90 seconds of sustained attention? Record this in your journal.",
    ],
    safetySignals: [],
  ),

  PracticeContent(
    id: "P1C",
    name: "Focused Attention (Sensation Object)",
    phaseNumber: 1,
    scheduleSlot: "evening",
    durationMinutes: 15,
    skillIds: ["A1.1", "A1.2", "A1.3"],
    purpose: "Train volitional attention placement, the ability to distinguish chosen attention from pulled attention, and the recovery reflex — returning attention to the chosen object after a drift. The return is the training, not the staying.",
    steps: [
      "Sit with back upright. Choose a body sensation as your attention object — ideally breath at the nostrils (the slight coolness on inhale, warmth on exhale), but if that is not perceptible, use the rise and fall of the chest or the sensation of your hands resting on your thighs.",
      "Place your attention on that sensation. Stay with it. Your only task is to remain there.",
      "When you notice your attention has drifted — you have been thinking — note the content briefly (planning, memory, worry) and return to the sensation. The return is the training.",
      "Do not count drifts during the session — this interrupts recovery. Record the approximate total after.",
      "After the session, record: session duration, approximate number of drifts, longest continuous stretch without drift (in minutes), and whether attention was directed or pulled back each time.",
    ],
    safetySignals: [],
  ),

  PracticeContent(
    id: "P1D",
    name: "Primary Emotion Check-In",
    phaseNumber: 1,
    scheduleSlot: "triggered",
    durationMinutes: 2,
    skillIds: ["E1.1"],
    purpose: "Establish the habit of named emotional awareness three times per day and build baseline data about your emotional landscape. In Phase 1 the goal is the habit and the data, not accuracy.",
    steps: [
      "When the alarm sounds (set for morning, midday, and evening), stop what you are doing. Sit or stand still.",
      "Ask: What am I feeling right now? Name one primary emotional state from this list: fear, anger, sadness, joy, disgust, surprise, contempt. If you feel nothing discernible, note unclear.",
      "Do not analyze — just name. This is a 2-minute scan, not a therapy session.",
      "Write the result in your journal with the time, for example: 2:15pm — anger (mild).",
    ],
    safetySignals: [],
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // PHASE 2 — Emotional Literacy & Attentional Depth
  // ─────────────────────────────────────────────────────────────────────────

  PracticeContent(
    id: "P2A",
    name: "Physiological Journal",
    phaseNumber: 2,
    scheduleSlot: "morning",
    durationMinutes: 5,
    skillIds: ["S1.3"],
    purpose: "Build a personal neutral reference by recording four body systems each morning before any stimulation. After two weeks, deviations from your typical baseline become detectable — this is S1.3 (Baseline Awareness).",
    steps: [
      "Do not check your phone first. Lie still for 60 seconds.",
      "Open your journal and record across four body systems. Heart: is it fast, slow, moderate? Steady or irregular? Note a number if you can estimate. Breath: deep or shallow? Slow or fast? Any restriction in the chest or diaphragm? Gut: any tension, heaviness, emptiness, fluttering, nausea, or neutrality? Muscle baseline: any areas of obvious tension right now, before you have started moving?",
      "Note the overall arousal impression using the 0–10 scale: 0 = completely calm or flat, 3 = neutral or rested, 5 = alert or activated, 7 = tense or agitated, 10 = overwhelmed.",
    ],
    safetySignals: [],
  ),

  PracticeContent(
    id: "P2B",
    name: "Emotion-Body Map Construction",
    phaseNumber: 2,
    scheduleSlot: "evening",
    durationMinutes: 25,
    skillIds: ["E1.2"],
    purpose: "Build a personal dictionary linking each emotional state to its specific somatic signature in your body. Over weeks this map becomes a detection system — noticing a somatic signature lets you read the corresponding emotional state without working it out cognitively.",
    steps: [
      "Choose one emotion from your vocabulary list. Work through different emotions across sessions. Start with emotions you experience relatively frequently.",
      "Take 5 minutes to recall a specific memory when you felt this emotion moderately strongly — vivid enough to bring back some of the feeling, not so intense that it overwhelms. This is induction, not immersion.",
      "Once you have a mild version of the feeling present, turn your attention to your body. Run a quick body scan specifically looking for changes from your neutral baseline. Where is this emotion in your body? What does it feel like physically?",
      "Draw or write a body map entry for this emotion: name of emotion, body regions where you felt it, physical description of each region (use sensation language, not emotional language), intensity (0–10), how quickly did it come, and how quickly did it fade.",
      "At the end of the session, let the emotion settle. Do 2–3 slow breaths and briefly scan back to neutral.",
    ],
    safetySignals: [
      "Do not use memories of traumatic events for induction — use moderately strong memories only.",
      "If the induced emotional state becomes overwhelming (above 7/10), stop the induction, do slow breathing, and return to neutral before closing the session.",
    ],
  ),

  PracticeContent(
    id: "P2C",
    name: "Emotional Vocabulary Expansion",
    phaseNumber: 2,
    scheduleSlot: "evening",
    durationMinutes: 10,
    skillIds: ["E1.3"],
    purpose: "Increase emotional granularity — the precision with which you can name and distinguish emotional states. Granularity is the mechanism that enables accurate self-monitoring; vague naming produces vague detection.",
    steps: [
      "For the first two weeks, do Distinction Work: choose a pair of similar emotions (for example, anger and frustration; sadness and grief; anxiety and dread; embarrassment and shame). Spend 10 minutes writing the distinction between them — what is functionally different about how they operate, what triggers each, what each leads to, and how they feel differently in the body. Carve out conceptual space, not just definitions.",
      "Good pairs to work through: anger/frustration/irritation, sadness/grief/melancholy, anxiety/dread/apprehension/worry, shame/guilt/embarrassment, joy/delight/contentment, fear/alarm/panic, contempt/disgust/disdain, tenderness/affection/love, envy/jealousy, curiosity/interest/fascination.",
      "From week 3 onward, do Naming Specificity work: at the end of each day, review your emotion check-ins and ask — can I be more specific? Instead of anxious, can you say low-level dread about a specific outcome? Instead of irritated, was it frustrated with your own competence or irritated by unpredictability? Rewrite the check-in entries with greater granularity.",
    ],
    safetySignals: [],
  ),

  PracticeContent(
    id: "P2D",
    name: "Real-Time Gradient Log",
    phaseNumber: 2,
    scheduleSlot: "triggered",
    durationMinutes: 1,
    skillIds: ["E1.4"],
    purpose: "Train early detection of emotional shifts — catching states at intensity 1–4 before they become loud signals. A Level 2 entry is more valuable than a Level 7 entry because it trains the detection of subtle precursors such as the slight chest tightening that precedes full anxiety.",
    steps: [
      "Set up a system for quick capture: a small notebook, a notes app, or a voice memo.",
      "When you notice any emotional shift — any change from your morning baseline — capture it immediately.",
      "Record: emotion name (as specific as you can), intensity (0–10), time, and what preceded it (what you were doing or thinking).",
      "Review weekly: what proportion of entries are at intensity 1–4? By end of Phase 2, most entries should be at this level.",
    ],
    safetySignals: [],
  ),

  PracticeContent(
    id: "P2E",
    name: "Distraction Resistance",
    phaseNumber: 2,
    scheduleSlot: "midday",
    durationMinutes: 15,
    skillIds: ["A1.4"],
    purpose: "Train the ability to maintain chosen attentional focus in the presence of external distraction and mild emotional activation. The goal is not to be unaffected — it is to notice when the pull of distraction occurs and consciously choose whether to follow it or return.",
    steps: [
      "Same as Practice 1C (Focused Attention on Sensation Object), but done deliberately in the presence of distraction.",
      "Week 1–2: mild background noise (music, street noise).",
      "Week 3–4: more active distraction (a public space, a room with other people).",
      "Week 5 onward: while experiencing mild emotional activation (after a challenging interaction, when slightly stressed).",
      "After each session, record: environment type (quiet, mild noise, active space), number of distraction pulls (distinguish a pull you recognized and resisted from one you followed without noticing), and what types of stimuli pulled most.",
    ],
    safetySignals: [],
  ),

  PracticeContent(
    id: "P2F",
    name: "Aperture Shifting",
    phaseNumber: 2,
    scheduleSlot: "evening",
    durationMinutes: 10,
    skillIds: ["A1.5"],
    purpose: "Develop deliberate control over the width of the attentional field — the ability to move between narrow point focus and broad open awareness on demand. This aperture control is the foundation of A1.5 and supports Meta-Attention in later phases.",
    steps: [
      "Begin with Point Focus (2 minutes): place attention on a single, small sensation — the tip of your nose, one fingertip, or the spot between your eyebrows. Make the attentional object as small as possible. Nothing outside it.",
      "Gradual Expansion (3 minutes): slowly widen your attention outward — from the single point to your whole hand, then your whole arm, then your entire body, then include the space immediately around you. Move slowly, sensing at each level.",
      "Full Field (2 minutes): awareness is open — no single object is primary. Everything is equally present: body sensations, sounds, temperature, light. You are not looking at anything; you are receptive to everything.",
      "Gradual Contraction (3 minutes): slowly narrow back from full field to body, to one limb, to a single point.",
      "Record: can you hold the full field without a single element dominating and pulling focus? Can you hold point focus without the surrounding field bleeding in?",
    ],
    safetySignals: [],
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // PHASE 3 — Layer 1 to Layer 2 Bridge
  // ─────────────────────────────────────────────────────────────────────────

  PracticeContent(
    id: "P3A",
    name: "Meta-Attention Probes",
    phaseNumber: 3,
    scheduleSlot: "triggered",
    durationMinutes: 1,
    skillIds: ["A2.1"],
    purpose: "Begin training the ability to notice where attention is pointing — not the content of thought but the direction of the attentional spotlight. Develops the foundational A2.1 skill: noticing that you are in a thought rather than simply being in it.",
    steps: [
      "Set irregular alarms or use natural triggers (doorways, phone unlocks, beverage) 8–12 times per day.",
      "When the probe moment arrives, pause for 5 seconds and answer internally: Where is my attention right now?",
      "Do not ask what you are thinking about (content) — ask where the spotlight of attention is pointing. Possibilities: external task, another person, a problem, a memory, a future scenario, a body sensation, the environment, or genuinely unclear.",
      "Write the answer in your running log (1–3 words: planning tomorrow, physical pain, conversation replay).",
      "Over weeks, track whether the delay between probe and recognition is shortening. Early on you will have to quickly backtrack. Eventually you will sometimes notice in real time.",
    ],
    safetySignals: [],
  ),

  PracticeContent(
    id: "P3B",
    name: "Thought Observation Sit",
    phaseNumber: 3,
    scheduleSlot: "morning",
    durationMinutes: 20,
    skillIds: ["C2.1"],
    purpose: "Train the perceptual distinction between being inside a thought (identification) and watching a thought arise and pass (observation). This distinction is the core of C2.1 and does not feel significant in description — it emerges as a genuine perceptual shift with repetition.",
    steps: [
      "Sit comfortably, upright. Eyes closed.",
      "Your only task is to watch thoughts arise and pass. You are not trying to stop thoughts, modify them, analyze them, or judge them. You are watching them the way you watch clouds move.",
      "When a thought appears, notice it and — silently, internally — label it: I am having the thought that... and complete the sentence with whatever it is.",
      "Then let it go — not forced letting go, just not grabbing it. If a thought leaves naturally, fine. If it stays, continue labeling: I am still having the thought that...",
      "The moment you notice you have been inside a thought rather than watching it — lost in the content, merged with it — gently return to watching.",
      "After the session, record: how often were you watching versus merged? What types of thoughts were hardest to watch without getting pulled in? Any moments of clear observation — describe briefly.",
    ],
    safetySignals: [
      "If distressing thoughts surface and cannot be observed without significant activation, do not force continuation. Return to P1C (Focused Attention) as a stabilizing practice before resuming.",
    ],
  ),

  PracticeContent(
    id: "P3C",
    name: "Cognitive Mode Journal",
    phaseNumber: 3,
    scheduleSlot: "triggered",
    durationMinutes: 1,
    skillIds: ["C2.2"],
    purpose: "Build awareness of habitual cognitive modes — the characteristic ways your mind operates most of the time. Over weeks you will see your mode distribution, which is essential data for C2.3 (Process Monitoring) in Phase 4.",
    steps: [
      "Set 5 irregular alarms spaced through the day.",
      "When the alarm sounds, write: I was just in [mode].",
      "Modes to recognize: Analyzing (deliberate problem-solving, working through logic), Planning (arranging future events or scenarios), Ruminating (replaying past events, usually with emotional charge), Daydreaming (wandering, associative, no particular goal), Narratizing (constructing or rehearsing a story, often about self), Evaluating (judging self, others, situations), Observing (present-moment noticing with low narrative), Working (absorbed in task with minimal narrative), Reacting (responding to an emotional trigger in the moment), Unclear (genuinely unsure).",
      "Over weeks, notice your habitual distribution — most people have 2–3 dominant modes that account for the majority of their mental time.",
    ],
    safetySignals: [],
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // PHASE 4 — Metacognitive Core
  // ─────────────────────────────────────────────────────────────────────────

  PracticeContent(
    id: "P4A",
    name: "Process Awareness Journal",
    phaseNumber: 4,
    scheduleSlot: "evening",
    durationMinutes: 15,
    skillIds: ["C2.3"],
    purpose: "Develop awareness of how you think, not what you think. By reviewing a period of cognitive activity for shortcuts, backward reasoning, and unexamined assumptions, you build C2.3 — the capacity to monitor the quality of your own reasoning process.",
    steps: [
      "Review a period of cognitive activity from today — a decision, a conversation, a piece of work, or a planning session.",
      "Ask: What mode was I in? (Use C2.2 vocabulary.)",
      "Ask: What shortcuts did I take? What did I assume without checking?",
      "Ask: Was I reasoning forward (from evidence to conclusion) or backward (from preferred conclusion to supporting evidence)?",
      "Ask: What would I have had to think more carefully to actually know, rather than assume?",
      "Write 3–5 sentences. Specific is more valuable than general. Note: if you find recurring shortcuts or particular types of reasoning collapse, these are C2.3 data and will become P3.1 material in Phase 8.",
    ],
    safetySignals: [],
  ),

  PracticeContent(
    id: "P4B",
    name: "Cognitive Load Checks",
    phaseNumber: 4,
    scheduleSlot: "triggered",
    durationMinutes: 1,
    skillIds: ["C2.4"],
    purpose: "Develop the ability to accurately assess current cognitive capacity before performing demanding work. Stress, fatigue, and emotional load deplete the PFC; a depleted processor believing it is at full capacity produces subtly unreliable outputs.",
    steps: [
      "Before beginning a demanding task, rate your current cognitive capacity on a 1–5 scale: 1 = severely depleted (post-major stress, very tired, ill), 2 = low (tired, distracted, post-emotionally taxing event), 3 = baseline (normal functional state), 4 = alert (rested, focused, good conditions), 5 = peak (highly rested, motivated, optimal conditions).",
      "Carry out the task.",
      "Afterward, note whether your actual performance felt consistent with your pre-task capacity estimate.",
      "Run this check three times per day: before a demanding task, at a midpoint, and at end of workday.",
    ],
    safetySignals: [],
  ),

  PracticeContent(
    id: "P4C",
    name: "Assumption Log",
    phaseNumber: 4,
    scheduleSlot: "evening",
    durationMinutes: 10,
    skillIds: ["C2.5"],
    purpose: "Train the ability to distinguish observations from inferences, and to detect where missing information has been filled in with default assumptions. Once you start catching assumptions retrospectively, the skill generalizes to real-time catches during events.",
    steps: [
      "Review your day. Find 1–3 moments where you treated an inference as an observation (I saw that she was annoyed — did you observe annoyance directly, or infer it from behavior?), skipped a step in reasoning without noticing (Obviously X leads to Y — what is the actual mechanism?), or filled in missing information with a default assumption (He did not respond, so he must be ignoring me).",
      "For each: write what the assumption was, what you actually had evidence for, and what you would need to actually know rather than infer.",
    ],
    safetySignals: [],
  ),

  PracticeContent(
    id: "P4D",
    name: "Narrative Catch Practice",
    phaseNumber: 4,
    scheduleSlot: "triggered",
    durationMinutes: 1,
    skillIds: ["C2.6"],
    purpose: "Train real-time detection of self-coherent meaning sequences — narratives that feel like reality but are constructed. Noticing a narrative as a narrative interrupts its automatic influence on behavior and belief.",
    steps: [
      "Throughout the day, practice noticing when a narrative starts. The signal is a distinctive feeling of coherence or inevitability about a sequence of thoughts — as if a story has taken over.",
      "When you notice it, say internally: I am telling myself a story about [X].",
      "Do not stop the story, analyze it, or decide if it is true. Just name it as a story. That is the entire practice.",
      "Record in your journal each narrative catch: the theme and the time of day. Patterns will emerge over weeks — certain contexts generate more narrative than others.",
    ],
    safetySignals: [],
  ),

  PracticeContent(
    id: "P4E",
    name: "Emotion Source Log",
    phaseNumber: 4,
    scheduleSlot: "triggered",
    durationMinutes: 2,
    skillIds: ["E2.1"],
    purpose: "Develop the ability to attribute emotional states to their origins — internal (memory, belief, anticipation, thought pattern) versus external (environmental trigger, social interaction, media exposure) versus mixed. Ambiguous attributions are important data — they are precisely where influence operates most easily.",
    steps: [
      "When you notice a significant emotional state (above 4/10 — using E1.4 gradient detection), add a source attribution.",
      "Classify the source as: Internal (arising from a memory, belief, anticipation, or ongoing thought pattern), External (arising primarily from an environmental trigger, social interaction, or media exposure), or Mixed (clear elements of both).",
      "Then briefly: what specifically seems to be the source?",
      "Example entry: 3:30pm — anxiety (6/10) — source: internal — specifically: anticipating a difficult conversation tomorrow.",
    ],
    safetySignals: [],
  ),

  PracticeContent(
    id: "P4F",
    name: "Contagion Audit",
    phaseNumber: 4,
    scheduleSlot: "evening",
    durationMinutes: 15,
    skillIds: ["E2.2"],
    purpose: "Develop a map of your personal emotional contagion vulnerabilities — the specific people, content types, and social environments that reliably shift your state. Over weeks this map develops into predictive capacity (E2.2 threshold).",
    steps: [
      "Once per week (Sunday evening or equivalent), review the past week.",
      "Identify 1–3 moments when your emotional state shifted in a way that, on reflection, seems to have originated from another person, a media environment, or a social situation rather than from your own internal processing.",
      "For each instance, record: what was the source (specific person, content type, environment), what emotion was transferred and at what intensity, were you aware of the shift as it was happening or only retrospectively, and what would have helped you notice earlier.",
    ],
    safetySignals: [],
  ),

  PracticeContent(
    id: "P4G",
    name: "Decision Review",
    phaseNumber: 4,
    scheduleSlot: "evening",
    durationMinutes: 10,
    skillIds: ["E2.3"],
    purpose: "Train the ability to see the emotional conditions under which conclusions are reached — affect-cognition coupling. The goal is not to invalidate conclusions but to see the emotional weather through which you reasoned, rather than treating conclusions as if reached in a vacuum.",
    steps: [
      "Choose one decision or conclusion you reached this week.",
      "Review it specifically for affect-cognition coupling: What was your emotional state when you reached this conclusion?",
      "Ask: how might that emotional state have shaped the conclusion? What would you have concluded in a different emotional state?",
      "Can you identify the coupling pattern by name? Common patterns: catastrophizing, motivated reasoning, availability bias under fear, positivity bias under joy, anger-activated approach bias, sadness-activated loss focus.",
      "Do this 3 times per week (for example, Tuesday, Thursday, Saturday evenings).",
    ],
    safetySignals: [],
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // PHASE 5 — Self-Boundary & Dual Presence
  // ─────────────────────────────────────────────────────────────────────────

  PracticeContent(
    id: "P5A",
    name: "Values Document Construction",
    phaseNumber: 5,
    scheduleSlot: "morning",
    durationMinutes: 50,
    skillIds: ["B2.2", "B2.3"],
    purpose: "Create a behavioral reference document that describes who you actually are and what you actually care about — not aspirations. This document becomes the detection standard for B2.2 (Incongruence Detection) and the anchor for B2.3 (Value Anchoring Under Pressure).",
    steps: [
      "This is a one-time construction session (40–60 minutes) with regular updates thereafter.",
      "Write Section 1 — Core Values (3–7): each as a single behavioral sentence. Not integrity but: When I tell someone I will do something, I keep my word even when it is inconvenient. Specific and behavioral.",
      "Write Section 2 — Non-Negotiables (3–5): things you will not do regardless of circumstance. Specific. I do not deceive people to avoid conflict, not I am honest.",
      "Write Section 3 — Characteristic Responses: how do you typically respond to criticism of your work, requests that ask too much of you, situations where you have more information than others, and loss? Write 2–3 sentences each.",
      "Write Section 4 — What Operating Against Your Values Feels Like: somatically. What does your body do when you are about to violate a core value? Many people report a specific physical signal — a constriction, a hollow feeling, a reluctance in the chest. If you do not know yet, leave this and return as E1.2 and E2.1 develop further.",
      "Date the document and save it. Update it deliberately — never passively drift it.",
    ],
    safetySignals: [],
  ),

  PracticeContent(
    id: "P5B",
    name: "Self-Description Baseline + Weekly Reviews",
    phaseNumber: 5,
    scheduleSlot: "evening",
    durationMinutes: 35,
    skillIds: ["B2.4"],
    purpose: "Create a dated, honest baseline description of your current self that serves as a reference against which drift is measured over time. Drift is only visible longitudinally — the document is what makes it detectable.",
    steps: [
      "This is a one-time construction session (30–45 minutes): write a description of who you currently are — not who you want to be, not your history. Your current self.",
      "Cover: how you currently think (habitual modes from C2.2 and C2.3 work), what you currently care about, how you currently relate to others, what currently characterizes your internal landscape (anxiety-prone, quiet, cynical, curious, defended), and what you notice about yourself through the Layer 1–3 work so far.",
      "This document should feel slightly uncomfortable — a genuinely honest self-description always does. If it does not, you are writing an idealized version.",
      "Date and sign it.",
      "Once per week thereafter, open it, read it, and spend 5 minutes answering: Am I still this person, or has something shifted? Document your observations.",
    ],
    safetySignals: [],
  ),

  PracticeContent(
    id: "P5C",
    name: "Dual Presence Training",
    phaseNumber: 5,
    scheduleSlot: "morning",
    durationMinutes: 20,
    skillIds: ["A2.2"],
    purpose: "Train the ability to maintain continuous background awareness of internal state while simultaneously engaged in a foreground activity. This is A2.2 — the monitoring layer that makes real-time self-regulation possible during ordinary life.",
    steps: [
      "Choose a daily activity: reading, cooking, exercise, a conversation, commuting.",
      "While engaged in the activity normally, maintain a background layer of awareness of your internal state. You are not pausing the activity to check in — you are running both simultaneously.",
      "The internal monitoring tracks: current emotional tone (gradient log level), body arousal level (S1.4), and attentional quality (are you present or drifted?).",
      "Week 1–2: start with low-demand activities (walking, eating). Week 3–4: reading. Week 5 onward: working, conversations.",
      "The training test: when the activity ends, you should be able to give a running account of how your internal state changed during the activity without having had to stop the activity to check. If you cannot, the monitoring was not continuous — it was periodic.",
    ],
    safetySignals: [],
  ),

  PracticeContent(
    id: "P5D",
    name: "Boundary Challenge Practice",
    phaseNumber: 5,
    scheduleSlot: "morning",
    durationMinutes: 30,
    skillIds: ["B2.1"],
    purpose: "Develop B2.1 (self-other signal distinction) and B2.3 (value anchoring under pressure) through graduated exposure to influence conditions — media designed to elicit responses, social pressure, and sustained perspective exposure.",
    steps: [
      "This is a weekly structured session (30 minutes, once per week).",
      "Week 1–2 — Media Exposure Scenarios: watch or read content specifically designed to elicit a strong emotional or opinion response (political content, advertising, emotionally charged editorial). While consuming it, track emotional state changes in real time (Gradient Log) and note when the content seems to be shaping what feels true or right. After: attribute each emotional shift — internal or contagion? Did your views shift? Does that shift feel like yours?",
      "Week 3–4 — Social Pressure Scenarios: recall or enter a situation where someone is exerting social pressure. Consciously notice when your stated position begins to drift from your actual position, notice the somatic signal that accompanies the pressure, and practice returning to values alignment — notice how that feels physically different from compliance.",
      "Week 5–6 — Sustained Perspective Exposure: spend 15 minutes consuming a coherent perspective you find somewhat uncomfortable. After: do you still hold your previous position? If it changed, can you articulate why using your own reasoning versus it just feels different now? Is the new feeling of convincingness coming from evidence or from repeated exposure?",
      "Record after each session: what shifted, what held, and what somatic signals were present.",
    ],
    safetySignals: [
      "Do not use content that is likely to produce genuine traumatic activation. Uncomfortable is appropriate; overwhelming is not.",
    ],
  ),

  PracticeContent(
    id: "P5E",
    name: "Load-Condition Practice",
    phaseNumber: 5,
    scheduleSlot: "triggered",
    durationMinutes: 20,
    skillIds: ["I1.1", "A2.1", "A2.2", "C2.1", "C2.6", "B2.1", "B2.3"],
    purpose: "Assess and train the stability of all six core monitoring skills under conditions of genuine cognitive or emotional load. Builds I1.1 baseline data by measuring quality ratios (load quality divided by rested quality) across different load types.",
    steps: [
      "Do this practice when you are already moderately loaded: after a cognitively demanding work session, during mild emotional activation (following a difficult interaction), or under mild time pressure.",
      "Step 1 — Meta-attention (5 min, A2.1): can you notice where your attention is right now? Probe 3 times at random moments in this window. Record accuracy.",
      "Step 2 — Thought observation (3 min, C2.1): can you watch thoughts arise without merging with their content? Label 3 thoughts as events (I had the thought...). Record whether you caught identification or not.",
      "Step 3 — Narrative awareness (2 min, C2.6): is there a running story operating right now? Name it if present. Simply naming counts.",
      "Step 4 — Source distinction (2 min, B2.1): is your current emotional or cognitive state internally generated, or being driven by the external load context? Record your judgment.",
      "Step 5 — Dual presence check (2 min, A2.2): can you maintain background awareness of your internal state while still engaged with the task context? Rate quality 0–10.",
      "Step 6 — Values check (2 min, B2.3): can you locate your values alignment right now? Does your current orientation match your stated values? Record yes/no and any tension noticed.",
      "Step 7 — Log (4 min): record quality ratios for all six skills (load quality divided by rested quality, estimated). This is your I1.1 baseline data.",
    ],
    safetySignals: [
      "Do not run this practice during genuine crisis-level load. Mild-to-moderate load only — enough to create friction, not so much that the monitoring itself is impossible.",
    ],
  ),

  PracticeContent(
    id: "P5F",
    name: "Recovery Time Log",
    phaseNumber: 5,
    scheduleSlot: "triggered",
    durationMinutes: 1,
    skillIds: ["I1.2"],
    purpose: "Build a personal recovery curve by measuring how quickly monitoring quality returns to pre-disruption baseline after significant emotional or cognitive disruptions. This is the measurement component of I1.2.",
    steps: [
      "Immediately after a disruptive event (argument, stress event, bad news, intense emotional experience), note the time and your current monitoring quality on a 0–10 scale: 0 = monitoring completely offline, 5 = partially functional, 10 = fully functional.",
      "Check again at 5 minutes, 10 minutes, 15 minutes, 30 minutes, and 60 minutes. Record quality at each point.",
      "Recovery = the point where you reach your pre-disruption monitoring quality for the first time. Note the clock time.",
      "Over weeks of data, you will see your typical recovery time and whether it is improving. This is I1.2 Track B evidence.",
    ],
    safetySignals: [],
  ),

  PracticeContent(
    id: "P5G",
    name: "Incongruence Detection Drill",
    phaseNumber: 5,
    scheduleSlot: "evening",
    durationMinutes: 5,
    skillIds: ["B2.2"],
    purpose: "Train the real-time retrieval and comparison process that constitutes B2.2 — detecting when a thought, impulse, or felt pull is in tension with a stated value. The Values Document provides the reference standard; this practice develops the detection habit.",
    steps: [
      "Prerequisites: the Values Document (P5A) must be written and contain at least 5 specific behavioral values before this practice begins.",
      "Each evening, review three notable thoughts, impulses, or felt pulls from the day.",
      "For each one: state it explicitly (I was pulled toward..., I thought..., I felt the impulse to...), hold your Values Document in mind, and ask: is this thought/impulse/feeling aligned with a stated value, neutral, or in tension with one?",
      "If in tension: name the specific value being contradicted and describe the tension in one sentence. Do not resolve it — just detect and name it.",
      "Rate your confidence in the detection: certain, probable, or uncertain.",
      "Record: three detection attempts each session, flag rate (what proportion showed tension), and confidence level.",
    ],
    safetySignals: [
      "Do not confuse values tension with mere preference violation. Values tension involves a genuine conflict with a deeply held value, not just doing something you slightly prefer not to do.",
    ],
  ),

  PracticeContent(
    id: "P5H",
    name: "Recovery Speed Training",
    phaseNumber: 5,
    scheduleSlot: "triggered",
    durationMinutes: 10,
    skillIds: ["I1.2"],
    purpose: "Actively train the recovery sequence — parasympathetic reactivation followed by PFC re-engagement followed by monitoring baseline recalibration — as a deliberate skill rather than an emergent process. Complements P5F which only measures.",
    steps: [
      "Do this practice 3 times per week, after a naturally occurring disruption or using the deliberate induction below.",
      "After a natural disruption: note your current state — rate monitoring quality 0–10 and note what is offline (attention, somatic tracking, value awareness).",
      "Apply deliberate parasympathetic activation: 4-second inhale, 7-second hold, 8-second exhale, times 3 cycles. Do not rush.",
      "Check state again. What has returned? Rate 0–10.",
      "Deliberately re-engage one monitoring skill at a time: first somatic tracking, then attention, then thought observation. Notice the sequence.",
      "Record time to baseline and which sequence worked.",
      "Deliberate induction option (for practice weeks with no natural disruptions): vividly recall a mildly frustrating or activating event from the past 48 hours. Spend 2 minutes replaying it with full sensory detail until you notice a genuine shift in your internal state. Then immediately apply the parasympathetic activation and re-engagement steps above.",
    ],
    safetySignals: [
      "For deliberate induction, use only mildly activating memories (3–5/10 intensity). Do not use highly distressing memories for induction.",
    ],
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // PHASE 7 — State Modulation
  // ─────────────────────────────────────────────────────────────────────────

  PracticeContent(
    id: "P7A",
    name: "Voluntary Relaxation Protocol",
    phaseNumber: 7,
    scheduleSlot: "morning",
    durationMinutes: 20,
    skillIds: ["M3.1"],
    requiresHrMonitor: false,
    qualityRatedPhase7Plus: true,
    purpose: "Develop M3.1 — the ability to deliberately downregulate physiological arousal on demand. Unlike Phase 1 body scan, this practice makes a deliberate change rather than just observing. Threshold requires consistent arousal reduction of at least 2 subjective points and 5 bpm HR reduction.",
    steps: [
      "Choose one relaxation method and work with the same method for at least 2 weeks before switching.",
      "Method A — Progressive Somatic Release: systematically move attention through body regions (as in Body Scan), but at each region, invite the muscles to release tension — not force, invite. Stay 30 seconds per region. You are making a deliberate change, not just observing.",
      "Method B — Breath Regulation: slow exhale-extended breathing — inhale for 4 counts, exhale for 6–8 counts. The extended exhale activates the parasympathetic nervous system directly. Repeat for 10 minutes, then allow breathing to normalize while maintaining body observation for 10 more minutes.",
      "Method C — Physiological Sigh: double inhale (quick inhale through nose, then second inhale to fully top off lungs), followed by slow complete exhale through the mouth. Repeat 3 times. Then sit quietly for 15 minutes with normal breathing and body observation.",
      "Track B measurement: before beginning, rate arousal (0–10) and measure HR. After completing, rate arousal and measure HR again. Threshold = subjective reduction of at least 2 points and HR reduction of at least 5 bpm, consistently across at least 8 sessions.",
      "Do not always practice in the same place — vary the context across sessions.",
    ],
    safetySignals: [],
  ),

  PracticeContent(
    id: "P7B",
    name: "State Shifting Protocol",
    phaseNumber: 7,
    scheduleSlot: "evening",
    durationMinutes: 20,
    skillIds: ["M3.2"],
    qualityRatedPhase7Plus: true,
    purpose: "Develop M3.2 — the ability to deliberately shift between defined internal states and hold each state for a sustained period. Threshold requires shifting between 3 defined states within 5 minutes and sustaining each for 10 minutes with verbal report matching somatic signature.",
    steps: [
      "First, define your 3 target states clearly. Use the cognitive mode vocabulary and somatic signatures you have developed. Good starter states: Alert-focused (high attentional engagement, low narrative, mild arousal, ECN-dominant), Open-curious (broad aperture, low judgment, medium arousal, receptive), Calm-stable (low arousal, low narrative, grounded body awareness, wide slow breath).",
      "For each state, write a description: the somatic signature, the cognitive mode, the breath quality, and a memory or context where you naturally inhabited this state.",
      "Practice step 1: spend 5 minutes in your current state as-is — just observe it clearly. Name what state you are in.",
      "Practice step 2: choose a target state. Shift to it using any available means (breath, attention, body posture, recalled memory).",
      "Practice step 3: hold for 5 minutes. During this time, continuously verify you are actually in the target state — not just thinking about it.",
      "Practice step 4: shift to a second target state. Hold for 5 minutes.",
      "Practice step 5: return to your natural baseline state.",
      "Record: shift time (how long to enter target state), hold quality (did it drift?), and somatic markers confirming you were in the target state versus just thinking about it.",
    ],
    safetySignals: [],
  ),

  PracticeContent(
    id: "P7C",
    name: "Pre-Task Arousal Calibration",
    phaseNumber: 7,
    scheduleSlot: "triggered",
    durationMinutes: 3,
    skillIds: ["M3.3"],
    qualityRatedPhase7Plus: true,
    purpose: "Develop M3.3 — the ability to match arousal level to task demands before beginning. Different tasks are optimized at different arousal levels; running every task at whatever arousal you happen to have degrades performance across the range.",
    steps: [
      "Before a significant cognitive or emotional demand (meeting, creative work, difficult conversation, high-stakes decision), check current arousal using S1.4. Rate 0–10.",
      "Ask: what arousal level would optimize this task? High-stakes detail work benefits from moderate or low arousal; creative exploration benefits from moderate; physical performance from moderate or high; complex emotional conversation from moderate.",
      "If you are over the target: use a brief voluntary relaxation (3 deep slow exhales, body scan, 60 seconds).",
      "If you are under the target: brief activation (faster breathing, mild physical movement, recall a motivating context).",
      "Proceed.",
      "Log: pre-task estimate, target arousal, and after the task your assessment of whether you were actually calibrated correctly. Error rate should decrease over weeks.",
    ],
    safetySignals: [],
  ),

  PracticeContent(
    id: "P7D",
    name: "Emotion Modification Practice",
    phaseNumber: 7,
    scheduleSlot: "evening",
    durationMinutes: 20,
    skillIds: ["M3.4"],
    qualityRatedPhase7Plus: true,
    purpose: "Develop M3.4 — the ability to deliberately modify the intensity and duration of an emotional state without eliminating its signal. Key distinction: an emotion modified from 7 to 3 is success; an emotion that drops to 0 with somatic signature absent should be examined as potential suppression.",
    steps: [
      "This practice is done 3 times per week and requires an emotional state to work with. Use a recent memory with mild induction (intensity 3–5/10) or work with a currently present state if one is available.",
      "Apply E1.4 and E2.1 first: identify the emotion, its intensity, its somatic signature, and its source.",
      "Apply a modification. Options — Reappraisal: reinterpret the meaning of the situation. What is a genuine alternative meaning that the facts equally support? Perspective Shift: view the situation from outside yourself. What would a neutral observer see? Somatic De-escalation: using M3.1 breathing, invite the body to reduce the physiological component of the emotion.",
      "After the modification, check the somatic signature. Is it reduced? Is it still present? It should be — fully absent means suppression, not modification.",
      "Rate intensity before and after.",
    ],
    safetySignals: [
      "Do not use memories above 5/10 intensity for induction. Use mild to moderate material only.",
      "If the somatic signature disappears entirely, pause and examine whether suppression rather than modification has occurred before continuing.",
    ],
  ),

  PracticeContent(
    id: "P7E",
    name: "Practice Quality Assessment",
    phaseNumber: 7,
    scheduleSlot: "evening",
    durationMinutes: 5,
    skillIds: ["I1.4"],
    qualityRatedPhase7Plus: true,
    purpose: "Develop I1.4 — the ability to assess and adjust the quality conditions for genuine neural plasticity in every session. Research on behavioral relevance shows the brain does not consolidate practice that feels trivial or runs on automatic. Applied after every Phase 7 and Phase 8 session.",
    steps: [
      "After each formal practice session in Phase 7 or Phase 8, rate it against 4 quality criteria, each on a 1–5 scale.",
      "Criterion 1 — Behavioral Relevance: did this practice feel genuinely meaningful — connected to something that matters to you? (1 = going through motions, 5 = fully invested).",
      "Criterion 2 — Appropriate Challenge: were you working at a level where you were engaged but not overwhelmed? (1 = too easy or automatic, 5 = too hard or flooded; target is 3–4).",
      "Criterion 3 — Contextual Variety: were you practicing in a varied context today versus repeating the same setting? (1 = always same chair, time, and setting; 5 = genuinely new context).",
      "Criterion 4 — Intentional Engagement: were you actively present for the practice or running on autopilot? (1 = mechanical execution, 5 = fully engaged).",
      "Record the four scores and the total. If total is below 12, identify which criteria are dragging it down and make a deliberate adjustment next session. The adjustment itself is the I1.4 skill.",
    ],
    safetySignals: [],
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // PHASE 8 — Pattern Work
  // ─────────────────────────────────────────────────────────────────────────

  PracticeContent(
    id: "P8A",
    name: "Pattern Documentation",
    phaseNumber: 8,
    scheduleSlot: "evening",
    durationMinutes: 10,
    skillIds: ["P3.1"],
    qualityRatedPhase7Plus: true,
    purpose: "Build a Pattern Library — a structured catalogue of your recurring cognitive-emotional patterns with triggers, sequences, somatic signatures, and contexts. The library enables predictive accuracy: knowing when a pattern will appear before it completes.",
    steps: [
      "Each evening, write or update Pattern Library entries using this format for each new pattern you notice.",
      "Pattern name: give it a short name you can recognize, for example: the competence doubt spiral, the pre-conflict withdrawal.",
      "Trigger: what reliably precedes the pattern.",
      "Sequence: what happens in order (emotion, then thought, then behavior tendency).",
      "Somatic signature: what it feels like in the body.",
      "Context: where and when does it appear most?",
      "First observed: date.",
      "Review your Pattern Library monthly — old patterns may shift, new entries may be refinements of existing ones.",
      "Predictive accuracy practice: once you have at least 3 patterns documented, begin predicting when each will appear. Before entering a known trigger context, note in your journal: I predict Pattern X will appear. Check afterward.",
    ],
    safetySignals: [],
  ),

  PracticeContent(
    id: "P8B",
    name: "Pattern Interruption Protocol",
    phaseNumber: 8,
    scheduleSlot: "triggered",
    durationMinutes: 1,
    skillIds: ["P3.2"],
    qualityRatedPhase7Plus: true,
    purpose: "Develop P3.2 — the ability to detect a pattern at its earliest point and interrupt its automatic completion. The goal is not suppression of the pattern content but refusal to let it run automatically to completion.",
    steps: [
      "For each pattern in your Pattern Library, designate the earliest detectable point: what is the earliest signal that the pattern has started? A somatic shift, a particular thought type, or a behavioral tendency?",
      "Designate the interruption action: a specific, pre-decided action you will take when you notice the early signal. It should be brief (5–15 seconds), physically distinct from the pattern behavior, feasible in the context where the pattern appears, and not suppressive.",
      "Examples of interruption actions: pause, take one deliberate breath, name the pattern out loud to yourself (That is the competence doubt spiral); change physical position (stand if sitting, shift posture); direct attention deliberately to a body sensation for 10 seconds before continuing; write the pattern name in your journal and the trigger context.",
      "Record after each attempt: pattern name, trigger, whether interruption was attempted, and whether it succeeded (pattern did not complete) or failed (pattern completed despite attempt). Track success rate over time.",
    ],
    safetySignals: [],
  ),

  PracticeContent(
    id: "P8C",
    name: "Reframing Exercise",
    phaseNumber: 8,
    scheduleSlot: "evening",
    durationMinutes: 20,
    skillIds: ["P3.3"],
    qualityRatedPhase7Plus: true,
    purpose: "Develop P3.3 — the ability to generate genuine alternative framings of beliefs and narratives rather than simply the opposite or most comfortable reframe. Requires the B2.2 (Incongruence Detection) skill from Phase 5 to distinguish genuine from motivated reframing.",
    steps: [
      "Choose one belief, narrative, or meaning structure you hold — preferably one that appears in your Pattern Library or has been flagged in your Process Journal.",
      "State it clearly: I believe / I tell myself / The story I hold is: [X].",
      "Generate 3 alternative framings that are: equally consistent with the available evidence, not simply the opposite (optimistic reframe is not the goal — genuine alternatives are), and genuinely different in their implications.",
      "For each alternative: write what would be true about your situation, your choices, and the future if this framing were accurate instead.",
      "Then return to your original framing. Does it still feel as inevitable? Has your relationship to it changed?",
      "Crucial self-check: ask after every reframing session — am I doing genuine reframing or motivated reframing? Genuine reframing involves holding uncertainty about which frame is more accurate. Motivated reframing selects the most comfortable frame.",
    ],
    safetySignals: [],
  ),

  PracticeContent(
    id: "P8D",
    name: "Topology Map Sessions",
    phaseNumber: 8,
    scheduleSlot: "evening",
    durationMinutes: 40,
    skillIds: ["P3.4"],
    qualityRatedPhase7Plus: true,
    purpose: "Build and maintain a living model of your cognitive-emotional architecture — a network of beliefs, patterns, habitual responses, core values, and recurring concerns, with connections showing how they reinforce and trigger each other. The map is a working hypothesis updated indefinitely.",
    steps: [
      "This is a weekly session (40 minutes, once per week).",
      "The topology map is a living document built from Pattern Library entries, Reframing work, Process Journal patterns, and Assumption Log patterns.",
      "Structure: draw or write a network showing Nodes (significant beliefs, emotional patterns, habitual responses, core values, recurring concerns), Connections (how nodes reinforce or trigger each other: when I feel X, it triggers Y; this belief makes Z feel inevitable), and High-traffic clusters (areas of the network with many connections — likely key leverage points for change).",
      "Each week: review the existing map, add anything new from the week, note any connections between existing nodes you had not previously seen, and identify 1–3 nodes you think are most influencing current behavior or experience.",
      "The topology map is a working hypothesis, not a truth. Its accuracy depends on the quality of the monitoring skills underneath it.",
    ],
    safetySignals: [],
  ),

  PracticeContent(
    id: "P8E",
    name: "Directed Practice Cycle",
    phaseNumber: 8,
    scheduleSlot: "morning",
    durationMinutes: 20,
    skillIds: ["P3.5"],
    qualityRatedPhase7Plus: true,
    purpose: "Develop P3.5 — the ability to design and execute a deliberate change cycle targeting a specific pattern identified in the topology map. Each cycle integrates behavioral relevance, appropriate challenge, contextual variety, and I1.4 quality monitoring.",
    steps: [
      "Begin each cycle with a 60-minute design session.",
      "Design step 1 — Select a target: identify a specific pattern from your topology map that you want to change. Be specific: not I want to worry less but I want to interrupt the anticipatory threat-scanning pattern that runs every morning.",
      "Design step 2 — Define the desired outcome: what would replace the current pattern? Be concrete.",
      "Design step 3 — Design the practice: what specific cognitive, emotional, or behavioral repetition would build the replacement pattern? The practice must be directly relevant to the target (behavioral relevance gate), at an appropriate challenge level (not too easy, not overwhelming), varied across contexts (to prevent context-specificity), and integrated with I1.4 quality monitoring.",
      "Design step 4 — Set the duration: minimum 6 weeks of daily 20-minute sessions.",
      "Design step 5 — Define pre/post measures: how will you know if the pattern has changed? Frequency counts in Pattern Library, predictive accuracy shifts, or somatic signature intensity changes?",
      "Execute the cycle for at least 6 weeks. After 6 weeks, assess the pre/post measures and document the results. Then either continue the cycle (if change is partial) or begin a new cycle on a different target.",
    ],
    safetySignals: [
      "Do not target patterns connected to significant trauma without clinical support. Pattern Work at this level can surface material that requires professional context to work with safely.",
    ],
  ),
];

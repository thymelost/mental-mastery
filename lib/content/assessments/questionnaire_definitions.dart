import 'assessment_model.dart';

/// Questionnaire item definitions for validated instruments.
///
/// Sources:
///   TAS-20: Bagby, Parker & Taylor (1994). *J Psychosomatic Research, 38*(1).
///   PHQ-9:  Kroenke, Spitzer & Williams (2001). Freely available; Pfizer released rights.
///   DASS-21: Lovibond & Lovibond (1995). Psychology Foundation of Australia.
///   FFMQ Observing: Baer et al. (2006). *Assessment, 13*(1). Subscale items 1,6,11,15,20,26,31,36.
///
/// SMS-Mind and RRS are administered externally; scores are entered by the user.

// ─── TAS-20 ───────────────────────────────────────────────────────────────────

const kTas20Definition = QuestionnaireDefinition(
  instruction:
      'Using the scale below, please indicate how much you agree or disagree '
      'with each of the following statements.',
  scaleLabels: [
    'Strongly\nDisagree',
    'Disagree',
    'Neither',
    'Agree',
    'Strongly\nAgree',
  ],
  reverseMax: 6,
  subscales: {
    'DIF (Difficulty Identifying Feelings)': [1, 3, 6, 7, 9, 13, 14],
    'DDF (Difficulty Describing Feelings)': [2, 4, 11, 12, 17],
    'EOT (Externally Oriented Thinking)': [5, 8, 10, 15, 16, 18, 19, 20],
  },
  scoringNotes:
      '≤ 51 → Standard track  |  52–60 → Extended track  |  > 61 → Priority track.\n'
      'Subscale DIF ≥ 16, DDF ≥ 9, or EOT ≥ 15 indicates clinically significant difficulty in that facet.',
  items: [
    QuestionnaireItem(text: 'I am often confused about what emotion I am feeling.'),
    QuestionnaireItem(text: 'It is difficult for me to find the right words for my feelings.'),
    QuestionnaireItem(text: 'I have physical sensations that even doctors don\'t understand.'),
    QuestionnaireItem(text: 'I am able to describe my feelings easily.', reversed: true),
    QuestionnaireItem(text: 'I prefer to analyze problems rather than just describe them.', reversed: true),
    QuestionnaireItem(text: 'When I am upset, I don\'t know if I am sad, frightened, or angry.'),
    QuestionnaireItem(text: 'I am often puzzled by sensations in my body.'),
    QuestionnaireItem(text: 'I prefer to just let things happen rather than to understand why they turned out that way.'),
    QuestionnaireItem(text: 'I have feelings that I can\'t quite identify.'),
    QuestionnaireItem(text: 'Being in touch with emotions is essential.', reversed: true),
    QuestionnaireItem(text: 'I find it hard to describe how I feel about people.'),
    QuestionnaireItem(text: 'People tell me to describe my feelings more.'),
    QuestionnaireItem(text: 'I don\'t know what\'s going on inside me.'),
    QuestionnaireItem(text: 'I often don\'t know why I am angry.'),
    QuestionnaireItem(text: 'I prefer talking to people about their daily activities rather than their feelings.'),
    QuestionnaireItem(text: 'I prefer to watch "light" entertainment shows rather than psychological dramas.'),
    QuestionnaireItem(text: 'It is difficult for me to reveal my innermost feelings, even to close friends.'),
    QuestionnaireItem(text: 'I can feel close to someone, even in moments of silence.', reversed: true),
    QuestionnaireItem(text: 'I find examination of my feelings useful in solving personal problems.', reversed: true),
    QuestionnaireItem(text: 'Looking for hidden meanings in movies or plays distracts from their enjoyment.'),
  ],
);

// ─── PHQ-9 ────────────────────────────────────────────────────────────────────

const kPhq9Definition = QuestionnaireDefinition(
  instruction:
      'Over the last 2 weeks, how often have you been bothered by '
      'any of the following problems?',
  scaleLabels: [
    'Not\nat all',
    'Several\ndays',
    'More than\nhalf the days',
    'Nearly\nevery day',
  ],
  scoringNotes:
      '0–4 Minimal  |  5–9 Mild  |  10–14 Moderate  |  15–19 Moderately severe  |  20–27 Severe.\n'
      'Score ≥ 15 at any point: pause intensive practice and consider clinical support.\n'
      'L2→L3 gate: PHQ-9 ≥ 10 is a hard block on progression.',
  items: [
    QuestionnaireItem(text: 'Little interest or pleasure in doing things'),
    QuestionnaireItem(text: 'Feeling down, depressed, or hopeless'),
    QuestionnaireItem(text: 'Trouble falling or staying asleep, or sleeping too much'),
    QuestionnaireItem(text: 'Feeling tired or having little energy'),
    QuestionnaireItem(text: 'Poor appetite or overeating'),
    QuestionnaireItem(
      text: 'Feeling bad about yourself — or that you are a failure or have let yourself or your family down',
    ),
    QuestionnaireItem(
      text: 'Trouble concentrating on things, such as reading the newspaper or watching television',
    ),
    QuestionnaireItem(
      text: 'Moving or speaking so slowly that other people could have noticed? Or the opposite — being so '
          'fidgety or restless that you have been moving around a lot more than usual',
    ),
    QuestionnaireItem(
      text: 'Thoughts that you would be better off dead, or of hurting yourself in some way',
    ),
  ],
);

// ─── DASS-21 ──────────────────────────────────────────────────────────────────

const kDass21Definition = QuestionnaireDefinition(
  instruction:
      'Please read each statement and indicate how much the statement applied to you '
      'over the past week. There are no right or wrong answers. Do not spend too much '
      'time on any statement.',
  scaleLabels: [
    'Did not apply\nto me at all',
    'Applied to some\ndegree, or some\nof the time',
    'Applied to a\nconsiderable degree,\nor a good part of the time',
    'Applied very much,\nor most of the time',
  ],
  subscaleMultiplier: 2.0,
  subscales: {
    'Depression': [3, 5, 10, 13, 16, 17, 21],
    'Anxiety': [2, 4, 7, 9, 15, 19, 20],
    'Stress': [1, 6, 8, 11, 12, 14, 18],
  },
  scoringNotes:
      'Scores are doubled (×2) to convert to DASS-42 equivalent.\n'
      'Depression: Normal ≤9, Mild 10–13, Moderate 14–20, Severe 21–27, Extreme 28+\n'
      'Anxiety: Normal ≤7, Mild 8–9, Moderate 10–14, Severe 15–19, Extreme 20+\n'
      'Stress: Normal ≤14, Mild 15–18, Moderate 19–25, Severe 26–33, Extreme 34+',
  items: [
    QuestionnaireItem(text: 'I found it hard to wind down'),
    QuestionnaireItem(text: 'I was aware of dryness of my mouth'),
    QuestionnaireItem(text: 'I couldn\'t seem to experience any positive feeling at all'),
    QuestionnaireItem(
      text: 'I experienced breathing difficulty (e.g., excessively rapid breathing, '
          'breathlessness in the absence of physical exertion)',
    ),
    QuestionnaireItem(text: 'I found it difficult to work up the initiative to do things'),
    QuestionnaireItem(text: 'I tended to over-react to situations'),
    QuestionnaireItem(text: 'I experienced trembling (e.g., in the hands)'),
    QuestionnaireItem(text: 'I felt that I was using a lot of nervous energy'),
    QuestionnaireItem(
      text: 'I was worried about situations in which I might panic and make a fool of myself',
    ),
    QuestionnaireItem(text: 'I felt that I had nothing to look forward to'),
    QuestionnaireItem(text: 'I found myself getting agitated'),
    QuestionnaireItem(text: 'I found it difficult to relax'),
    QuestionnaireItem(text: 'I felt down-hearted and blue'),
    QuestionnaireItem(
      text: 'I was intolerant of anything that kept me from getting on with what I was doing',
    ),
    QuestionnaireItem(text: 'I felt I was close to panic'),
    QuestionnaireItem(text: 'I was unable to become enthusiastic about anything'),
    QuestionnaireItem(text: 'I felt I wasn\'t worth much as a person'),
    QuestionnaireItem(text: 'I felt that I was rather touchy'),
    QuestionnaireItem(
      text: 'I was aware of the action of my heart in the absence of physical exertion '
          '(e.g., sense of heart rate increase, heart missing a beat)',
    ),
    QuestionnaireItem(text: 'I felt scared without any good reason'),
    QuestionnaireItem(text: 'I felt that life was meaningless'),
  ],
);

// ─── FFMQ Observing Subscale ──────────────────────────────────────────────────
// Items 1, 6, 11, 15, 20, 26, 31, 36 from Baer et al. (2006).
// Verify exact item text against the original publication before clinical use.

const kFfmqObservingDefinition = QuestionnaireDefinition(
  instruction:
      'Using the scale below, please rate each of the following statements. '
      'In rating your answers, reflect what is generally true for you.\n\n'
      'Source: FFMQ Observing subscale (Baer et al., 2006). '
      'Verify against the original publication for clinical or research use.',
  scaleLabels: [
    'Never or\nvery rarely true',
    'Rarely\ntrue',
    'Sometimes\ntrue',
    'Often\ntrue',
    'Very often or\nalways true',
  ],
  scoringNotes:
      '8–20 Low observing capacity (Phase 3 baseline range).\n'
      '21–28 Developing (typical for Phase 3–4 practitioners).\n'
      '29–35 Functional (consistent with Phase 5 threshold).\n'
      '36–40 High (consistent with established dual presence).\n'
      'Track direction of change across administrations — a 3+ point increase from Phase 3 to Phase 5/6 confirms meta-attention development.',
  items: [
    QuestionnaireItem(text: 'When I\'m walking, I deliberately notice the sensations of my body moving.'),
    QuestionnaireItem(text: 'When I take a shower or bath, I stay alert to the sensations of water on my body.'),
    QuestionnaireItem(
      text: 'I notice how foods and drinks affect my thoughts, bodily sensations, and emotions.',
    ),
    QuestionnaireItem(
      text: 'I pay attention to sensations, such as the wind in my hair or sun on my face.',
    ),
    QuestionnaireItem(text: 'I notice smells and aromas of things.'),
    QuestionnaireItem(text: 'I pause and notice my emotions without reacting to them.'),
    QuestionnaireItem(
      text: 'I notice changes in my body, such as whether my breathing slows down or speeds up.',
    ),
    QuestionnaireItem(text: 'I notice when my moods begin to change.'),
  ],
);

// ─── SMS-Mind (score entry) ───────────────────────────────────────────────────
// Administer the SMS-Mind subscale externally (Chadwick et al., 2008).
// Search: "Southampton Mindfulness Scale Chadwick 2008" for the full instrument.

// ─── RRS (score entry) ────────────────────────────────────────────────────────
// Administer the RRS externally (Nolen-Hoeksema & Morrow, 1991).
// Search: "Rumination Response Scale Nolen-Hoeksema Morrow 1991" — 22-item version.

// ─── Lookup map ───────────────────────────────────────────────────────────────

const Map<String, QuestionnaireDefinition> kQuestionnaireDefs = {
  'TAS20': kTas20Definition,
  'PHQ9': kPhq9Definition,
  'DASS21': kDass21Definition,
  'FFMQ': kFfmqObservingDefinition,
};

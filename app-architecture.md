# Mental Mastery — App Architecture

**Status:** v0.1 — 2026-03-01
**Platform:** Android (Flutter / Dart)
**Purpose:** Single reference document for all development work. Defines folder structure, database schema, screen inventory, state management patterns, and build order. Written for a developer learning Flutter while building.

---

## 1. Core Decisions

| Decision | Choice | Rationale |
|---|---|---|
| Folder structure | Feature-first | All code for a feature lives together (screen + provider + widgets). No split `screens/`/`providers/` folders. Easier to navigate, easier to delete a feature. |
| Framework content | Static Dart `const` objects | 39 practices, 9 phases, 17 assessments, 19 templates are compile-time constants in a `content/` tree. Never stored in DB. Type-safe, zero query latency, hot-reload instantly. |
| Database | Drift (type-safe SQLite) | Stores only user-generated data. 10 tables. Drift gives compile-time SQL safety + generated data classes — better than raw sqflite for this schema complexity. |
| State management | Riverpod | Providers wrap all DB access and business logic. Screens are stateless widgets where possible. No direct DB calls from UI layer. |
| L2→L3 gate | First-class feature | Own screen, own provider, own evaluator path. PHQ-9 ≥ 10 hard-blocks progression in code — not a UI hint. |
| Voice input | Always optional | Every journal field and session note has mic + text input. Whisper on-device for journals; Vosk for real-time short inputs. User can edit transcript or type. |
| Navigation | go_router | Named routes, deep-link capable, integrates cleanly with Riverpod's redirect guards (used for onboarding gate + phase locks). |
| Track assignment | Per-metric, not global | Each of the three Phase 0 baseline measurements (TAS-20, somatic, vocabulary) independently assigns a track (`'standard'`/`'extended'`/`'priority'`) for that domain. A user can be on different tracks for different domains simultaneously. Scheduling weight order: emotional literacy > somatic > vocabulary. |
| Journal storage | Flat files, metadata only | Journal content lives as human-readable files in user-accessible external storage (survives uninstall). Only metadata (path, word count, date, phase) is stored in Drift. No journal text ever touches the database. |
| Data transmission | Local only | No user data is ever transmitted to a server. Journal content has no opt-in pathway for transmission. Anonymous statistics (assessment scores, timings, phase durations) are opt-in only, extracted to a local queue, and sent only when a destination is explicitly configured. |

---

## 2. Full Folder Structure

```
lib/
│
├── main.dart                   # App entry point; ProviderScope wrapper
├── app.dart                    # MaterialApp.router; go_router config; theme
│
├── core/
│   ├── database/
│   │   ├── app_database.dart   # Drift database class; all tables declared here
│   │   ├── daos/               # One DAO file per table (user_state_dao.dart, etc.)
│   │   └── drift_provider.dart # Riverpod provider exposing AppDatabase singleton
│   ├── router/
│   │   ├── router.dart         # go_router definition; all routes
│   │   └── guards.dart         # Redirect logic: onboarding gate, phase lock
│   ├── theme/
│   │   ├── app_theme.dart      # Material 3 color scheme, typography
│   │   └── tokens.dart         # Spacing, radius, elevation constants
│   └── widgets/
│       ├── markdown_viewer.dart     # Reusable full-screen markdown renderer
│       ├── arousal_slider.dart      # 0–10 slider; used in sessions + B3
│       ├── voice_input_field.dart   # Mic button + text field combo
│       ├── safety_card.dart         # Pre-session safety signal display
│       └── phase_badge.dart         # Locked / active / complete phase chip
│
├── content/                    # Static framework content — NO business logic
│   ├── phases/
│   │   ├── phase_model.dart    # PhaseContent data class (const)
│   │   └── all_phases.dart     # List<PhaseContent> for all 9 phases
│   ├── practices/
│   │   ├── practice_model.dart # PracticeContent data class (const)
│   │   └── all_practices.dart  # List<PracticeContent> for all 39 practices
│   ├── assessments/
│   │   ├── assessment_model.dart    # AssessmentContent data class (const)
│   │   └── all_assessments.dart     # List<AssessmentContent> for all 17 assessments
│   ├── templates/
│   │   ├── template_model.dart      # JournalTemplate data class (const)
│   │   └── all_templates.dart       # List<JournalTemplate> for T01–T19
│   ├── gates/
│   │   ├── gate_model.dart          # GateCriterion, GateDefinition data classes (const)
│   │   └── all_gates.dart           # List<GateDefinition> for all 9 gates
│   └── skills/
│       └── all_skills.dart          # SkillContent const objects (41 skills; for reference display)
│
├── features/
│   ├── onboarding/
│   │   ├── onboarding_screen.dart        # Scroll-gated markdown reader
│   │   ├── onboarding_provider.dart      # Tracks scroll depth; "complete" state
│   │   └── widgets/
│   │       └── scroll_gate_listener.dart # Fires when 95% scroll reached
│   │
│   ├── home/
│   │   ├── home_screen.dart             # Today's schedule: morning/midday/evening blocks
│   │   ├── home_provider.dart           # Today's practices for current phase
│   │   └── widgets/
│   │       ├── schedule_block.dart      # Morning / midday / evening card
│   │       ├── triggered_shortcuts.dart # Quick-access to triggered practices
│   │       └── assessment_due_badge.dart
│   │
│   ├── phase_journey/
│   │   ├── phase_journey_screen.dart    # Visual 9-phase timeline
│   │   ├── phase_journey_provider.dart  # Phase unlock states from DB
│   │   └── widgets/
│   │       ├── phase_node.dart          # Single phase: locked / active / complete
│   │       └── phase_detail_sheet.dart  # Bottom sheet: phase description, skills covered
│   │
│   ├── practices/
│   │   ├── practice_detail_screen.dart  # Full practice: purpose, steps, safety, "Begin"
│   │   ├── practice_session_screen.dart # Timer, drift tap, arousal, voice notes
│   │   ├── practice_provider.dart       # Session state; saves to practice_sessions
│   │   └── widgets/
│   │       ├── practice_step_list.dart  # Numbered step display
│   │       ├── session_timer.dart       # Countdown / elapsed with pause
│   │       ├── drift_tap_button.dart    # Large tap target; logs timestamp on each tap
│   │       ├── pre_session_safety_card.dart
│   │       └── session_complete_summary.dart
│   │
│   ├── assessments/
│   │   ├── assessment_hub_screen.dart       # List of assessments; due/overdue badges
│   │   ├── assessment_runner_screen.dart    # Shell screen; dispatches to runner widgets
│   │   ├── assessment_result_screen.dart    # Score display with threshold context
│   │   ├── assessment_provider.dart         # Session state; saves to assessment_results
│   │   ├── assessment_scheduler.dart        # Determines which assessments are due per phase
│   │   └── runners/
│   │       ├── questionnaire_runner.dart    # TAS-20, FFMQ, SMS-Mind, PHQ-9, DASS-21, RRS
│   │       ├── b1_body_map_runner.dart
│   │       ├── b2_hbd_runner.dart
│   │       ├── b3_arousal_runner.dart
│   │       ├── b4_vocab_runner.dart
│   │       ├── b5_attention_runner.dart
│   │       ├── b5a_direction_runner.dart
│   │       ├── b5b_distraction_runner.dart
│   │       ├── b6_probe_runner.dart
│   │       ├── b7_dual_presence_runner.dart
│   │       ├── b8_load_matrix_runner.dart
│   │       ├── b9_boundary_runner.dart
│   │       ├── b10_state_shifting_runner.dart
│   │       └── b11_calibration_runner.dart
│   │
│   ├── journal/
│   │   ├── journal_hub_screen.dart      # Past entries list; "New Entry" button
│   │   ├── journal_entry_screen.dart    # Dynamic template fields; voice-first layout
│   │   ├── journal_provider.dart        # Entry state; saves to journal_entries
│   │   └── widgets/
│   │       ├── template_field.dart      # Single journal field: label + voice_input_field
│   │       └── entry_card.dart          # Past entry preview in list
│   │
│   ├── gates/
│   │   ├── gate_screen.dart             # Entry: "I'm ready to assess gate N→N+1"
│   │   ├── gate_evaluation_screen.dart  # Step-through criterion evaluation
│   │   ├── gate_result_screen.dart      # Pass / not-yet result with unmet items
│   │   ├── l2l3_gate_screen.dart        # Distinct screen for Layer 2→3 gate
│   │   ├── gate_provider.dart           # Gate state; reads from gate_states table
│   │   └── widgets/
│   │       ├── criterion_row.dart       # Auto-check / semi-auto / manual checkbox
│   │       ├── phq9_block_banner.dart   # Red banner when PHQ-9 ≥ 10
│   │       └── crisis_checklist.dart    # 9-item crisis indicator checklist (L2→L3 only)
│   │
│   ├── progress/
│   │   ├── progress_screen.dart         # Two tabs: Phase Timeline + Metric Charts
│   │   ├── progress_provider.dart       # Longitudinal data from DB
│   │   └── widgets/
│   │       ├── phase_timeline_tab.dart  # Phase entry/exit dates, durations
│   │       ├── metric_charts_tab.dart   # Line charts per tracked metric
│   │       └── metric_chart.dart        # Single metric over time (fl_chart)
│   │
│   └── library/
│       ├── library_panel.dart           # Slide-out drawer; doc list
│       ├── library_provider.dart        # Tracks last-read position per doc
│       └── widgets/
│           └── doc_list_item.dart       # Doc title + last-read indicator
│
└── services/
    ├── speech/
    │   ├── vosk_service.dart            # Real-time ASR for short inputs
    │   └── whisper_service.dart         # Batch transcription for journal entries
    ├── bluetooth/
    │   └── hr_monitor_service.dart      # flutter_blue_plus; HRM profile; HR stream
    ├── alarms/
    │   └── alarm_service.dart           # B6 meta-attention probes; check-in reminders
    └── gate_evaluator/
        └── gate_evaluator_service.dart  # Auto + semi-auto criterion evaluation

assets/
├── docs/                        # All 8 framework markdown files (reference library)
│   ├── onboarding-guide.md
│   ├── quick-reference.md
│   ├── skill-taxonomy.md
│   ├── progression-model.md
│   ├── training-curriculum.md
│   ├── assessment-tools.md
│   ├── research-grounding.md
│   └── scientific-foundation.md
└── images/
    └── body_diagram.svg         # Anterior + posterior body outline for B1 assessment
```

---

## 3. Database Schema (Drift)

Drift generates type-safe Dart data classes from table definitions. All tables defined in `app_database.dart`. One DAO per table in `core/database/daos/`. Schema version: 2.

**Storage split:** Assessment data and gate state → Drift (append-only where noted). Journal content → flat files in user-accessible external storage. The two systems never mix.

### 3.1 `user_state` — Singleton row

One row (id = 1), always present after onboarding.

| Column | Type | Notes |
|---|---|---|
| `id` | INTEGER PK | Always 1 |
| `onboarding_complete` | BOOLEAN | False until scroll gate passes |
| `current_phase` | INTEGER | 0–8 |
| `track_emotional_literacy` | TEXT NULLABLE | `'standard'` / `'extended'` / `'priority'`; null until Phase 0 complete |
| `track_somatic` | TEXT NULLABLE | `'standard'` / `'extended'` / `'priority'`; null until Phase 0 complete |
| `track_vocabulary` | TEXT NULLABLE | `'standard'` / `'extended'` / `'priority'`; null until Phase 0 complete |
| `tas20_score` | INTEGER NULLABLE | Raw score from Phase 0 TAS-20; full data in `assessment_results` |
| `values_document` | TEXT NULLABLE | Free text from Phase 0 values exercise |
| `self_description` | TEXT NULLABLE | Free text from Phase 0 self-description exercise |
| `stats_opt_in` | BOOLEAN | Default false; requested after Phase 0 completion, never at install |
| `stats_token` | TEXT NULLABLE | Random local token generated once at opt-in; no external linkage |
| `created_at` | DATETIME | |
| `updated_at` | DATETIME | |

**Track assignment logic:** Each Phase 0 baseline measurement independently assigns a track for its domain. TAS-20 → `track_emotional_literacy`; B1 somatic baseline → `track_somatic`; B4 vocabulary count → `track_vocabulary`. A user can be on different tracks for different domains. Scheduling weight: emotional literacy > somatic > vocabulary.

| Measurement | Standard | Extended | Priority |
|---|---|---|---|
| TAS-20 | < 52 | 52–60 | > 61 |
| Somatic baseline (B1) | ≥ 4 sensations | < 4 sensations | TBD* |
| Vocabulary count (B4) | ≥ 10 words | < 10 words | TBD* |

*Third-tier thresholds for somatic and vocabulary are not yet defined in the framework. Pending addition to `progression-model.md` before Phase 0 assessment logic is built.

### 3.2 `phase_progress` — One row per phase entered

| Column | Type | Notes |
|---|---|---|
| `id` | INTEGER PK | Auto |
| `phase_number` | INTEGER | 0–8 |
| `status` | TEXT | `'active'`, `'gate_pending'`, `'complete'` |
| `started_at` | DATETIME | When user confirmed phase start |
| `completed_at` | DATETIME NULLABLE | When gate passed |
| `week_number` | INTEGER | Week within phase (incremented weekly) |
| `extensions_json` | TEXT NULLABLE | JSON map of domain → added weeks after failed gate (e.g. `{"somatic": 4}`); cleared when gate passes |

### 3.3 `practice_sessions` — One row per completed session

| Column | Type | Notes |
|---|---|---|
| `id` | INTEGER PK | Auto |
| `practice_id` | TEXT | Matches `PracticeContent.id` (e.g. `'P1A'`) |
| `phase_number` | INTEGER | |
| `started_at` | DATETIME | |
| `ended_at` | DATETIME NULLABLE | |
| `duration_seconds` | INTEGER NULLABLE | Actual elapsed time |
| `drift_count` | INTEGER | Number of drift tap events (default 0) |
| `drift_tap_log` | TEXT NULLABLE | JSON array of tap timestamps in seconds from start |
| `arousal_before` | REAL NULLABLE | 0–10 scale; ±2 point error tolerance per framework |
| `arousal_after` | REAL NULLABLE | 0–10 scale |
| `hr_before` | REAL NULLABLE | BPM from HR monitor; null if not connected |
| `hr_after` | REAL NULLABLE | BPM from HR monitor |
| `quality_score` | REAL NULLABLE | Phase 7+ only; 0–1 behavioral relevance score (I1.4) |
| `notes_text` | TEXT NULLABLE | Typed or transcribed session notes |
| `voice_transcript` | TEXT NULLABLE | Raw Whisper transcript before user editing; excluded from stats extraction |
| `safety_acknowledged` | BOOLEAN | True if user tapped through pre-session safety card |

### 3.4 `assessment_results` — One row per assessment administration

**Append-only by design.** Rows are never edited or deleted after insert. Baseline entries are immutable. Full history preserved for every assessment type.

| Column | Type | Notes |
|---|---|---|
| `id` | INTEGER PK | Auto |
| `assessment_id` | TEXT | Matches `AssessmentContent.id` (e.g. `'TAS20'`, `'B5a'`) |
| `phase_number` | INTEGER | |
| `administered_at` | DATETIME | |
| `raw_scores` | TEXT | JSON object; format varies by assessment type |
| `total_score` | REAL NULLABLE | Computed total; null if no single total is meaningful |
| `subscale_scores` | TEXT NULLABLE | JSON object of subscale breakdowns (e.g. TAS-20 DIF/DDF/EOT) |
| `environment_type` | TEXT NULLABLE | `'quiet'` / `'moderate_noise'` / `'high_load'` — B8 metadata |
| `load_type` | TEXT NULLABLE | Cognitive load description — B8 metadata |
| `hr_device_count` | REAL NULLABLE | Actual HR from monitor — B7/B8 |
| `hr_user_estimate` | REAL NULLABLE | User's counted heartbeat estimate — B7/B8 |

### 3.5 `journal_entries` — Metadata only. One row per journal entry.

**Content lives as flat files in user-accessible external storage** (`getExternalStorageDirectory()`). Files survive app uninstall. User can back up to any system they trust. No journal text, audio paths, or transcripts ever touch this table.

| Column | Type | Notes |
|---|---|---|
| `id` | INTEGER PK | Auto |
| `template_id` | TEXT NULLABLE | Matches `JournalTemplate.id` (e.g. `'T01'`); null for freeform entries |
| `phase_number` | INTEGER | |
| `practice_id` | TEXT NULLABLE | If entry is linked to a specific practice session |
| `created_at` | DATETIME | |
| `file_path` | TEXT | Absolute path to the flat file in external storage |
| `word_count` | INTEGER NULLABLE | Set after save |
| `transcription_complete` | BOOLEAN | False if voice entry not yet transcribed |

### 3.6 `gate_states` — One row per gate (9 gates)

Persists overall gate status between sessions. Per-criterion state is in `gate_criteria_states`.

| Column | Type | Notes |
|---|---|---|
| `id` | INTEGER PK | Auto |
| `gate_number` | INTEGER | 1–9 (Gate 1 = Phase 0→1, Gate 9 = Phase 7→8) |
| `status` | TEXT | `'not_started'`, `'in_progress'`, `'passed'`, `'failed_retry'` |
| `attempt_count` | INTEGER | Increments on each gate attempt |
| `phq9_at_gate` | INTEGER NULLABLE | L2→L3 only; ≥ 10 is a hard block (`canProceed = false`) |
| `crisis_indicators_clear` | BOOLEAN NULLABLE | L2→L3 only; all 9 indicators confirmed clear |
| `self_assessment_text` | TEXT NULLABLE | Written self-assessment (required at certain gates); excluded from stats extraction |
| `block_reason` | TEXT NULLABLE | Filled when status = `'failed_retry'` with the specific block reason |
| `last_attempted_at` | DATETIME NULLABLE | |
| `passed_at` | DATETIME NULLABLE | |

### 3.7 `gate_criteria_states` — Per-criterion evaluation state

One row per criterion per gate attempt. Gate criteria **definitions** (what each criterion requires, its domain, its type) are static Dart `const` objects in `content/gates/all_gates.dart` — never stored here.

| Column | Type | Notes |
|---|---|---|
| `id` | INTEGER PK | Auto |
| `gate_number` | INTEGER | 1–9 |
| `criterion_id` | TEXT | Matches `GateCriterion.id` from static content |
| `track` | TEXT | `'A'` (self-reported) or `'B'` (app-administered) |
| `domain` | TEXT | `'emotional_literacy'` / `'somatic'` / `'vocabulary'` / `'attention'` / `'integration'` |
| `status` | TEXT | `'pending'`, `'auto_pass'`, `'auto_fail'`, `'manual_checked'` |
| `value` | TEXT NULLABLE | Recorded value at evaluation time (stored as text for display) |
| `evaluated_at` | DATETIME NULLABLE | |
| `attempt_number` | INTEGER | Which gate attempt this row belongs to |

**Track A vs. Track B discrepancy:** When Track A criteria pass but Track B criteria do not (or vice versa), the `GateResultScreen` surfaces this explicitly with framing that the gap is meaningful data, not a simple failure. The gate evaluator checks both tracks independently and the result screen has a distinct display state for cross-track discrepancy.

### 3.8 `longitudinal_metrics` — Metric snapshots over time

Written alongside `assessment_results` inserts. Drives trajectory charts in the Progress screen.

| Column | Type | Notes |
|---|---|---|
| `id` | INTEGER PK | Auto |
| `metric_id` | TEXT | e.g. `'TAS20_total'`, `'FFMQ_observe'`, `'HBD_accuracy'`, `'recovery_time_avg'` |
| `phase_number` | INTEGER | |
| `recorded_at` | DATETIME | |
| `value` | REAL | |
| `source_assessment_id` | INTEGER NULLABLE | FK to `assessment_results.id` if derived from an assessment |

### 3.9 `scheduled_alarms` — B6 probes, check-ins, and practice reminders

Notification permission is requested after Phase 0 completion — never at install or onboarding. No streak-at-risk or guilt-based patterns. Copy tone: clinical and straightforward.

| Column | Type | Notes |
|---|---|---|
| `id` | INTEGER PK | Auto |
| `alarm_type` | TEXT | `'meta_attention_probe'`, `'emotion_checkin'`, `'practice_reminder'` |
| `scheduled_for` | DATETIME | |
| `fired_at` | DATETIME NULLABLE | Actual fire time; null if not yet fired |
| `responded_at` | DATETIME NULLABLE | When user responded; null if dismissed or missed |
| `response_json` | TEXT NULLABLE | JSON of user's response (probes and check-ins only) |
| `phase_number` | INTEGER | |

### 3.10 `stats_queue` — Anonymous statistics payload queue

**Append-only.** Populated by `StatisticsExtractorService` after each assessment, phase transition, gate passage, and practice session — never after journal saves or any free-text event. Drained by `StatsSubmitterService` when a destination is configured (destination is TBD).

**What the extractor includes:** assessment scores and subscales, Track B timings and counts, practice session metadata (practice_id, duration, drift_count, arousal), phase durations, gate attempt counts and outcomes.

**What the extractor never includes:** any journal content or metadata, audio paths, voice transcripts, session notes text, gate self-assessment text, values document, self-description, or any free-text field.

**Sanitization:** timestamps rounded to day; no device ID, account, or name; random local `stats_token` as the only linking key across payloads.

| Column | Type | Notes |
|---|---|---|
| `id` | INTEGER PK | Auto |
| `schema_version` | INTEGER | Payload schema version; default 1; increment when payload format changes |
| `event_type` | TEXT | `'assessment'`, `'phase_transition'`, `'gate_passage'`, `'session'` |
| `payload_json` | TEXT | Sanitized, typed payload |
| `created_at` | DATETIME | |
| `submitted_at` | DATETIME NULLABLE | Null until destination configured and submission succeeds |

---

## 4. Static Content Models

These live in `content/`. They are compile-time `const` Dart objects — never fetched from a database.

### 4.1 `PracticeContent`

```dart
class PracticeContent {
  final String id;               // e.g., 'P1A', 'P5G'
  final String name;
  final String phaseId;          // Which phase this practice belongs to
  final String layer;            // 'L1', 'L2', 'L3', 'cross'
  final List<String> skillIds;   // Skills trained (e.g., ['S1.1', 'S1.2'])
  final String scheduleSlot;     // 'morning', 'midday', 'evening', 'triggered'
  final int durationMinutes;
  final String purpose;
  final List<String> steps;      // Numbered instructions
  final List<String> safetySignals; // Stop criteria for this practice
  final String? researchNote;    // Inline [R] note if present
  final bool requiresHrMonitor;
  final bool qualityRatedPhase7Plus;
}
```

### 4.2 `AssessmentContent`

```dart
class AssessmentContent {
  final String id;               // e.g., 'TAS20', 'B5', 'B5a'
  final String name;
  final String runnerType;       // Maps to runner widget (see Section 6)
  final String section;         // 'A' (validated instrument) or 'B' (custom protocol)
  final List<int> administeredAtPhases; // Phases where this assessment is due
  final String? scoringNotes;
  final Map<String, double>? thresholds; // Named thresholds for auto-scoring
}
```

### 4.3 `JournalTemplate`

```dart
class JournalTemplate {
  final String id;               // 'T01'–'T19'
  final String name;
  final String practiceId;       // Which practice this template supports
  final List<TemplateField> fields;
}

class TemplateField {
  final String id;
  final String label;
  final String inputType;        // 'text', 'scale', 'checklist', 'timestamp'
  final String? placeholder;
  final bool voiceEnabled;       // Always true except 'scale' and 'timestamp'
}
```

### 4.4 `GateDefinition`

```dart
class GateDefinition {
  final int gateNumber;          // 1–9
  final int fromPhase;
  final int toPhase;
  final bool isL2L3Gate;         // true for gate 5 (Phase 4→5)
  final List<GateCriterion> criteria;
}

class GateCriterion {
  final String id;
  final String description;
  final CriterionType type;      // auto, semiAuto, manual
  final String? evaluatorKey;    // Key used by GateEvaluatorService for auto/semiAuto
}

enum CriterionType { auto, semiAuto, manual }
```

---

## 5. Riverpod Provider Architecture

Providers are the only bridge between UI and data. Screens never call DAOs directly.

### Provider hierarchy overview

```
AppDatabase (singleton) — from drift_provider.dart
  ↓
DAOs (UserStateDao, PracticeSessionsDao, etc.)
  ↓
Domain Providers (userStateProvider, currentPhaseProvider, etc.)
  ↓
Feature Providers (homeScheduleProvider, gateStateProvider, etc.)
  ↓
Screen widgets (consume providers; no direct DB access)
```

### Core providers

| Provider | Type | What it exposes |
|---|---|---|
| `appDatabaseProvider` | `Provider<AppDatabase>` | Singleton DB instance |
| `userStateProvider` | `StreamProvider<UserState>` | Single user_state row; watched reactively |
| `currentPhaseProvider` | `Provider<int>` | Derived from userStateProvider |
| `onboardingCompleteProvider` | `Provider<bool>` | Gate for router redirect |
| `currentPhaseProgressProvider` | `StreamProvider<PhaseProgress?>` | Active phase row |
| `todaysPracticesProvider` | `Provider<List<PracticeContent>>` | Filtered from static content by current phase + day |
| `assessmentsDueProvider` | `Provider<List<AssessmentContent>>` | Cross-references admin calendar with last admin dates |
| `sessionStateProvider` | `StateNotifierProvider<SessionNotifier, SessionState>` | Active practice session (timer, drifts, arousal) |
| `gateStateProvider(int gateNumber)` | `StreamProvider<GateState>` | Parameterized; one per gate |
| `gateEvaluationProvider(int gateNumber)` | `FutureProvider<GateEvaluationResult>` | Runs evaluator service; returns criterion states |
| `l2l3GateProvider` | `StateNotifierProvider<L2L3GateNotifier, L2L3GateState>` | L2→L3 gate; `canProceed` is false if PHQ-9 ≥ 10 |
| `longitudinalMetricsProvider(String metricId)` | `StreamProvider<List<MetricSnapshot>>` | Time series for a single metric |
| `journalEntriesProvider` | `StreamProvider<List<JournalEntry>>` | All entries, newest first |

### Router guards (in `core/router/guards.dart`)

```
onboarding not complete → redirect to /onboarding (from any route)
current phase < required phase → redirect to /phase-locked (from practice/assessment routes)
gate not passed → prevent PhaseJourneyScreen from showing "Begin Phase N+1" button
```

Guards are implemented as `GoRouter.redirect` callbacks that read Riverpod providers via `ref.read`.

---

## 6. Assessment Runner Widgets

Each runner is a self-contained widget returned by `AssessmentRunnerScreen` based on `assessment.runnerType`. No generic engine — each runner owns its own UI and scoring logic.

| Runner widget | Covers | Key UI elements |
|---|---|---|
| `QuestionnaireRunner` | TAS-20, FFMQ, SMS-Mind, PHQ-9, DASS-21, RRS | Paged question list; Likert scale; auto-score on submit |
| `B1BodyMapRunner` | B1 Somatic Baseline | SVG body diagram; tap-to-annotate; voice narration per region |
| `B2HbdRunner` | B2 HBD Accuracy | Count input; time window display; HR monitor comparison if connected |
| `B3ArousalRunner` | B3 Arousal Scale | 0–10 slider; timestamp auto-logged; optional brief context note |
| `B4VocabRunner` | B4 Emotional Vocabulary | Prompted voice stream; auto-transcribed; user categorizes words |
| `B5AttentionRunner` | B5 Attention Sustaining | Full-screen timer; large drift tap button; auto-calculates drift frequency and gap averages |
| `B5aDirectionRunner` | B5a Attention Direction | Direction prompts displayed sequentially; tap to confirm redirection; tracks accuracy |
| `B5bDistractionRunner` | B5b Distraction Resistance | Structured distractor exposure; tap to log resistance failures; calculates resistance ratio |
| `B6ProbeRunner` | B6 Meta-Attention Probes | Alarm-triggered; captures current mental state; voice-first; short |
| `B7DualPresenceRunner` | B7 Dual Presence | Guided self-observation prompts; binary yes/no per criterion; voice notes |
| `B8LoadMatrixRunner` | B8 Interoceptive Load Matrix | Structured load conditions (quiet → moderate → high); B5 + HBD per condition; auto-calculates accuracy delta |
| `B9BoundaryRunner` | B9 Boundary Integrity | Scenario presentation; user response capture; rater rubric displayed |
| `B10StateShiftingRunner` | B10 State Shifting | Pre/post arousal + HR; timed shift sequence; delta calculation |
| `B11CalibrationRunner` | B11 Calibration Matrix | Side-by-side: self-assessment vs. measured on 6 skills; gap score calculation |

### Scoring architecture

Each runner calls `assessmentProvider.saveResult(AssessmentResultCompanion)` on submit. Auto-scoring happens inside the runner before saving. Scores are written to both `assessment_results` and `longitudinal_metrics` in a single transaction. The `assessment_result_screen.dart` reads the saved row and displays score with threshold context.

---

## 7. Gate Evaluation Logic

### Three criterion types

**Auto-evaluable** — queried directly from the database by `GateEvaluatorService`:
- Example: "HBD accuracy ≥ 70% across 3 consecutive weekly assessments" → query `assessment_results` for B2 results in current phase, check last 3 are ≥ 70%.
- Example: "PHQ-9 ≤ 9 at phase exit" → query most recent PHQ-9 result.

**Semi-auto** — counted from session/journal logs by `GateEvaluatorService`:
- Example: "14 consecutive morning journal entries completed" → count T01 entries in `journal_entries` where `created_at` falls in consecutive days.
- Example: "Practice 1A completed ≥ 5 times in past 7 days" → count sessions in `practice_sessions` by practice ID and date window.

**Manual** — user explicitly checks in the UI:
- Example: "Written self-assessment narrative complete" → user taps checkbox; `gate_states.criteria_states` updated to `'manual_checked'`.
- These cannot be auto-evaluated and are always user-confirmed.

### Gate evaluation flow

```
User taps "Assess Gate N→N+1"
  → GateEvaluationScreen loads GateDefinition from content/
  → Calls gateEvaluationProvider(gateNumber)
    → GateEvaluatorService evaluates all auto + semi-auto criteria
    → Returns GateEvaluationResult { Map<criterionId, CriterionState> }
  → Screen renders CriterionRow per criterion
    → Auto: shows pass/fail icon (no user action)
    → Semi-auto: shows count vs. required (no user action)
    → Manual: shows checkbox (user taps to confirm)
  → User taps "Submit Assessment"
    → GateProvider checks: all criteria met?
    → If yes: gate_states updated to 'passed'; phase_progress for next phase created
    → If no: GateResultScreen shows unmet items with links to relevant practices
```

### L2→L3 Gate (Gate 5 — Phase 4→5)

Handled by `l2l3_gate_screen.dart` with distinct visual treatment:

1. **PHQ-9 hard block** — `L2L3GateNotifier.canProceed` checks `gate_states.phq9_at_gate`. If value ≥ 10, the "Proceed" button is replaced with a red non-interactive banner reading: *"PHQ-9 score indicates significant distress. Gate is locked. Re-administer PHQ-9 after recovery or with professional support."* This is enforced in code, not just UX.

2. **Crisis indicator checklist** — 9-item checklist (sourced from `progression-model.md` L2→L3 gate criteria). All 9 must be affirmatively checked by the user. If any are unchecked, `canProceed = false`.

3. **Enhanced self-assessment** — longer written self-assessment required; `gate_states.self_assessment_text` must be non-empty.

4. All standard gate criteria (auto + semi-auto + manual) still evaluated as normal.

### `GateEvaluatorService` interface

```dart
class GateEvaluatorService {
  // Returns evaluation result for all auto + semi-auto criteria in a gate.
  // Manual criteria are excluded — those are always user-confirmed.
  Future<GateEvaluationResult> evaluate(int gateNumber);

  // Specific evaluators (called internally)
  Future<bool> checkAssessmentThreshold({
    required String assessmentId,
    required String metricField,
    required double threshold,
    required ComparisonOp op,
    int consecutiveRequired = 1,
  });

  Future<bool> checkSessionCount({
    required String practiceId,
    required int requiredCount,
    int withinDays,
  });

  Future<bool> checkJournalStreak({
    required String templateId,
    required int consecutiveDays,
  });
}
```

---

## 8. Voice Input Architecture

### Two ASR modes

**Vosk (real-time)** — used for:
- B3 arousal context notes
- B4 thought stream log
- B6 probe responses
- Any single-sentence input field

Vosk streams partial results while user speaks. `VoskService` exposes a `Stream<String>` of partial transcripts. Final result written on silence detection.

**Whisper on-device (batch)** — used for:
- All 19 journal templates (T01–T19)
- Practice session notes
- Gate self-assessment text

`WhisperService` accepts a recorded audio file path and returns a `Future<String>` transcript. Recording is done first (user taps mic, speaks, taps stop), then transcription runs. User sees "Transcribing..." progress indicator, then editable result.

### `VoiceInputField` widget

The `core/widgets/voice_input_field.dart` widget handles both modes:
- `voiceMode: VoiceMode.realtime` → uses VoskService
- `voiceMode: VoiceMode.batch` → records audio file, calls WhisperService after stop

Every journal field and session note uses this widget. Text-only fallback always available: mic icon is toggleable with a keyboard icon.

### Bluetooth HR monitor

`HrMonitorService` exposes:
- `Stream<bool> connectionState` — connected/disconnected
- `Stream<double> heartRate` — BPM readings
- `Future<void> connect(BluetoothDevice)` — pair to a specific device
- `Future<List<BluetoothDevice>> scan()` — discover nearby HRM devices

Used by: B5AttentionRunner, B7DualPresenceRunner, B8LoadMatrixRunner, B10StateShiftingRunner, PracticeSessionScreen (for practices that record HR delta).

When HR monitor is not connected, affected screens show a dismissible "No HR monitor — tap count will be used instead" banner. Functionality degrades gracefully.

---

## 9. Screen Inventory

Full list of screens with route paths. All route names are defined as constants in `router.dart`.

| Screen | Route | Notes |
|---|---|---|
| `OnboardingScreen` | `/onboarding` | Scroll gate; locked until 95% read |
| `HomeScreen` | `/` | Today's schedule; entry point after onboarding |
| `PhaseJourneyScreen` | `/phases` | 9-phase visual timeline |
| `PhaseDetailSheet` | *(bottom sheet)* | Slides up from PhaseJourneyScreen; no own route |
| `PracticeDetailScreen` | `/practice/:id` | Full practice description + "Begin Session" |
| `PracticeSessionScreen` | `/practice/:id/session` | Active session; timer + controls |
| `SessionCompleteScreen` | `/practice/:id/session/complete` | Summary + save |
| `AssessmentHubScreen` | `/assessments` | All assessments; due/overdue badges |
| `AssessmentRunnerScreen` | `/assessment/:id/run` | Shell; dispatches to runner widget |
| `AssessmentResultScreen` | `/assessment/:id/result/:resultId` | Score + threshold context |
| `JournalHubScreen` | `/journal` | Past entries list |
| `JournalEntryScreen` | `/journal/new?templateId=T01` | New entry for template |
| `JournalEntryViewScreen` | `/journal/:id` | Read past entry |
| `GateScreen` | `/gate/:number` | Gate entry; "Begin Assessment" |
| `GateEvaluationScreen` | `/gate/:number/evaluate` | Step-through criterion evaluation |
| `GateResultScreen` | `/gate/:number/result` | Pass / not-yet |
| `L2L3GateScreen` | `/gate/5` | Overrides standard GateScreen for gate 5 |
| `L2L3GateEvaluationScreen` | `/gate/5/evaluate` | Extended evaluation with PHQ-9 block + crisis checklist |
| `ProgressScreen` | `/progress` | Two tabs: timeline + charts |
| `SettingsScreen` | `/settings` | HR monitor pairing; alarm config; known limits |
| `PhaseLockScreen` | `/phase-locked` | Shown when user tries to access locked content |
| `LibraryPanel` | *(slide-out drawer)* | Accessible from all main screens; no own route |
| `DocReaderScreen` | `/library/:docName` | Full-screen markdown reader |

---

## 10. Navigation and Routing

```
go_router manages all navigation.
Routes are defined centrally in core/router/router.dart.
GoRouter is exposed as a Riverpod provider (routerProvider).
Redirect guards read Riverpod state synchronously via ref.read.
```

### Guard logic (evaluated on every navigation)

```dart
redirect: (context, state) {
  final onboardingComplete = ref.read(onboardingCompleteProvider);
  if (!onboardingComplete && state.fullPath != '/onboarding') {
    return '/onboarding';
  }
  // Phase-lock guard checked per route prefix
  return null; // No redirect
}
```

### Bottom navigation bar (post-onboarding)

```
Home | Phases | Journal | Progress | (Library via hamburger)
```

Assessments are accessed from Home (due badge) or from Phase detail, not via bottom nav.

---

## 11. Theming

Material 3. Dark-mode-first (low arousal environment for late-night practice sessions).

| Token | Value |
|---|---|
| Primary color | Deep teal — calm, clinical, not clinical-cold |
| Background | Near-black (`#0D0F0F`) |
| Surface | Dark grey (`#1A1D1D`) |
| On-surface | Off-white (`#E8ECEC`) |
| Error / PHQ block | Muted red (`#CF4C4C`) |
| Gate pass | Muted green (`#4CAF7A`) |
| Phase locked | Dim grey (`#4A4A4A`) |
| Typography | `Roboto Mono` for numbers/scores; `Roboto` for prose |

Light mode optional in v2. All color decisions in `core/theme/app_theme.dart` — no hardcoded colors in widgets.

---

## 12. Key Packages

| Package | Version pin | Purpose |
|---|---|---|
| `flutter_riverpod` | ^2.x | State management |
| `riverpod_annotation` | ^2.x | Code generation for providers |
| `go_router` | ^14.x | Navigation / routing |
| `drift` | ^2.x | Type-safe SQLite |
| `drift_dev` | ^2.x (dev) | Drift code generation |
| `build_runner` | ^2.x (dev) | Code generation runner |
| `vosk_flutter` | latest | Real-time on-device ASR |
| `flutter_blue_plus` | ^1.x | Bluetooth LE / HR monitor |
| `fl_chart` | ^0.68.x | Longitudinal metric charts |
| `flutter_markdown` | ^0.7.x | Reference library doc renderer |
| `path_provider` | ^2.x | File paths for audio / Whisper |
| `record` | ^5.x | Audio recording for Whisper batch mode |
| `permission_handler` | ^11.x | Mic + Bluetooth permissions |

Whisper on-device: integrate via `whisper.cpp` FFI bindings (no pub.dev package — compile from source or use community wrapper). This is the highest-complexity dependency; see Phase 3 build notes.

---

## 13. Phased Build Order

### Phase 1 — Foundation (Weeks 1–3)

**Goal:** App opens, onboarding gate works, phases visible.

Deliverables:
- Drift schema created; all 7 tables; DAOs for `user_state` and `phase_progress`
- Riverpod setup; `appDatabaseProvider`, `userStateProvider`
- go_router with onboarding redirect guard
- `OnboardingScreen` with 95% scroll gate; saves `onboarding_complete = true`
- `HomeScreen` shell (today's schedule placeholder)
- `PhaseJourneyScreen` showing all 9 phases locked/unlocked
- `PhaseContent` static constants for all 9 phases in `content/phases/`
- Material 3 theme applied; dark mode

Test: Fresh install → onboarding gate → phases visible → Phase 0 shown as active.

---

### Phase 2 — Practice Sessions (Weeks 4–6)

**Goal:** User can run and log a complete practice session.

Deliverables:
- `PracticeContent` static constants for all 39 practices in `content/practices/`
- `practice_sessions` table and DAO
- `PracticeDetailScreen` — steps, safety card
- `PracticeSessionScreen` — timer, drift tap, arousal sliders before/after
- `SessionCompleteScreen` — save to DB; summary display
- `HomeScreen` today's schedule populated from static practice content + current phase
- `sessionStateProvider` StateNotifier; timer logic
- Safety card widget; `PracticeContent.safetySignals` displayed before session starts

Test: Open practice → read safety card → begin session → log drifts + arousal → save → see summary.

---

### Phase 3 — Journal & Voice (Weeks 7–9)

**Goal:** User can complete any journal entry by voice or text.

Deliverables:
- `JournalTemplate` static constants for T01–T19 in `content/templates/`
- `journal_entries` table and DAO
- `JournalHubScreen`, `JournalEntryScreen`, `JournalEntryViewScreen`
- `VoiceInputField` widget (text fallback)
- `VoskService` — real-time ASR integration
- `WhisperService` — audio recording + batch transcription
  - NOTE: Whisper FFI integration is the hardest step. Reserve extra time. If blocked, stub with text-only and return in Phase 6.
- Journal entry linked to practice session (optional `practice_id` FK)

Test: Open journal → select T01 → speak → see transcript → edit → save → view in hub.

---

### Phase 4 — Assessment System (Weeks 10–14)

**Goal:** All assessments runnable and scored.

Deliverables:
- `AssessmentContent` static constants for all 17 assessments in `content/assessments/`
- `assessment_results` and `longitudinal_metrics` tables and DAOs
- `AssessmentHubScreen`, `AssessmentRunnerScreen`, `AssessmentResultScreen`
- All 14 runner widgets (one per assessment type — see Section 6)
- Auto-scoring inside each runner
- `AssessmentScheduler` — determines which assessments are due
- `assessmentsDueProvider` and due badge on HomeScreen

Build order within Phase 4:
1. `QuestionnaireRunner` first (covers 6 validated instruments; highest immediate value)
2. `B3ArousalRunner` (simplest custom protocol)
3. `B5AttentionRunner` (needed for Phase 1 gate)
4. `B2HbdRunner` (needs HR monitor consideration — integrate without HR first)
5. Remaining runners in assessment order

Test: Run TAS-20 → auto-score → see threshold context → score saved → appears in longitudinal_metrics.

---

### Phase 5 — Gates & Progress (Weeks 15–17)

**Goal:** Phase gates work, phases unlock, charts render.

Deliverables:
- `GateDefinition` static constants for all 9 gates in `content/gates/`
- `gate_states` table and DAO
- `GateEvaluatorService` with all three criterion types
- `GateScreen`, `GateEvaluationScreen`, `GateResultScreen`
- `L2L3GateScreen`, `L2L3GateEvaluationScreen` with PHQ-9 hard block and crisis checklist
- Phase unlock logic: gate pass → creates next `phase_progress` row → `currentPhaseProvider` updates → router allows next phase
- `ProgressScreen` with two tabs:
  - Phase timeline tab — entry/exit dates, durations
  - Metric charts tab — `fl_chart` line charts per `longitudinal_metrics` metric
- `longitudinalMetricsProvider` per metric

Test: Pass Gate 0→1 criteria → Phase 1 unlocks → progress chart shows Phase 0 data.

---

### Phase 6 — Services & Polish (Weeks 18–20)

**Goal:** Complete app — all services integrated, no stubs.

Deliverables:
- `HrMonitorService` — flutter_blue_plus; connect/stream/disconnect
  - HR monitor pairing UI in SettingsScreen
  - Inject HR readings into B5/B7/B8/B10 runners + PracticeSessionScreen
- `AlarmService` — scheduled alarms for B6 probes and emotion check-ins
  - `scheduled_alarms` table and DAO
  - Platform notification integration
- Whisper integration complete if stubbed in Phase 3
- `LibraryPanel` — slide-out drawer with all 8 markdown docs
  - `DocReaderScreen` renders markdown via `flutter_markdown`
  - Reference docs bundled in `assets/docs/`
- `SettingsScreen` — HR pairing, alarm config, known limits display
- `B6ProbeRunner` — alarm-triggered; requires AlarmService
- Quality score field enabled for Phase 7+ sessions (`practice_sessions.quality_score`)
- Final UX pass: transitions, loading states, error states

Test: Pair HR monitor → run B8 load matrix with live HR → receive B6 probe alarm → log response → view in progress charts.

---

## 14. Critical Implementation Notes

### Whisper on-device integration

The Whisper FFI integration (Phase 3) is the highest-risk technical task in the build. Options:

1. **`whisper_flutter_new`** pub.dev package — community-maintained; wraps whisper.cpp; check maintenance status before committing.
2. **Manual FFI** — compile whisper.cpp as a shared library (`.so`) for Android arm64; write FFI bindings in Dart. Significant effort but full control.
3. **Stub fallback** — if integration blocks Phase 3 progress, implement text-only journal with a `// TODO: Whisper` stub. Voice transcription added in Phase 6. Do not block the rest of the app on this.

Model files are large (tiny: ~75MB; base: ~145MB). Do not bundle in APK. Download on first use with a progress indicator; store in app's private files directory.

### Drift code generation

Drift requires running `build_runner` after any schema change:
```
dart run build_runner build --delete-conflicting-outputs
```
Run this after every change to table definitions in `app_database.dart`. Keep generated files (`*.g.dart`) committed — they are required for compilation.

### L2→L3 gate PHQ-9 enforcement

The PHQ-9 hard block is a safety feature, not a UX hint. Implementation requirement:
- `L2L3GateNotifier.canProceed` is a computed getter that reads `gate_states.phq9_at_gate`
- If value ≥ 10, `canProceed` returns `false` regardless of any other state
- The proceed button widget observes this value; when `false`, it is replaced entirely — not just disabled. Disabled buttons can appear clickable.
- This logic must not be bypassable by navigation (router guard also checks gate pass status)

### Journal flat file storage

Journal content must never be written to Drift. The `JournalProvider` saves content to a file in `getExternalStorageDirectory()` (user-accessible; survives uninstall), then writes only the metadata row (`file_path`, `word_count`, `transcription_complete`) to `journal_entries`. Reading an entry means reading the flat file by path. If a file is missing (user deleted it), the entry row remains but content displays as unavailable.

Use a consistent filename scheme: `journal_<id>_<timestamp>.md`. Human-readable markdown format.

### Anonymous statistics extraction boundary

The `StatisticsExtractorService` must enforce its exclusion list in code, not just by convention. The service has no access to `JournalProvider`, `JournalEntriesTable`, or any audio/transcript field. It reads exclusively from: `assessment_results`, `longitudinal_metrics`, `practice_sessions` (excluding `notes_text` and `voice_transcript` fields), `phase_progress`, and `gate_states` (excluding `self_assessment_text`). The sanitized payload is written to `stats_queue` before any destination exists — the boundary is enforced at extraction time, not at submission time.

### Static content and database IDs

Practice IDs (`P1A`, `P5G`, etc.), assessment IDs (`TAS20`, `B5a`), template IDs (`T01`), and skill IDs (`S1.1`) are string constants. They are used as foreign keys in DB rows (`practice_sessions.practice_id`, etc.). These strings must be kept stable — changing them after app release would orphan existing user data. Define them once in `content/` and never change them.

---

## 15. Open Questions (inherited from app-design.md)

| # | Question | Impact |
|---|---|---|
| OQ3 | HR monitor — specific device compatibility list? | B7/B8 runner UI if device-specific quirks |
| OQ4 | Data storage — local only, or optional encrypted cloud backup? | `user_state` + `journal_entries` sensitivity; affects SettingsScreen |
| OQ5 | Safety signals — full stop-criteria text or summary card? | Length of `PracticeContent.safetySignals` list; `SafetyCard` widget design |
| OQ6 | Practices with no documented stop criteria — add minimal safety notes? | May require additions to `training-curriculum.md` before F7 fully implementable |

OQ3 and OQ4 can be deferred to Phase 6. OQ5 and OQ6 must be resolved before Phase 2 (practice sessions) to populate `PracticeContent.safetySignals` correctly.

---

*Source documents: all specs derived from `docs/` framework files and `docs/app-design.md`. This document defines architecture only — framework content and app design rationale remain in their respective source files.*

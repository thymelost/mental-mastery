# Mental Mastery — App Design Specification

**Status:** Draft v0.4 — architecture document published 2026-03-01
**Platform:** Android
**Framework:** Flutter (Dart) — Android-first, iOS-capable later
**Purpose:** Convert the Mental Mastery framework into a guided Android app experience.
**Source:** All specs derived from framework documents in `docs/`.

---

## Overview

The app is a **linear guided journey** through the Mental Mastery framework, with integrated tools that eliminate the need for external materials. It is not a document reader with extras bolted on — the framework content is embedded into a step-by-step experience.

**Core UX flow:**
```
Introduce user to the program
  → Walk them through training phase by phase
    → Provide tools at each step: training guidance, assessments, journaling
```

The framework already has everything: 41 skills, 9 phases, 35+ practices, assessment protocols, journal templates, gate checklists. The app's job is to make that a self-contained, self-administering experience — no paper, no external docs required.

---

## Core Sections

| Section | Description |
|---|---|
| **Onboarding** | Guided read-through of the full onboarding guide; gated entry |
| **Current Phase** | Active practice schedule, today's session, logging tools |
| **Assessments** | Phase exit assessments with guided protocols and auto-scoring |
| **Reference Library** | All 6 framework docs accessible via hamburger nav |
| **Journal** | Voice or text entries with auto-transcription |
| **Progress** | Phase timeline, longitudinal metrics, gate status |

---

## Feature Specifications

---

### F1 — Onboarding Gate

**Requirement:** User must read the complete onboarding guide before accessing any other part of the app.

**Behavior:**
- On first launch, open `onboarding-guide.md` content in a structured, scrollable view
- Track scroll depth and time on each section
- "Continue" is locked until all sections have been reached
- After completion, user confirms readiness — app unlocks Phase 0 entry
- Onboarding guide remains accessible at any time via Reference Library

**Rationale:** The guide explains why the sequence matters and what failure modes look like. Users who skip it miss the safety context.

---

### F2 — Reference Library (Hamburger Nav)

**Requirement:** All 6 framework documents accessible from anywhere in the app via a slide-out panel.

**Documents:**
1. Onboarding Guide
2. Quick Reference
3. Skill Taxonomy
4. Progression Model
5. Training Curriculum
6. Assessment Tools

*(Research Grounding and Scientific Foundation available as supplemental reads.)*

**Behavior:**
- Hamburger icon visible on all main screens
- Opens side panel with document list
- Each document opens in a full-screen reader with section navigation
- Reader does not interrupt active session state

---

### F3 — Voice Journal with Auto-Transcription

**Requirement:** All journal entries (T01–T19 templates) can be completed by voice. Physical writing not required.

**Behavior:**
- Each journal template has a voice-entry mode
- User speaks; app transcribes using on-device ASR only — no audio is ever transmitted
- Transcript is editable before saving
- Content saved as a human-readable flat file in user-accessible external storage (survives uninstall; user can back up independently)
- Only metadata stored in the database: date, phase, practice ID, template ID, word count, transcription status — no content, no audio paths
- Entries reviewable in the Journal section; app reads the flat file by stored path
- Text entry remains available as alternative

**Templates covered:** All 19 journal templates (T01–T19) from `assessment-tools.md`.

**ASR solution: offline on-device (confirmed)**
- Real-time / short utterances (assessment voice inputs): **Vosk** via `vosk_flutter` plugin
  - Fully offline, ~50–200MB English models, good accuracy for structured short speech
- Journal entries (longer free-form speech): record audio, then batch-transcribe via **Whisper on-device**
  - Tiny model (~75MB) gives acceptable accuracy; base model (~145MB) is significantly better
  - Transcription runs after recording stops — slight delay acceptable for journaling
- Desktop development reference: faster-whisper + CUDA at `C:\VoiceNotes\watch_transcribe.py`

---

### F4 — Assessment UIs with Guided Protocols

**Requirement:** Each assessment protocol has a dedicated UI with controls appropriate to that protocol type. Auto-scoring where possible.

**Assessment types and controls:**

| Protocol | UI Controls |
|---|---|
| **B1 Somatic Baseline** | Body map tap interface; voice narration option for sensations |
| **B2 Emotional Baseline** | Prompted voice entry per dimension; auto-logs to T02 template |
| **B3 Arousal Scale** | 0–10 slider; logs timestamp automatically |
| **B4 Thought Stream Log** | Voice stream with auto-transcription; tags thought types |
| **B5 Attention Sustaining** | Timer with tap-to-log distraction events; auto-calculates frequency and average gap |
| **B6 Distraction Resistance** | Same tap interface; auto-calculates resistance ratio |
| **B7 Heartbeat Detection** | Count input + time window; if HR monitor connected, compares to device reading instead of estimate |
| **B8 Interoceptive Accuracy** | Side-by-side: user count vs. device count; calculates accuracy score |
| **Validated instruments** | TAS-20, FFMQ, SMS-Mind, PHQ-9, DASS-21, RRS presented as guided questionnaires; auto-scored against published thresholds |

**Auto-scoring behavior:**
- Scores calculated immediately on submission
- Displayed with threshold context (e.g., "TAS-20: 58 — below alexithymia threshold of 61")
- Scores written to Master Progress Tracker automatically
- No interpretation or advice given — scores are data only

---

### F5 — Phase Tracking

**Requirement:** App records when each phase is entered and exited, and how long the user spent in it.

**Behavior:**
- Phase entry is logged with date when user confirms starting a phase
- Phase exit is logged when gate checklist is completed and passed
- Phase duration displayed in Progress section
- If a user does not pass a gate, phase continues — no forced progression
- Timeline view shows all phases with entry/exit dates and duration

---

### F6 — Phase Gate Logic

**Requirement:** At the end of each phase, the app presents the exit assessment checklist. If criteria are not met, unmet items are highlighted and the user is not advanced.

**Behavior:**
- Phase exit is triggered by user ("I'm ready to assess")
- App walks through the gate checklist for that phase transition (from `assessment-tools.md` Section D)
- Each criterion is checked off manually or pulled from logged assessment scores
- If all criteria met: gate opens, next phase unlocked, transition logged
- If criteria not met: app displays which specific items are unmet, with links to the relevant practices or assessments
- User can reassess at any time; no waiting period enforced by app (framework timescales are advisory)

**Gate checklists:** 9 transitions (Phase 0→1 through Phase 7→8), plus critical L2→L3 gate with additional PHQ-9 ≤9 and crisis indicator checks.

---

### F7 — Safety Signals

**Requirement:** Safety signals (stop/pause criteria) for each practice are surfaced when entering that practice section.

**Behavior:**
- Each practice entry screen shows a brief "Safety Check" card before the session begins
- Card lists the stop criteria for that practice (e.g., dissociation, flooding, persistent distress)
- User taps to acknowledge before proceeding
- Safety signals also available as a persistent reference (accessible mid-session)
- For practices with elevated risk (Layer 2/3), safety card is more prominent

**Source material:** Stop criteria already documented per phase in `training-curriculum.md`. Needs extraction and indexing per practice ID.

---

### F8 — Reference Material

**Requirement:** App includes the research basis for the framework and notes where confirming or conflicting evidence exists.

**Behavior:**
- `research-grounding.md` and `scientific-foundation.md` accessible in Reference Library
- Summary of source papers listed (the 7 papers reviewed)
- Inline [R] research notes from taxonomy surfaced where relevant (e.g., on practice detail screens)
- Known limits and caveats (from `scientific-foundation.md` Section 7) accessible from settings or about screen

**Pending:** Search for additional confirming/conflicting literature beyond the original 7 papers. This is a separate research task — flag for future update.

---

## Open Questions

| # | Question | Status | Notes |
|---|---|---|---|
| OQ3 | HR monitor integration — which devices/protocols? | **Open** | Bluetooth LE HRM profile is standard (Polar, Garmin, Wahoo all support it); affects B5/B7/B8 UI design. Defer to Phase 6. |
| OQ5 | Safety signals — full stop-criteria text or summary card? | **Open** | Must resolve before Phase 2 build. Tradeoff: completeness vs. friction before each session. |
| OQ6 | Practices with no documented stop criteria — add minimal safety notes? | **Open** | Must resolve before Phase 2 build. May need additions to training-curriculum.md before F7 can be fully implemented. |
| OQ7 | Anonymous statistics destination — where does the queue drain to? | **Open** | Extraction layer is designed and built in from the start; destination deferred. Resolve before Phase 6. |
| OQ8 | Third-tier thresholds for somatic (B1) and vocabulary (B4) tracks — what counts as 'priority'? | **Open** | Must resolve before Phase 0 assessment logic is built (Phase 4). Requires addition to progression-model.md. |
| ~~OQ1~~ | ~~Native vs. web vs. desktop?~~ | **Resolved** | Android, Flutter |
| ~~OQ2~~ | ~~ASR solution?~~ | **Resolved** | Offline: Vosk (real-time) + Whisper on-device (journals) |
| ~~OQ4~~ | ~~Data storage — local only or cloud sync?~~ | **Resolved** | Local only. No server transmission of any user data, ever. Journal content has no opt-in pathway for transmission. |

## Confirmed Tech Stack

| Concern | Solution |
|---|---|
| Platform | Android (Flutter / Dart) |
| UI framework | Flutter + Material 3 (dark-mode-first) |
| Local database | `drift` (type-safe SQLite wrapper; confirmed over sqflite) |
| Offline speech — real-time | `vosk_flutter` + English model |
| Offline speech — journaling | Whisper on-device (tiny/base model via whisper.cpp FFI) |
| Bluetooth LE (HR monitor) | `flutter_blue_plus` |
| State management | `riverpod` + `riverpod_annotation` (confirmed) |
| Navigation | `go_router` with Riverpod redirect guards |
| Charts | `fl_chart` |
| Markdown rendering | `flutter_markdown` |

**Full architecture:** see `docs/app-architecture.md` — folder structure, DB schema, screen inventory, provider hierarchy, gate logic, build order.

---

## Build Priority (Suggested)

Based on the framework's own sequencing logic — onboarding and Phase 0 first, then build outward:

1. F1 — Onboarding Gate
2. F2 — Reference Library
3. F5 — Phase Tracking
4. F6 — Phase Gate Logic
5. F4 — Assessment UIs (start with B-series protocols; validated instruments second)
6. F3 — Voice Journal
7. F7 — Safety Signals
8. F8 — Reference Material integration

---

*Source documents: all specs derived from `docs/` framework files. This document tracks app design only — do not modify framework content here.*

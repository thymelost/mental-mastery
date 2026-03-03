import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'daos/user_state_dao.dart';
import 'daos/phase_progress_dao.dart';
import 'daos/practice_sessions_dao.dart';
import 'daos/assessment_results_dao.dart';
import 'daos/journal_entries_dao.dart';
import 'daos/gate_states_dao.dart';
import 'daos/gate_criteria_states_dao.dart';
import 'daos/longitudinal_metrics_dao.dart';
import 'daos/scheduled_alarms_dao.dart';
import 'daos/stats_queue_dao.dart';

part 'app_database.g.dart';

// ─── Tables ────────────────────────────────────────────────────────────────

/// Singleton user state row (id = 1).
/// Created once after first launch; updated throughout the user's journey.
class UserStateTable extends Table {
  @override
  String get tableName => 'user_state';

  IntColumn get id => integer()();
  BoolColumn get onboardingComplete =>
      boolean().withDefault(const Constant(false))();
  IntColumn get currentPhase => integer().withDefault(const Constant(0))();

  // Per-metric track assignments. Null until Phase 0 assessments are complete.
  // Values: 'standard' | 'extended' | 'priority'
  // Scheduling weight order: emotional literacy > somatic > vocabulary.
  TextColumn get trackEmotionalLiteracy => text().nullable()();
  TextColumn get trackSomatic => text().nullable()();
  TextColumn get trackVocabulary => text().nullable()();

  // Phase 0 baseline scores (raw value; full data lives in assessment_results).
  IntColumn get tas20Score => integer().nullable()();
  TextColumn get valuesDocument => text().nullable()();
  TextColumn get selfDescription => text().nullable()();

  // Anonymous statistics. Default off; requested after Phase 0 completion.
  BoolColumn get statsOptIn =>
      boolean().withDefault(const Constant(false))();
  // Random local token generated once at opt-in. Never linked to any account.
  TextColumn get statsToken => text().nullable()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// One row per phase entered. Created when user confirms phase start.
class PhaseProgressTable extends Table {
  @override
  String get tableName => 'phase_progress';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get phaseNumber => integer()();
  // status: 'active' | 'gate_pending' | 'complete'
  TextColumn get status =>
      text().withDefault(const Constant('active'))();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  IntColumn get weekNumber => integer().withDefault(const Constant(1))();
  // JSON map of domain → added weeks after a failed gate (e.g. {"somatic": 4}).
  // Set when gate attempt fails; cleared when gate passes.
  TextColumn get extensionsJson => text().nullable()();
}

/// One row per completed practice session.
class PracticeSessionsTable extends Table {
  @override
  String get tableName => 'practice_sessions';

  IntColumn get id => integer().autoIncrement()();
  // Matches PracticeContent.id (e.g. 'P1A').
  TextColumn get practiceId => text()();
  IntColumn get phaseNumber => integer()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();
  IntColumn get durationSeconds => integer().nullable()();
  // Attention drift tracking.
  IntColumn get driftCount => integer().withDefault(const Constant(0))();
  // JSON array of tap timestamps in seconds from session start.
  TextColumn get driftTapLog => text().nullable()();
  // Arousal scale 0–10; ±2 point error tolerance per framework spec.
  RealColumn get arousalBefore => real().nullable()();
  RealColumn get arousalAfter => real().nullable()();
  // HR monitor readings in BPM; null if no monitor connected.
  RealColumn get hrBefore => real().nullable()();
  RealColumn get hrAfter => real().nullable()();
  // Phase 7+ only: 0–1 behavioral relevance score (I1.4 Practice Quality Monitoring).
  RealColumn get qualityScore => real().nullable()();
  TextColumn get notesText => text().nullable()();
  // Raw Whisper transcript before user editing; not included in stats extraction.
  TextColumn get voiceTranscript => text().nullable()();
  BoolColumn get safetyAcknowledged =>
      boolean().withDefault(const Constant(false))();
}

/// One row per assessment administration.
/// Append-only by policy — rows are never edited or deleted after insert.
class AssessmentResultsTable extends Table {
  @override
  String get tableName => 'assessment_results';

  IntColumn get id => integer().autoIncrement()();
  // Matches AssessmentContent.id (e.g. 'TAS20', 'B5', 'B5a').
  TextColumn get assessmentId => text()();
  IntColumn get phaseNumber => integer()();
  DateTimeColumn get administeredAt => dateTime()();
  // rawScores: JSON object; format varies by assessment type.
  TextColumn get rawScores => text()();
  RealColumn get totalScore => real().nullable()();
  // JSON object of subscale breakdowns where applicable (e.g. TAS-20 DIF/DDF/EOT).
  TextColumn get subscaleScores => text().nullable()();
  // B8 metadata: environment and cognitive load conditions.
  TextColumn get environmentType => text().nullable()();
  TextColumn get loadType => text().nullable()();
  // B7/B8: actual HR from monitor vs. user's counted heartbeat estimate.
  RealColumn get hrDeviceCount => real().nullable()();
  RealColumn get hrUserEstimate => real().nullable()();
}

/// Journal entry metadata only.
/// Content lives as a flat file in user-accessible external storage.
/// The database never stores journal text, audio paths, or transcripts.
class JournalEntriesTable extends Table {
  @override
  String get tableName => 'journal_entries';

  IntColumn get id => integer().autoIncrement()();
  // Matches JournalTemplate.id (e.g. 'T01'); null for freeform entries.
  TextColumn get templateId => text().nullable()();
  IntColumn get phaseNumber => integer()();
  // If entry is linked to a specific practice session.
  TextColumn get practiceId => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  // Absolute path to the flat file in user-accessible external storage.
  // Files survive app uninstall; user can back up independently.
  TextColumn get filePath => text()();
  IntColumn get wordCount => integer().nullable()();
  BoolColumn get transcriptionComplete =>
      boolean().withDefault(const Constant(false))();
}

/// Gate-level state. One row per gate (gates 1–9).
/// Per-criterion evaluation state lives in gate_criteria_states.
class GateStatesTable extends Table {
  @override
  String get tableName => 'gate_states';

  IntColumn get id => integer().autoIncrement()();
  // 1–9 (Gate 1 = Phase 0→1, Gate 9 = Phase 7→8).
  IntColumn get gateNumber => integer()();
  // status: 'not_started' | 'in_progress' | 'passed' | 'failed_retry'
  TextColumn get status =>
      text().withDefault(const Constant('not_started'))();
  IntColumn get attemptCount =>
      integer().withDefault(const Constant(0))();
  // L2→L3 gate only. PHQ-9 score at gate attempt; ≥ 10 is a hard block.
  IntColumn get phq9AtGate => integer().nullable()();
  // L2→L3 gate only. All 9 crisis indicators confirmed clear by user.
  BoolColumn get crisisIndicatorsClear => boolean().nullable()();
  // Written self-assessment text (required at certain gates).
  TextColumn get selfAssessmentText => text().nullable()();
  TextColumn get blockReason => text().nullable()();
  DateTimeColumn get lastAttemptedAt => dateTime().nullable()();
  DateTimeColumn get passedAt => dateTime().nullable()();
}

/// Per-criterion evaluation state for each gate attempt.
/// Gate criteria definitions (what each criterion requires) live in static
/// content at content/gates/all_gates.dart — never stored here.
class GateCriteriaStatesTable extends Table {
  @override
  String get tableName => 'gate_criteria_states';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get gateNumber => integer()();
  // Matches GateCriterion.id from static content.
  TextColumn get criterionId => text()();
  // Which measurement track: 'A' (self-reported) or 'B' (app-administered).
  TextColumn get track => text()();
  // Framework domain for this criterion.
  // Values: 'emotional_literacy' | 'somatic' | 'vocabulary' | 'attention' | 'integration'
  TextColumn get domain => text()();
  // status: 'pending' | 'auto_pass' | 'auto_fail' | 'manual_checked'
  TextColumn get status =>
      text().withDefault(const Constant('pending'))();
  // Recorded value at evaluation time (numeric or label; stored as text for display).
  TextColumn get value => text().nullable()();
  DateTimeColumn get evaluatedAt => dateTime().nullable()();
  // Which attempt number this state belongs to (increments on retry).
  IntColumn get attemptNumber =>
      integer().withDefault(const Constant(1))();
}

/// Metric snapshots over time. Written alongside assessment_results inserts.
/// Drives trajectory charts in the Progress screen.
class LongitudinalMetricsTable extends Table {
  @override
  String get tableName => 'longitudinal_metrics';

  IntColumn get id => integer().autoIncrement()();
  // e.g. 'TAS20_total', 'FFMQ_observe', 'HBD_accuracy', 'recovery_time_avg'
  TextColumn get metricId => text()();
  IntColumn get phaseNumber => integer()();
  DateTimeColumn get recordedAt => dateTime()();
  RealColumn get value => real()();
  // FK to assessment_results.id if this metric was derived from an assessment.
  IntColumn get sourceAssessmentId => integer().nullable()();
}

/// B6 meta-attention probes, emotion check-ins, and practice reminders.
/// Notification permission is requested after Phase 0 completion, not at install.
class ScheduledAlarmsTable extends Table {
  @override
  String get tableName => 'scheduled_alarms';

  IntColumn get id => integer().autoIncrement()();
  // 'meta_attention_probe' | 'emotion_checkin' | 'practice_reminder'
  TextColumn get alarmType => text()();
  DateTimeColumn get scheduledFor => dateTime()();
  DateTimeColumn get firedAt => dateTime().nullable()();
  DateTimeColumn get respondedAt => dateTime().nullable()();
  // JSON of user's response (probes and check-ins); null for practice reminders.
  TextColumn get responseJson => text().nullable()();
  IntColumn get phaseNumber => integer()();
}

/// Sanitized anonymous statistics payload queue.
/// Append-only. Content and transcripts never appear here.
/// Drained by StatsSubmitterService once a destination is configured.
class StatsQueueTable extends Table {
  @override
  String get tableName => 'stats_queue';

  IntColumn get id => integer().autoIncrement()();
  // Versioned from day one; required for destination schema compatibility.
  IntColumn get schemaVersion =>
      integer().withDefault(const Constant(1))();
  // 'assessment' | 'phase_transition' | 'gate_passage' | 'session'
  TextColumn get eventType => text()();
  TextColumn get payloadJson => text()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  // Null until destination is configured and submission succeeds.
  DateTimeColumn get submittedAt => dateTime().nullable()();
}

// ─── Database ──────────────────────────────────────────────────────────────

@DriftDatabase(
  tables: [
    UserStateTable,
    PhaseProgressTable,
    PracticeSessionsTable,
    AssessmentResultsTable,
    JournalEntriesTable,
    GateStatesTable,
    GateCriteriaStatesTable,
    LongitudinalMetricsTable,
    ScheduledAlarmsTable,
    StatsQueueTable,
  ],
  daos: [
    UserStateDao,
    PhaseProgressDao,
    PracticeSessionsDao,
    AssessmentResultsDao,
    JournalEntriesDao,
    GateStatesDao,
    GateCriteriaStatesDao,
    LongitudinalMetricsDao,
    ScheduledAlarmsDao,
    StatsQueueDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (m, from, to) async {
      // Development migration: wipe and recreate all tables on schema bump.
      // Replace with additive column migrations before any production release.
      for (final table in allTables) {
        await m.deleteTable(table.actualTableName);
      }
      await m.createAll();
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'mental_mastery.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

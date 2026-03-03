import 'dart:io';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../../core/database/drift_provider.dart';
import '../../core/database/app_database.dart';
import '../../content/templates/template_model.dart';
import '../../content/templates/all_templates.dart';

// ─── Template lookup ────────────────────────────────────────────────────────

JournalTemplate? templateById(String id) {
  try {
    return kTemplates.firstWhere((t) => t.id == id);
  } catch (_) {
    return null;
  }
}

// ─── Journal entry state ────────────────────────────────────────────────────

@immutable
class JournalEntryDraft {
  const JournalEntryDraft({
    this.templateId,
    this.practiceId,
    this.fieldValues = const {},
    this.isSaving = false,
  });

  final String? templateId;
  final String? practiceId;
  /// Map of field id → text content.
  final Map<String, String> fieldValues;
  final bool isSaving;

  JournalEntryDraft copyWith({
    String? templateId,
    String? practiceId,
    Map<String, String>? fieldValues,
    bool? isSaving,
  }) {
    return JournalEntryDraft(
      templateId: templateId ?? this.templateId,
      practiceId: practiceId ?? this.practiceId,
      fieldValues: fieldValues ?? this.fieldValues,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

class JournalNotifier extends StateNotifier<JournalEntryDraft> {
  JournalNotifier(this._ref) : super(const JournalEntryDraft());

  final Ref _ref;

  void startEntry({String? templateId, String? practiceId}) {
    state = JournalEntryDraft(
      templateId: templateId,
      practiceId: practiceId,
    );
  }

  void setField(String fieldId, String value) {
    state = state.copyWith(
      fieldValues: {...state.fieldValues, fieldId: value},
    );
  }

  /// Saves the entry: writes content to a flat file, inserts metadata to Drift.
  /// Returns the new entry id on success, or null on failure.
  Future<int?> saveEntry({required int phaseNumber}) async {
    if (state.isSaving) return null;
    state = state.copyWith(isSaving: true);

    try {
      final content = _buildMarkdown(phaseNumber);
      final filePath = await _writeFile(content);
      final wordCount = _countWords(content);

      final db = _ref.read(appDatabaseProvider);
      final id = await db.journalEntriesDao.insertEntry(
        JournalEntriesTableCompanion.insert(
          templateId: Value(state.templateId),
          phaseNumber: phaseNumber,
          practiceId: Value(state.practiceId),
          filePath: filePath,
          wordCount: Value(wordCount),
        ),
      );

      state = const JournalEntryDraft();
      return id;
    } catch (_) {
      state = state.copyWith(isSaving: false);
      return null;
    }
  }

  void reset() {
    state = const JournalEntryDraft();
  }

  // ── Private helpers ──────────────────────────────────────────────────────

  String _buildMarkdown(int phaseNumber) {
    final template = state.templateId != null
        ? templateById(state.templateId!)
        : null;
    final now = DateTime.now();
    final dateStr =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

    final buffer = StringBuffer();
    buffer.writeln(
      '# ${template?.name ?? 'Journal Entry'} — $dateStr',
    );
    buffer.writeln('Phase: $phaseNumber');
    buffer.writeln();

    if (template != null) {
      for (final field in template.fields) {
        buffer.writeln('## ${field.label}');
        buffer.writeln(state.fieldValues[field.id] ?? '');
        buffer.writeln();
      }
    } else {
      // Freeform entry
      buffer.writeln(state.fieldValues['content'] ?? '');
    }

    return buffer.toString();
  }

  Future<String> _writeFile(String content) async {
    final dir = await _journalDirectory();
    final now = DateTime.now();
    final timestamp = '${now.millisecondsSinceEpoch}';
    final templatePart = state.templateId?.toLowerCase() ?? 'free';
    final filename = 'journal_${templatePart}_$timestamp.md';
    final file = File(p.join(dir.path, filename));
    await file.writeAsString(content, flush: true);
    return file.path;
  }

  Future<Directory> _journalDirectory() async {
    // Use external storage so files are user-accessible via file manager.
    // Falls back to app documents if external is unavailable (e.g. emulator).
    Directory? base;
    try {
      base = await getExternalStorageDirectory();
    } catch (_) {
      base = null;
    }
    base ??= await getApplicationDocumentsDirectory();

    final journalDir = Directory(p.join(base.path, 'journals'));
    if (!journalDir.existsSync()) {
      await journalDir.create(recursive: true);
    }
    return journalDir;
  }

  int _countWords(String text) {
    return text.trim().isEmpty
        ? 0
        : text.trim().split(RegExp(r'\s+')).length;
  }
}

final journalNotifierProvider =
    StateNotifierProvider<JournalNotifier, JournalEntryDraft>(
  (ref) => JournalNotifier(ref),
);

/// A single field within a journal template.
class TemplateField {
  const TemplateField({
    required this.id,
    required this.label,
    required this.inputType,
    this.placeholder,
    this.voiceEnabled = true,
  });

  final String id;
  final String label;
  // 'text' | 'scale' | 'checklist' | 'timestamp'
  final String inputType;
  final String? placeholder;
  final bool voiceEnabled;
}

/// A journal template (T01–T19).
class JournalTemplate {
  const JournalTemplate({
    required this.id,
    required this.name,
    required this.practiceId,
    required this.fields,
  });

  final String id;         // 'T01'–'T19'
  final String name;
  final String practiceId; // Which practice this template supports
  final List<TemplateField> fields;
}

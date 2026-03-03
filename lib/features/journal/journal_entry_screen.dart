import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/providers.dart';
import '../../core/theme/tokens.dart';
import '../../core/widgets/voice_input_field.dart';
import '../../content/templates/template_model.dart';
import 'journal_provider.dart';

/// New journal entry screen. Accepts an optional templateId query param.
/// Freeform entry when templateId is null.
class JournalEntryScreen extends ConsumerStatefulWidget {
  const JournalEntryScreen({super.key, this.templateId});

  final String? templateId;

  @override
  ConsumerState<JournalEntryScreen> createState() => _JournalEntryScreenState();
}

class _JournalEntryScreenState extends ConsumerState<JournalEntryScreen> {
  @override
  void initState() {
    super.initState();
    // Initialise draft on next frame so provider is ready.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(journalNotifierProvider.notifier).startEntry(
            templateId: widget.templateId,
          );
    });
  }

  Future<void> _save() async {
    final phaseNumber = ref.read(currentPhaseProvider);
    final id = await ref
        .read(journalNotifierProvider.notifier)
        .saveEntry(phaseNumber: phaseNumber);
    if (mounted) {
      if (id != null) {
        context.go('/journal/$id');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to save entry. Try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final draft = ref.watch(journalNotifierProvider);
    final template =
        widget.templateId != null ? templateById(widget.templateId!) : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(template?.name ?? 'New Entry'),
        actions: [
          TextButton(
            onPressed: draft.isSaving ? null : _save,
            child: draft.isSaving
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(spaceLg),
        child: template != null
            ? _TemplateForm(template: template)
            : _FreeformField(),
      ),
    );
  }
}

// ─── Template form ────────────────────────────────────────────────────────────

class _TemplateForm extends ConsumerWidget {
  const _TemplateForm({required this.template});
  final JournalTemplate template;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${template.fields.length} fields  ·  ${template.id}',
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: spaceLg),
        ...template.fields.asMap().entries.map((entry) {
          final field = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: spaceLg),
            child: _FieldWidget(field: field),
          );
        }),
        const SizedBox(height: 40),
      ],
    );
  }
}

class _FieldWidget extends ConsumerWidget {
  const _FieldWidget({required this.field});
  final TemplateField field;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(journalNotifierProvider.notifier);

    switch (field.inputType) {
      case 'scale':
        return _ScaleField(field: field, onChanged: (v) => notifier.setField(field.id, v));
      case 'timestamp':
        return _TimestampField(field: field, onChanged: (v) => notifier.setField(field.id, v));
      case 'checklist':
        return _ChecklistField(field: field, onChanged: (v) => notifier.setField(field.id, v));
      default:
        return VoiceInputField(
          label: field.label,
          placeholder: field.placeholder,
          voiceEnabled: field.voiceEnabled,
          onChanged: (v) => notifier.setField(field.id, v),
        );
    }
  }
}

class _ScaleField extends StatefulWidget {
  const _ScaleField({required this.field, required this.onChanged});
  final TemplateField field;
  final ValueChanged<String> onChanged;

  @override
  State<_ScaleField> createState() => _ScaleFieldState();
}

class _ScaleFieldState extends State<_ScaleField> {
  double _value = 5.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.field.label, style: theme.textTheme.labelLarge),
        Row(
          children: [
            Text('0', style: theme.textTheme.bodySmall),
            Expanded(
              child: Slider(
                value: _value,
                min: 0,
                max: 10,
                divisions: 20,
                activeColor: primaryTeal,
                inactiveColor: surfaceVariantDark,
                onChanged: (v) {
                  setState(() => _value = v);
                  widget.onChanged(v.toStringAsFixed(1));
                },
              ),
            ),
            Text('10', style: theme.textTheme.bodySmall),
          ],
        ),
        Center(
          child: Text(
            _value.toStringAsFixed(1),
            style: theme.textTheme.titleLarge?.copyWith(
              color: primaryTeal,
              fontFamily: 'RobotoMono',
            ),
          ),
        ),
      ],
    );
  }
}

class _TimestampField extends StatelessWidget {
  const _TimestampField({required this.field, required this.onChanged});
  final TemplateField field;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final now = DateTime.now();
    final ts =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    onChanged(ts);

    return Row(
      children: [
        Text(field.label, style: theme.textTheme.labelLarge),
        const Spacer(),
        Text(
          ts,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontFamily: 'RobotoMono',
            color: primaryTeal,
          ),
        ),
        const SizedBox(width: spaceSm),
        Icon(Icons.access_time, size: 16, color: onSurfaceMuted),
      ],
    );
  }
}

class _ChecklistField extends StatefulWidget {
  const _ChecklistField({required this.field, required this.onChanged});
  final TemplateField field;
  final ValueChanged<String> onChanged;

  @override
  State<_ChecklistField> createState() => _ChecklistFieldState();
}

class _ChecklistFieldState extends State<_ChecklistField> {
  // Placeholder checklist items — real items come from template placeholder text
  // split on semicolons when provided, otherwise shows a single freeform check.
  late final List<String> _items;
  final Set<int> _checked = {};

  @override
  void initState() {
    super.initState();
    final raw = widget.field.placeholder ?? '';
    _items = raw.isNotEmpty
        ? raw.split(';').map((s) => s.trim()).where((s) => s.isNotEmpty).toList()
        : ['(no items defined)'];
  }

  void _toggle(int index) {
    setState(() {
      if (_checked.contains(index)) {
        _checked.remove(index);
      } else {
        _checked.add(index);
      }
    });
    final checkedLabels = _checked.map((i) => _items[i]).join('; ');
    widget.onChanged(checkedLabels);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.field.label, style: theme.textTheme.labelLarge),
        const SizedBox(height: spaceXs),
        ..._items.asMap().entries.map(
              (e) => CheckboxListTile(
                dense: true,
                value: _checked.contains(e.key),
                onChanged: (_) => _toggle(e.key),
                title: Text(e.value, style: theme.textTheme.bodyMedium),
                activeColor: primaryTeal,
                contentPadding: EdgeInsets.zero,
              ),
            ),
      ],
    );
  }
}

// ─── Freeform ─────────────────────────────────────────────────────────────────

class _FreeformField extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return VoiceInputField(
      label: 'Entry',
      placeholder: 'Write anything…',
      minLines: 8,
      maxLines: 32,
      voiceEnabled: true,
      onChanged: (v) =>
          ref.read(journalNotifierProvider.notifier).setField('content', v),
    );
  }
}

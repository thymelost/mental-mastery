import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../content/assessments/all_assessments.dart';
import '../../content/assessments/assessment_model.dart';
import '../../content/assessments/questionnaire_definitions.dart';
import '../../core/providers.dart';
import '../../core/theme/tokens.dart';
import 'assessment_provider.dart';
import 'runners/questionnaire_runner.dart';
import 'runners/score_entry_runner.dart';
import 'runners/b1_body_map_runner.dart';
import 'runners/b2_hbd_runner.dart';
import 'runners/b3_arousal_runner.dart';
import 'runners/b4_vocab_runner.dart';
import 'runners/b5_attention_runner.dart';
import 'runners/b5a_direction_runner.dart';
import 'runners/b5b_distraction_runner.dart';
import 'runners/b6_probe_runner.dart';
import 'runners/b7_dual_presence_runner.dart';
import 'runners/b8_load_matrix_runner.dart';
import 'runners/b9_boundary_runner.dart';
import 'runners/b10_state_shifting_runner.dart';
import 'runners/b11_calibration_runner.dart';

class AssessmentRunnerScreen extends ConsumerStatefulWidget {
  const AssessmentRunnerScreen({super.key, required this.assessmentId});
  final String assessmentId;

  @override
  ConsumerState<AssessmentRunnerScreen> createState() =>
      _AssessmentRunnerScreenState();
}

class _AssessmentRunnerScreenState
    extends ConsumerState<AssessmentRunnerScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(assessmentNotifierProvider.notifier)
          .begin(widget.assessmentId);
    });
  }

  Future<void> _onComplete(
    Map<String, dynamic> rawScores,
    double? totalScore,
    Map<String, double>? subscaleScores,
  ) async {
    final phaseNumber = ref.read(currentPhaseProvider);
    final id = await ref.read(assessmentNotifierProvider.notifier).submit(
          phaseNumber: phaseNumber,
          rawScores: rawScores,
          totalScore: totalScore,
          subscaleScores: subscaleScores,
        );
    if (mounted) {
      if (id != null) {
        context.go('/assessment/${widget.assessmentId}/result/$id');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to save result. Try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final assessment = assessmentById(widget.assessmentId);

    if (assessment == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Assessment')),
        body: const Center(child: Text('Assessment not found.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(assessment.name),
        leading: IconButton(
          icon: const Icon(Icons.close),
          tooltip: 'Discard and return',
          onPressed: () => _confirmDiscard(context),
        ),
      ),
      body: _buildRunner(assessment),
    );
  }

  Widget _buildRunner(AssessmentContent assessment) {
    switch (assessment.runner) {
      case AssessmentRunner.questionnaire:
        final def = kQuestionnaireDefs[assessment.id];
        if (def == null) {
          return _ErrorView(
              message: 'No questionnaire definition found for ${assessment.id}.');
        }
        return QuestionnaireRunner(
          assessment: assessment,
          definition: def,
          onComplete: _onComplete,
        );

      case AssessmentRunner.scoreEntry:
        return ScoreEntryRunner(
          assessment: assessment,
          onComplete: _onComplete,
        );

      case AssessmentRunner.b1BodyMap:
        return B1BodyMapRunner(
            assessment: assessment, onComplete: _onComplete);

      case AssessmentRunner.b2Hbd:
        return B2HbdRunner(assessment: assessment, onComplete: _onComplete);

      case AssessmentRunner.b3Arousal:
        return B3ArousalRunner(
            assessment: assessment, onComplete: _onComplete);

      case AssessmentRunner.b4Vocab:
        return B4VocabRunner(
            assessment: assessment, onComplete: _onComplete);

      case AssessmentRunner.b5Attention:
        return B5AttentionRunner(
            assessment: assessment, onComplete: _onComplete);

      case AssessmentRunner.b5aDirection:
        return B5aDirectionRunner(
            assessment: assessment, onComplete: _onComplete);

      case AssessmentRunner.b5bDistraction:
        return B5bDistractionRunner(
            assessment: assessment, onComplete: _onComplete);

      case AssessmentRunner.b6Probe:
        return B6ProbeRunner(
            assessment: assessment, onComplete: _onComplete);

      case AssessmentRunner.b7DualPresence:
        return B7DualPresenceRunner(
            assessment: assessment, onComplete: _onComplete);

      case AssessmentRunner.b8LoadMatrix:
        return B8LoadMatrixRunner(
            assessment: assessment, onComplete: _onComplete);

      case AssessmentRunner.b9Boundary:
        return B9BoundaryRunner(
            assessment: assessment, onComplete: _onComplete);

      case AssessmentRunner.b10StateShifting:
        return B10StateShiftingRunner(
            assessment: assessment, onComplete: _onComplete);

      case AssessmentRunner.b11Calibration:
        return B11CalibrationRunner(
            assessment: assessment, onComplete: _onComplete);
    }
  }

  Future<void> _confirmDiscard(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Discard session?'),
        content: const Text(
            'Your responses will not be saved. Return to Assessments?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Discard',
                style: TextStyle(color: errorRed)),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      ref.read(assessmentNotifierProvider.notifier).reset();
      context.go('/assessments');
    }
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(spaceLg),
        child: Text(message,
            style: TextStyle(color: errorRed),
            textAlign: TextAlign.center),
      ),
    );
  }
}

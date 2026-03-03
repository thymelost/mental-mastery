import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/drift_provider.dart';
import 'stats_extractor_service.dart';
import 'stats_submitter_service.dart';

final _dioProvider = Provider<Dio>((ref) => Dio());

final statsExtractorProvider = Provider<StatsExtractorService>((ref) {
  return StatsExtractorService(ref.read(appDatabaseProvider));
});

final statsSubmitterProvider = Provider<StatsSubmitterService>((ref) {
  return StatsSubmitterService(
    ref.read(appDatabaseProvider),
    ref.read(_dioProvider),
  );
});

/// Convenience: enqueue an event then fire-and-forget submission.
/// Call with unawaited() — callers should not block on this.
Future<void> enqueueAndSubmit({
  required StatsExtractorService extractor,
  required StatsSubmitterService submitter,
  required Future<void> Function(StatsExtractorService) enqueue,
}) async {
  await enqueue(extractor);
  // Submission is best-effort; failures stay queued for next attempt.
  submitter.submitPendingBatch().ignore();
}

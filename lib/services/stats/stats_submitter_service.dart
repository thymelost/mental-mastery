import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';

import '../../core/database/app_database.dart';

/// Drains the stats_queue table to a GitHub repository via the Contents API.
///
/// Configuration is injected at build time via --dart-define:
///   STATS_GITHUB_OWNER  — repository owner (user or org)
///   STATS_GITHUB_REPO   — repository name
///   STATS_GITHUB_TOKEN  — fine-grained PAT with contents:write on the repo
///
/// Each pending event becomes a new file:
///   submissions/YYYY-MM/{16-char-hex-id}.json
///
/// If any env var is empty the service is unconfigured and is a no-op.
/// Failed submissions remain pending and are retried on the next call.
class StatsSubmitterService {
  StatsSubmitterService(this._db, this._dio);

  final AppDatabase _db;
  final Dio _dio;

  static const _owner =
      String.fromEnvironment('STATS_GITHUB_OWNER');
  static const _repo =
      String.fromEnvironment('STATS_GITHUB_REPO');
  static const _token =
      String.fromEnvironment('STATS_GITHUB_TOKEN');

  bool get isConfigured =>
      _owner.isNotEmpty && _repo.isNotEmpty && _token.isNotEmpty;

  /// Fetches all pending events and attempts to submit them.
  /// Marks each successfully submitted event so it is not retried.
  Future<void> submitPendingBatch() async {
    if (!isConfigured) return;

    final pending = await _db.statsQueueDao.getPendingBatch();
    if (pending.isEmpty) return;

    final submitted = <int>[];
    for (final event in pending) {
      if (await _submitEvent(event)) {
        submitted.add(event.id);
      }
    }

    if (submitted.isNotEmpty) {
      await _db.statsQueueDao.markSubmitted(submitted);
    }
  }

  Future<bool> _submitEvent(StatsQueueTableData event) async {
    final payload = {
      'schemaVersion': event.schemaVersion,
      'eventType': event.eventType,
      'payload': jsonDecode(event.payloadJson),
      'createdAt': event.createdAt.toUtc().toIso8601String(),
    };
    final content = base64Encode(utf8.encode(jsonEncode(payload)));
    final path =
        'submissions/${_monthFolder(event.createdAt)}/${_fileId()}.json';

    try {
      final response = await _dio.put(
        'https://api.github.com/repos/$_owner/$_repo/contents/$path',
        data: {
          'message': 'stats: ${event.eventType}',
          'content': content,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $_token',
            'Accept': 'application/vnd.github+json',
            'X-GitHub-Api-Version': '2022-11-28',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );
      // 201 = created; 422 = file already exists (treat as submitted).
      return response.statusCode == 201 || response.statusCode == 422;
    } catch (_) {
      return false;
    }
  }

  String _monthFolder(DateTime dt) =>
      '${dt.year}-${dt.month.toString().padLeft(2, '0')}';

  /// 16 random hex chars — unique enough for a filename.
  String _fileId() {
    final rng = Random.secure();
    return List.generate(16, (_) => rng.nextInt(16).toRadixString(16))
        .join();
  }
}

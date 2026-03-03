import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_database.dart';

/// Singleton database provider. Drift manages its own connection lifecycle.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

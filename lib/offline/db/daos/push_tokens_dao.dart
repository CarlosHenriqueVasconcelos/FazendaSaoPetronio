import 'package:drift/drift.dart';
import '../app_database.dart';


part 'push_tokens_dao.g.dart';


@DriftAccessor(tables: [PushTokens])
class PushTokensDao extends DatabaseAccessor<AppDatabase> with _$PushTokensDaoMixin {
PushTokensDao(AppDatabase db) : super(db);


Stream<List<PushToken>> watchAll() => select(pushTokens).watch();
Future<void> upsertToken(String id, String token, {String? platform, Map<String, dynamic>? deviceInfo}) async {
await into(pushTokens).insertOnConflictUpdate(
PushTokensCompanion(
id: Value(id),
token: Value(token),
platform: Value(platform),
deviceInfo: Value(deviceInfo),
),
);
}
}
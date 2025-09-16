import 'package:drift/drift.dart';
import '../app_database.dart';


part 'reports_dao.g.dart';


@DriftAccessor(tables: [Reports])
class ReportsDao extends DatabaseAccessor<AppDatabase> with _$ReportsDaoMixin {
ReportsDao(AppDatabase db) : super(db);
Stream<List<Report>> watchAll() => select(reports).watch();
Future<void> insertReport(ReportsCompanion data) => into(reports).insert(data);
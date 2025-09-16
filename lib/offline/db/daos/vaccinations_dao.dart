import 'package:drift/drift.dart';
import '../app_database.dart';


part 'vaccinations_dao.g.dart';


@DriftAccessor(tables: [Vaccinations, Animals])
class VaccinationsDao extends DatabaseAccessor<AppDatabase> with _$VaccinationsDaoMixin {
VaccinationsDao(AppDatabase db) : super(db);


Stream<List<Vaccination>> watchPendingByDateRange(DateTime from, DateTime to) {
final q = select(vaccinations)
..where((v) => v.status.equals('Agendada') & v.scheduledDate.isBetweenValues(from, to))
..orderBy([(v) => OrderingTerm.asc(v.scheduledDate)]);
return q.watch();
}


Future<void> schedule(VaccinationsCompanion data) => into(vaccinations).insert(data);


Future<int> markApplied(String id, DateTime appliedAt) {
return (update(vaccinations)..where((v) => v.id.equals(id))).write(
VaccinationsCompanion(
appliedDate: Value(appliedAt),
status: const Value('Aplicada'),
updatedAt: Value(DateTime.now().toUtc()),
),
);
}


Future<int> cancel(String id) {
return (update(vaccinations)..where((v) => v.id.equals(id))).write(
const VaccinationsCompanion(status: Value('Cancelada')),
);
}
}
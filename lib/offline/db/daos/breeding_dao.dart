import 'package:drift/drift.dart';
import '../app_database.dart';


part 'breeding_dao.g.dart';


@DriftAccessor(tables: [BreedingRecords, Animals])
class BreedingDao extends DatabaseAccessor<AppDatabase> with _$BreedingDaoMixin {
BreedingDao(AppDatabase db) : super(db);


Stream<List<BreedingRecord>> watchActive() {
final q = select(breedingRecords)
..where((b) => b.status.equals('Cobertura') | b.status.equals('ativa'))
..orderBy([(b) => OrderingTerm.asc(b.expectedBirth.nullsLast)]);
return q.watch();
}


Future<void> insertRecord(BreedingRecordsCompanion data) => into(breedingRecords).insert(data);


Future<int> updateStatus(String id, String status) {
return (update(breedingRecords)..where((b) => b.id.equals(id))).write(
BreedingRecordsCompanion(status: Value(status), updatedAt: Value(DateTime.now().toUtc())),
);
}
}
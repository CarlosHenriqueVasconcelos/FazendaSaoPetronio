import 'package:drift/drift.dart';
import '../app_database.dart';


part 'animals_dao.g.dart';


@DriftAccessor(tables: [Animals, Vaccinations])
class AnimalsDao extends DatabaseAccessor<AppDatabase> with _$AnimalsDaoMixin {
AnimalsDao(AppDatabase db) : super(db);


// Listagem com último status de vacinação (via subconsulta)
Stream<List<AnimalWithNextVaccine>> watchAllWithNextVaccine() {
final nextVaccine = select(vaccinations)
..where((v) => v.appliedDate.isNull())
..orderBy([(v) => OrderingTerm.asc(v.scheduledDate)]);


// Junta animals + próxima vacina pendente
final query = select(animals).join([
leftOuterJoin(
nextVaccine.as('nv'),
nextVaccine.alias('nv').animalId.equalsExp(animals.id),
),
]);


return query.watch().map((rows) {
return rows.map((row) {
final a = row.readTable(animals);
final nv = row.readTableOrNull(vaccinations);
return AnimalWithNextVaccine(a: a, nextVaccine: nv);
}).toList(growable: false);
});
}


Stream<List<Animal>> watchAll() => (select(animals)
..orderBy([(a) => OrderingTerm.asc(a.code)])).
watch();


Future<Animal?> findById(String id) => (select(animals)..where((a) => a.id.equals(id))).getSingleOrNull();


Future<void> insertAnimal(AnimalsCompanion data) => into(animals).insert(data);


Future<int> updateAnimal(AnimalsCompanion data) => update(animals).write(data);


Future<int> deleteById(String id) => (delete(animals)..where((a) => a.id.equals(id))).go();
}


class AnimalWithNextVaccine {
final Animal a;
final Vaccination? nextVaccine;
AnimalWithNextVaccine({required this.a, required this.nextVaccine});
}
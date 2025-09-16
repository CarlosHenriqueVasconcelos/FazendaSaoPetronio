import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../db/app_database.dart';

class OfflineRepository {
  OfflineRepository(this.db);

  final AppDatabase db;
  final _uuid = const Uuid();

  /// ------------------------------
  /// ANIMAIS
  /// ------------------------------
  Stream<List<Animal>> watchAnimals() {
    final q = db.select(db.animals)
      ..orderBy([(t) => OrderingTerm.asc(t.code)]);
    return q.watch();
  }

  Future<void> createAnimal({
    required String code,
    required String name,
    required String species, // 'Ovino' | 'Caprino'
    required String breed,
    required String gender, // 'Macho' | 'Fêmea'
    required DateTime birthDate,
    required double weight,
    required String location,
    String? status,
    DateTime? lastVaccination,
    bool pregnant = false,
    DateTime? expectedDelivery,
    String? healthIssue,
  }) async {
    final now = DateTime.now();
    await db.into(db.animals).insert(
          AnimalsCompanion.insert(
            id: _uuid.v4(),
            code: code,
            name: name,
            species: species,
            breed: breed,
            gender: gender,
            birthDate: birthDate,
            weight: weight,
            location: location,
            status: Value(status ?? 'Saudável'),
            lastVaccination: Value(lastVaccination),
            pregnant: Value(pregnant),
            expectedDelivery: Value(expectedDelivery),
            healthIssue: Value(healthIssue),
            createdAt: Value(now),
            updatedAt: Value(now),
          ),
          mode: InsertMode.insertOrAbort,
        );
  }

  /// ------------------------------
  /// VACINAÇÕES
  /// ------------------------------
  Future<void> createVaccination({
    required String animalId,
    required String vaccineName,
    required String vaccineType,
    required DateTime scheduledDate,
    String? veterinarian,
    String? notes,
  }) async {
    final now = DateTime.now();
    await db.into(db.vaccinations).insert(
          VaccinationsCompanion.insert(
            id: _uuid.v4(),
            animalId: animalId,
            vaccineName: vaccineName,
            vaccineType: vaccineType,
            scheduledDate: scheduledDate,
            veterinarian: Value(veterinarian),
            notes: Value(notes),
            status: const Value('Agendada'),
            createdAt: Value(now),
            updatedAt: Value(now),
          ),
        );
  }

  Future<void> markVaccinationApplied({
    required String vaccinationId,
    DateTime? appliedAt,
  }) async {
    final now = DateTime.now();
    await (db.update(db.vaccinations)
          ..where((tbl) => tbl.id.equals(vaccinationId)))
        .write(
      VaccinationsCompanion(
        status: const Value('Aplicada'),
        appliedDate: Value(appliedAt ?? now),
        updatedAt: Value(now),
      ),
    );
  }

  /// Exemplo de leitura simples de vacinações agendadas
  Stream<List<Vaccination>> watchScheduledVaccinations() {
    final q = db.select(db.vaccinations)
      ..where((v) => v.status.equals('Agendada'))
      ..orderBy([(v) => OrderingTerm.asc(v.scheduledDate)]);
    return q.watch();
  }
}

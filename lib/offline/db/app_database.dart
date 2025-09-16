import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

/// ------------------------------
/// TABELAS
/// ------------------------------

class Animals extends Table {
  TextColumn get id => text()(); // uuid (string)
  TextColumn get code => text()(); // UNIQUE
  TextColumn get name => text()();
  TextColumn get species => text()(); // 'Ovino' | 'Caprino'
  TextColumn get breed => text()();
  TextColumn get gender => text()(); // 'Macho' | 'Fêmea'
  DateTimeColumn get birthDate => dateTime()();
  RealColumn get weight => real()();
  TextColumn get status => text().withDefault(const Constant('Saudável'))();
  TextColumn get location => text()();
  DateTimeColumn get lastVaccination => dateTime().nullable()();
  BoolColumn get pregnant => boolean().withDefault(const Constant(false))();
  DateTimeColumn get expectedDelivery => dateTime().nullable()();
  TextColumn get healthIssue => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  Set<Set<Column>> get uniqueKeys => {
        {code},
      };
}

class BreedingRecords extends Table {
  TextColumn get id => text()(); // uuid
  TextColumn get femaleAnimalId =>
      text().nullable().references(Animals, #id)();
  TextColumn get maleAnimalId =>
      text().nullable().references(Animals, #id)();
  DateTimeColumn get breedingDate => dateTime()();
  DateTimeColumn get expectedBirth => dateTime().nullable()();
  TextColumn get status =>
      text().withDefault(const Constant('Cobertura'))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class FinancialRecords extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()(); // 'receita' | 'despesa'
  TextColumn get category => text()();
  TextColumn get description => text().nullable()();
  RealColumn get amount => real()();
  DateTimeColumn get date => dateTime().withDefault(currentDateAndTime)();
  TextColumn get animalId => text().nullable().references(Animals, #id)();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class Notes extends Table {
  TextColumn get id => text()();
  TextColumn get animalId => text().nullable().references(Animals, #id)();
  TextColumn get title => text()();
  TextColumn get content => text().nullable()();
  TextColumn get category => text()();
  TextColumn get priority =>
      text().withDefault(const Constant('Média'))();
  DateTimeColumn get date => dateTime().withDefault(currentDateAndTime)();
  TextColumn get createdBy => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class PushTokens extends Table {
  TextColumn get id => text()();
  TextColumn get token => text()(); // UNIQUE
  TextColumn get platform => text().nullable()();
  // Armazenamos JSON como string
  TextColumn get deviceInfoJson =>
      text().withDefault(const Constant('{}'))();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  Set<Set<Column>> get uniqueKeys => {
        {token},
      };
}

class Reports extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get reportType => text()(); // 'Animais' | 'Vacinações' | ...
  // Parâmetros como JSON string
  TextColumn get parametersJson =>
      text().withDefault(const Constant('{}'))();
  DateTimeColumn get generatedAt =>
      dateTime().withDefault(currentDateAndTime)();
  TextColumn get generatedBy => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Vaccinations extends Table {
  TextColumn get id => text()();
  TextColumn get animalId => text().references(Animals, #id)();
  TextColumn get vaccineName => text()();
  TextColumn get vaccineType => text()();
  DateTimeColumn get scheduledDate => dateTime()();
  DateTimeColumn get appliedDate => dateTime().nullable()();
  TextColumn get veterinarian => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get status =>
      text().withDefault(const Constant('Agendada'))();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// ------------------------------
/// BANCO
/// ------------------------------
@DriftDatabase(
  tables: [
    Animals,
    BreedingRecords,
    FinancialRecords,
    Notes,
    PushTokens,
    Reports,
    Vaccinations,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Estratégia simples de migração inicial
  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          // Coloque migrações futuras aqui
        },
      );
}

/// Abre a conexão nativa (Android, iOS, Windows, macOS, Linux)
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationSupportDirectory();
    final file = File(p.join(dir.path, 'fazenda_sao_petronio.sqlite'));
    // NativeDatabase.createInBackground evita travar o UI thread
    return NativeDatabase.createInBackground(file);
  });
}

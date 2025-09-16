import 'package:drift/drift.dart';
import '../app_database.dart';


part 'notes_dao.g.dart';


@DriftAccessor(tables: [Notes])
class NotesDao extends DatabaseAccessor<AppDatabase> with _$NotesDaoMixin {
NotesDao(AppDatabase db) : super(db);


Stream<List<Note>> watchByAnimal(String animalId) => (select(notes)
..where((n) => n.animalId.equals(animalId)))
.watch();


Future<void> insertNote(NotesCompanion data) => into(notes).insert(data);
}
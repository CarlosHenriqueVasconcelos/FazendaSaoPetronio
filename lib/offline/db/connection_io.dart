// ignore_for_file: depend_on_referenced_packages
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';


QueryExecutor constructDb() {
return LazyDatabase(() async {
final dir = await getApplicationSupportDirectory();
if (!await dir.exists()) {
await dir.create(recursive: true);
}
final file = File(p.join(dir.path, 'fazenda.db'));
return NativeDatabase.createInBackground(file);
});
}
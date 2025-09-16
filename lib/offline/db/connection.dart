import 'package:drift/drift.dart';
// Em plataformas NÃO WEB usa 'connection_io.dart'; no WEB usa 'connection_web.dart'.
import 'connection_io.dart' if (dart.library.html) 'connection_web.dart';


QueryExecutor openConnection() => constructDb();


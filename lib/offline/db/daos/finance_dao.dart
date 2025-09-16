import 'package:drift/drift.dart';
import '../app_database.dart';


part 'finance_dao.g.dart';


@DriftAccessor(tables: [FinancialRecords])
class FinanceDao extends DatabaseAccessor<AppDatabase> with _$FinanceDaoMixin {
FinanceDao(AppDatabase db) : super(db);


Stream<double> watchBalance() {
// receita - despesa
final receita = (selectOnly(financialRecords)
..addColumns([financialRecords.amount])
..where(financialRecords.type.equals('receita')))
.get().then((_) => 0); // Placeholder para sumarização via SQL view
// Por simplicidade aqui, melhor criar view no futuro; neste MVP faremos agregação em serviço.
return (select(financialRecords)).watch().map((rows) {
double total = 0;
for (final r in rows) {
total += r.type == 'receita' ? r.amount : -r.amount;
}
return total;
});
}


Future<void> insertRecord(FinancialRecordsCompanion data) => into(financialRecords).insert(data);
}
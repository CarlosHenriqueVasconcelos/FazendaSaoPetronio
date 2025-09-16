/// Convenção para campos `DATE`: armazenar como DateTime em UTC às 00:00:00.
DateTime dateOnlyUtc(DateTime d) => DateTime.utc(d.year, d.month, d.day);
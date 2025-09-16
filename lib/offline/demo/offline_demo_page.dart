import 'package:flutter/material.dart';
import '../db/app_database.dart';
import '../services/offline_repository.dart';

class OfflineDemoPage extends StatefulWidget {
  const OfflineDemoPage({super.key});

  @override
  State<OfflineDemoPage> createState() => _OfflineDemoPageState();
}

class _OfflineDemoPageState extends State<OfflineDemoPage> {
  late final AppDatabase db;
  late final OfflineRepository repo;

  @override
  void initState() {
    super.initState();
    db = AppDatabase();
    repo = OfflineRepository(db);
  }

  @override
  void dispose() {
    db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Offline Demo')),
      body: StreamBuilder(
        stream: repo.watchAnimals(),
        builder: (context, snapshot) {
          final animals = snapshot.data ?? <Animal>[];
          if (animals.isEmpty) {
            return const Center(
              child: Text('Nenhum animal. Toque em "Add" para incluir.'),
            );
          }
          return ListView.separated(
            itemCount: animals.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final a = animals[i];
              return ListTile(
                title: Text('${a.code} — ${a.name} (${a.species})'),
                subtitle: Text(
                  'Peso: ${a.weight.toStringAsFixed(1)} kg | '
                  'Status: ${a.status} | Local: ${a.location}',
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await repo.createAnimal(
            code: DateTime.now().millisecondsSinceEpoch.toString(),
            name: 'Novo Animal',
            species: 'Ovino',
            breed: 'SRD',
            gender: 'Macho',
            birthDate: DateTime.now(),
            weight: 25.0,
            location: 'Piquete A',
          );
        },
        label: const Text('Add'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

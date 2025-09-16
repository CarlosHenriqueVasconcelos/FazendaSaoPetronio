import 'package:flutter/material.dart';
import 'offline/demo/offline_demo_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const OfflineApp());
}

class OfflineApp extends StatelessWidget {
  const OfflineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fazenda São Petrônio (Offline)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF2E7D32),
        brightness: Brightness.light,
      ),
      home: const OfflineDemoPage(),
    );
  }
}

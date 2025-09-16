import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/dashboard_screen.dart';
import 'theme/app_theme.dart';
import 'services/animal_service.dart';

void main() {
  runApp(const BegoAgritechApp());
}

class BegoAgritechApp extends StatelessWidget {
  const BegoAgritechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AnimalService()),
      ],
      child: MaterialApp(
        title: 'BEGO Agritech - Sistema de Gestão Pecuária',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const DashboardScreen(),
      ),
    );
  }
}
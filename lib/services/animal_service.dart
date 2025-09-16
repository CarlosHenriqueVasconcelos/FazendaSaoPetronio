import 'package:flutter/foundation.dart';
import '../models/animal.dart';

class AnimalService extends ChangeNotifier {
  List<Animal> _animals = [];
  AnimalStats? _stats;

  List<Animal> get animals => _animals;
  AnimalStats? get stats => _stats;

  AnimalService() {
    _loadMockData();
  }

  void _loadMockData() {
    // Dados simulados para funcionamento offline - idênticos ao web
    _animals = [
      Animal(
        id: "OV001",
        name: "Benedita",
        species: "Ovino",
        breed: "Santa Inês",
        gender: "Fêmea",
        birthDate: DateTime(2022, 3, 15),
        weight: 45.5,
        status: "Saudável",
        location: "Pasto A1",
        lastVaccination: DateTime(2024, 8, 15),
        pregnant: true,
        expectedDelivery: DateTime(2024, 12, 20),
      ),
      Animal(
        id: "CP002",
        name: "Joaquim",
        species: "Caprino",
        breed: "Boer",
        gender: "Macho",
        birthDate: DateTime(2021, 7, 22),
        weight: 65.2,
        status: "Reprodutor",
        location: "Pasto B2",
        lastVaccination: DateTime(2024, 9, 1),
        pregnant: false,
      ),
      Animal(
        id: "OV003",
        name: "Esperança",
        species: "Ovino",
        breed: "Morada Nova",
        gender: "Fêmea",
        birthDate: DateTime(2023, 1, 10),
        weight: 38.0,
        status: "Em tratamento",
        location: "Enfermaria",
        lastVaccination: DateTime(2024, 7, 20),
        pregnant: false,
        healthIssue: "Verminose",
      ),
    ];

    _stats = AnimalStats(
      totalAnimals: 45,
      healthy: 42,
      pregnant: 8,
      underTreatment: 3,
      vaccinesThisMonth: 12,
      birthsThisMonth: 3,
      avgWeight: 51.2,
      revenue: 15450.00,
    );

    notifyListeners();
  }

  void addAnimal(Animal animal) {
    _animals.add(animal);
    notifyListeners();
  }

  void updateAnimal(Animal animal) {
    final index = _animals.indexWhere((a) => a.id == animal.id);
    if (index >= 0) {
      _animals[index] = animal;
      notifyListeners();
    }
  }

  void removeAnimal(String id) {
    _animals.removeWhere((animal) => animal.id == id);
    notifyListeners();
  }
}
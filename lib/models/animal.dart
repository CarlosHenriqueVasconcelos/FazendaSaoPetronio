class Animal {
  final String id;
  final String name;
  final String species;
  final String breed;
  final String gender;
  final DateTime birthDate;
  final double weight;
  final String status;
  final String location;
  final DateTime lastVaccination;
  final bool pregnant;
  final DateTime? expectedDelivery;
  final String? healthIssue;

  Animal({
    required this.id,
    required this.name,
    required this.species,
    required this.breed,
    required this.gender,
    required this.birthDate,
    required this.weight,
    required this.status,
    required this.location,
    required this.lastVaccination,
    this.pregnant = false,
    this.expectedDelivery,
    this.healthIssue,
  });

  String get ageText {
    final now = DateTime.now();
    final ageInMonths = (now.year - birthDate.year) * 12 + (now.month - birthDate.month);
    
    if (ageInMonths < 12) {
      return '$ageInMonths meses';
    } else {
      final years = ageInMonths ~/ 12;
      final remainingMonths = ageInMonths % 12;
      return remainingMonths > 0 ? '${years}a ${remainingMonths}m' : '$years anos';
    }
  }

  String get speciesIcon {
    return species == 'Ovino' ? '🐑' : '🐐';
  }
}

class AnimalStats {
  final int totalAnimals;
  final int healthy;
  final int pregnant;
  final int underTreatment;
  final int vaccinesThisMonth;
  final int birthsThisMonth;
  final double avgWeight;
  final double revenue;

  AnimalStats({
    required this.totalAnimals,
    required this.healthy,
    required this.pregnant,
    required this.underTreatment,
    required this.vaccinesThisMonth,
    required this.birthsThisMonth,
    required this.avgWeight,
    required this.revenue,
  });
}
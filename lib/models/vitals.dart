import 'package:meta/meta.dart';

class Vitals {
  final String vitalId;
  final String userId;
  final double? weight;
  final double? height;
  final double? bmi;
  final String? bloodPressure;
  final double? bloodSugar;
  final int? heartRate;
  final double? temperature;
  final double? oxygenSaturation;

  Vitals({
    required this.vitalId,
    required this.userId,
    this.weight,
    this.height,
    this.bmi,
    this.bloodPressure,
    this.bloodSugar,
    this.heartRate,
    this.temperature,
    this.oxygenSaturation,
  });

  factory Vitals.empty() {
    return Vitals(
      vitalId: '',
      userId: '',
    );
  }

  factory Vitals.fromJson(Map<String, dynamic> json) {
    return Vitals(
      vitalId: json['vital_id'] ?? '',
      userId: json['user_id'] ?? '',
      weight: json['weight']?.toDouble(),
      height: json['height']?.toDouble(),
      bmi: json['bmi']?.toDouble(),
      bloodPressure: json['blood_pressure'],
      bloodSugar: json['blood_sugar']?.toDouble(),
      heartRate: json['heart_rate']?.toInt(),
      temperature: json['temperature']?.toDouble(),
      oxygenSaturation: json['oxygen_saturation']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vital_id': vitalId,
      'user_id': userId,
      'weight': weight,
      'height': height,
      'bmi': bmi,
      'blood_pressure': bloodPressure,
      'blood_sugar': bloodSugar,
      'heart_rate': heartRate,
      'temperature': temperature,
      'oxygen_saturation': oxygenSaturation,
    };
  }
}

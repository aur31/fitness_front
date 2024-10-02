import 'package:meta/meta.dart';

class Vitals {
  final String vitalId;
  final int? diastol;
  final int? systol;
  final double? glycemia;
  final double? bmi;
  final String? userId;

  Vitals({
    required this.vitalId,
    this.diastol,
    this.systol,
    this.glycemia,
    this.bmi,
    this.userId,
  });

  /*Vitals.empty() : vitalId = '';*/

  factory Vitals.fromJson(Map<String, dynamic> json) {
    return Vitals(
      vitalId: json['vital_id'] as String,
      diastol: json['diastol'] as int?,
      systol: json['systol'] as int?,
      glycemia: json['gycemia'] as double?, // Note: 'gycemia' is used here as per the SQL, but it might be a typo
      bmi: json['BMI'] as double?,
      userId: json['user_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vital_id': vitalId,
      'diastol': diastol,
      'systol': systol,
      'gycemia': glycemia, // Note: 'gycemia' is used here as per the SQL, but it might be a typo
      'BMI': bmi,
      'user_id': userId,
    };
  }

  Vitals copyWith({
    String? vitalId,
    int? diastol,
    int? systol,
    double? glycemia,
    double? bmi,
    String? userId,
  }) {
    return Vitals(
      vitalId: vitalId ?? this.vitalId,
      diastol: diastol ?? this.diastol,
      systol: systol ?? this.systol,
      glycemia: glycemia ?? this.glycemia,
      bmi: bmi ?? this.bmi,
      userId: userId ?? this.userId,
    );
  }

  @override
  String toString() {
    return 'Vitals(vitalId: $vitalId, diastol: $diastol, systol: $systol, glycemia: $glycemia, bmi: $bmi, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Vitals &&
      other.vitalId == vitalId &&
      other.diastol == diastol &&
      other.systol == systol &&
      other.glycemia == glycemia &&
      other.bmi == bmi &&
      other.userId == userId;
  }

  @override
  int get hashCode {
    return vitalId.hashCode ^
      diastol.hashCode ^
      systol.hashCode ^
      glycemia.hashCode ^
      bmi.hashCode ^
      userId.hashCode;
  }
}

import 'package:meta/meta.dart';

class SportExercise {
  final String sportCatId;
  final String exerciseId;

  SportExercise({
    required this.sportCatId,
    required this.exerciseId,
  });

  SportExercise.empty()
      : sportCatId = '',
        exerciseId = '';

  factory SportExercise.fromJson(Map<String, dynamic> json) {
    return SportExercise(
      sportCatId: json['sport_cat_id'] as String,
      exerciseId: json['exercise_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sport_cat_id': sportCatId,
      'exercise_id': exerciseId,
    };
  }

  SportExercise copyWith({
    String? sportCatId,
    String? exerciseId,
  }) {
    return SportExercise(
      sportCatId: sportCatId ?? this.sportCatId,
      exerciseId: exerciseId ?? this.exerciseId,
    );
  }

  @override
  String toString() {
    return 'SportExercise(sportCatId: $sportCatId, exerciseId: $exerciseId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SportExercise &&
      other.sportCatId == sportCatId &&
      other.exerciseId == exerciseId;
  }

  @override
  int get hashCode => sportCatId.hashCode ^ exerciseId.hashCode;
}

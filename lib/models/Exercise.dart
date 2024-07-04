
class Exercise {
  String? exercise_id;
  String? exercise_demo;

  Exercise.EmptyUser();
  Exercise({
    required this.exercise_id,
    required this.exercise_demo,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      exercise_id: json['exercise_id'],
      exercise_demo: json['exercise_demo'],
    );
  }
}


class User {
  String? user_id;
  String? name;
  double? BMI;
  double? weight;
  double? height;
  int? day_counter_progression;
  String? email;
  int? role;

  User.EmptyUser();
  User({
    required this.user_id,
    required this.name,
    required this.BMI,
    required this.email,
    required this.weight,
    required this.height,
    required this.day_counter_progression,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      user_id: json['user_id'],
      name: json['name'],
      BMI: json['BMI'] ?? "",
      weight: double.parse(json['weight'].toString()),
      email: json['email'] ?? "",
      height: double.parse(json['height'].toString()),
      day_counter_progression: json['day_counter_progression'],
      role: json['role'],
    );
  }
}

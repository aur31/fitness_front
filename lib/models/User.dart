class User {
  final String user_id;
  final String email;
  final String? name;
  final String? sex;
  final bool? status;
  int? role;

  User({
    required this.user_id,
    required this.email,
    this.name,
    this.sex,
    this.status,
    this.role,
  });

  User.EmptyUser()
      : user_id = '',
        email = '',name = "",sex = "",status= false,role = -1;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      user_id: json['user_id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      sex: json['sex'] as String?,
      role: json['role'],
      status: json['status'] != null ? json['status'] == 1 : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'email': email,
      'name': name,
      'sex': sex,
      'role': role,
      'status': status != null ? (status! ? 1 : 0) : null,
    };
  }

  User copyWith({
    String? user_id,
    String? email,
    String? name,
    String? sex,
    int? role,
    bool? status,
  }) {
    return User(
      user_id: user_id ?? this.user_id,
      email: email ?? this.email,
      name: name ?? this.name,
      sex: sex ?? this.sex,
      role: role ?? this.role,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'User(userId: $user_id, email: $email, name: $name, sex: $sex, status: $status, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
      other.user_id == user_id &&
      other.email == email &&
      other.name == name &&
      other.sex == sex &&
      other.role == role &&
      other.status == status;
  }

  @override
  int get hashCode {
    return user_id.hashCode ^
      email.hashCode ^
      name.hashCode ^
      sex.hashCode ^
      role.hashCode ^
      status.hashCode;
  }
}





/*

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
*/

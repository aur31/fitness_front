class User {
  final String userId;
  final String email;
  final String? name;
  final String? sex;
  final String? password;
  final bool? status;
  int? role;
  final DateTime? deleteAt;

  User({
    required this.userId,
    required this.email,
    this.name,
    this.sex,
    this.password,
    this.status,
    this.role,
    this.deleteAt,
  });

  /*User.empty()
      : userId = '',
        email = '';*/

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      sex: json['sex'] as String?,
      password: json['password'] as String?,
      role: json['role'],
      status: json['status'] != null ? json['status'] == 1 : null,
      deleteAt: json['delete_at'] != null
          ? DateTime.parse(json['delete_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'email': email,
      'name': name,
      'sex': sex,
      'password': password,
      'role': role,
      'status': status != null ? (status! ? 1 : 0) : null,
      'delete_at': deleteAt?.toIso8601String(),
    };
  }

  User copyWith({
    String? userId,
    String? email,
    String? name,
    String? sex,
    int? role,
    String? password,
    bool? status,
    DateTime? deleteAt,
  }) {
    return User(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      name: name ?? this.name,
      sex: sex ?? this.sex,
      role: role ?? this.role,
      password: password ?? this.password,
      status: status ?? this.status,
      deleteAt: deleteAt ?? this.deleteAt,
    );
  }

  @override
  String toString() {
    return 'User(userId: $userId, email: $email, name: $name, sex: $sex, status: $status, role: $role, deleteAt: $deleteAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
      other.userId == userId &&
      other.email == email &&
      other.name == name &&
      other.sex == sex &&
      other.role == role &&
      other.password == password &&
      other.status == status &&
      other.deleteAt == deleteAt;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
      email.hashCode ^
      name.hashCode ^
      sex.hashCode ^
      role.hashCode ^
      password.hashCode ^
      status.hashCode ^
      deleteAt.hashCode;
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

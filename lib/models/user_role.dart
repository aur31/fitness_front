import 'package:meta/meta.dart';

class UserRole {
  final String userId;
  final String roleId;

  UserRole({
    required this.userId,
    required this.roleId,
  });

  UserRole.empty()
      : userId = '',
        roleId = '';

  factory UserRole.fromJson(Map<String, dynamic> json) {
    return UserRole(
      userId: json['user_id'] as String,
      roleId: json['role_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'role_id': roleId,
    };
  }

  UserRole copyWith({
    String? userId,
    String? roleId,
  }) {
    return UserRole(
      userId: userId ?? this.userId,
      roleId: roleId ?? this.roleId,
    );
  }

  @override
  String toString() {
    return 'UserRole(userId: $userId, roleId: $roleId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserRole &&
      other.userId == userId &&
      other.roleId == roleId;
  }

  @override
  int get hashCode => userId.hashCode ^ roleId.hashCode;
}

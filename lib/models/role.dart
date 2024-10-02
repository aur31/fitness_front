import 'package:meta/meta.dart';

class Role {
  final String roleId;
  final String? roleName;
  final bool? status;
  final DateTime? deleteAt;

  Role({
    required this.roleId,
    this.roleName,
    this.status,
    this.deleteAt,
  });

  /*Role.empty() : roleId = '';*/

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      roleId: json['role_id'] as String,
      roleName: json['role_name'] as String?,
      status: json['status'] != null ? json['status'] == 1 : null,
      deleteAt: json['delete_at'] != null
          ? DateTime.parse(json['delete_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role_id': roleId,
      'role_name': roleName,
      'status': status != null ? (status! ? 1 : 0) : null,
      'delete_at': deleteAt?.toIso8601String(),
    };
  }

  Role copyWith({
    String? roleId,
    String? roleName,
    bool? status,
    DateTime? deleteAt,
  }) {
    return Role(
      roleId: roleId ?? this.roleId,
      roleName: roleName ?? this.roleName,
      status: status ?? this.status,
      deleteAt: deleteAt ?? this.deleteAt,
    );
  }

  @override
  String toString() {
    return 'Role(roleId: $roleId, roleName: $roleName, status: $status, deleteAt: $deleteAt)';
  }
}

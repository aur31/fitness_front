import 'package:meta/meta.dart';

class PermissionRole {
  final String permissionId;
  final String roleId;

  PermissionRole({
    required this.permissionId,
    required this.roleId,
  });

  PermissionRole.empty()
      : permissionId = '',
        roleId = '';

  factory PermissionRole.fromJson(Map<String, dynamic> json) {
    return PermissionRole(
      permissionId: json['permission_id'] as String,
      roleId: json['role_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'permission_id': permissionId,
      'role_id': roleId,
    };
  }

  PermissionRole copyWith({
    String? permissionId,
    String? roleId,
  }) {
    return PermissionRole(
      permissionId: permissionId ?? this.permissionId,
      roleId: roleId ?? this.roleId,
    );
  }

  @override
  String toString() {
    return 'PermissionRole(permissionId: $permissionId, roleId: $roleId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PermissionRole &&
      other.permissionId == permissionId &&
      other.roleId == roleId;
  }

  @override
  int get hashCode => permissionId.hashCode ^ roleId.hashCode;
}

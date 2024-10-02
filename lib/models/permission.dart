import 'package:meta/meta.dart';

class Permission {
  final String permissionId;
  final String? permission;
  final bool? status;
  final DateTime? deleteAt;

  Permission({
    required this.permissionId,
    this.permission,
    this.status,
    this.deleteAt,
  });

 /* Permission.empty() : permissionId = '';*/

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      permissionId: json['permission_id'] as String,
      permission: json['permission'] as String?,
      status: json['status'] != null ? json['status'] == 1 : null,
      deleteAt: json['delete_at'] != null
          ? DateTime.parse(json['delete_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'permission_id': permissionId,
      'permission': permission,
      'status': status != null ? (status! ? 1 : 0) : null,
      'delete_at': deleteAt?.toIso8601String(),
    };
  }

  Permission copyWith({
    String? permissionId,
    String? permission,
    bool? status,
    DateTime? deleteAt,
  }) {
    return Permission(
      permissionId: permissionId ?? this.permissionId,
      permission: permission ?? this.permission,
      status: status ?? this.status,
      deleteAt: deleteAt ?? this.deleteAt,
    );
  }

  @override
  String toString() {
    return 'Permission(permissionId: $permissionId, permission: $permission, status: $status, deleteAt: $deleteAt)';
  }
}

import 'package:meta/meta.dart';

class SportCategory {
  final String sportCatId;
  final String? name;
  final String? description;
  final bool? status;
  final String? userId;
  final DateTime? deleteAt;

  SportCategory({
    required this.sportCatId,
    this.name,
    this.description,
    this.status,
    this.userId,
    this.deleteAt,
  });

  /*SportCategory.empty() : sportCatId = '';*/

  factory SportCategory.fromJson(Map<String, dynamic> json) {
    return SportCategory(
      sportCatId: json['sport_cat_id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      status: json['status'] != null ? json['status'] == 1 : null,
      userId: json['user_id'] as String?,
      deleteAt: json['delete_at'] != null
          ? DateTime.parse(json['delete_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sport_cat_id': sportCatId,
      'name': name,
      'description': description,
      'status': status != null ? (status! ? 1 : 0) : null,
      'user_id': userId,
      'delete_at': deleteAt?.toIso8601String(),
    };
  }

  SportCategory copyWith({
    String? sportCatId,
    String? name,
    String? description,
    bool? status,
    String? userId,
    DateTime? deleteAt,
  }) {
    return SportCategory(
      sportCatId: sportCatId ?? this.sportCatId,
      name: name ?? this.name,
      description: description ?? this.description,
      status: status ?? this.status,
      userId: userId ?? this.userId,
      deleteAt: deleteAt ?? this.deleteAt,
    );
  }

  @override
  String toString() {
    return 'SportCategory(sportCatId: $sportCatId, name: $name, description: $description, status: $status, userId: $userId, deleteAt: $deleteAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SportCategory &&
      other.sportCatId == sportCatId &&
      other.name == name &&
      other.description == description &&
      other.status == status &&
      other.userId == userId &&
      other.deleteAt == deleteAt;
  }

  @override
  int get hashCode {
    return sportCatId.hashCode ^
      name.hashCode ^
      description.hashCode ^
      status.hashCode ^
      userId.hashCode ^
      deleteAt.hashCode;
  }
}

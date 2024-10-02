import 'package:meta/meta.dart';

class MealCategory {
  final String mealCatId;
  final String? name;
  final bool? status;
  final String? description;
  final DateTime? deleteAt;

  MealCategory({
    required this.mealCatId,
    this.name,
    this.status,
    this.description,
    this.deleteAt,
  });
  

  factory MealCategory.fromJson(Map<String, dynamic> json) {
    return MealCategory(
      mealCatId: json['meal_cat_id'] as String,
      name: json['name'] as String?,
      status: json['status'] != null ? json['status'] == 1 : null,
      description: json['description'] as String?,
      deleteAt: json['delete_at'] != null
          ? DateTime.parse(json['delete_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meal_cat_id': mealCatId,
      'name': name,
      'status': status != null ? (status! ? 1 : 0) : null,
      'description': description,
      'delete_at': deleteAt?.toIso8601String(),
    };
  }

  MealCategory copyWith({
    String? mealCatId,
    String? name,
    bool? status,
    String? description,
    DateTime? deleteAt,
  }) {
    return MealCategory(
      mealCatId: mealCatId ?? this.mealCatId,
      name: name ?? this.name,
      status: status ?? this.status,
      description: description ?? this.description,
      deleteAt: deleteAt ?? this.deleteAt,
    );
  }

  @override
  String toString() {
    return 'MealCategory(mealCatId: $mealCatId, name: $name, status: $status, description: $description, deleteAt: $deleteAt)';
  }
}

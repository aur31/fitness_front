import 'package:meta/meta.dart';

class Meal {
  final String mealId;
  final String? mealName;
  final String? recipes;
  final bool? status;
  final String? userId;
  final DateTime? deleteAt;

  Meal({
    required this.mealId,
    this.mealName,
    this.recipes,
    this.status,
    this.userId,
    this.deleteAt,
  });

  /*Meal.empty() : mealId = '';*/

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      mealId: json['meal_id'] as String,
      mealName: json['meal_name'] as String?,
      recipes: json['recipes'] as String?,
      status: json['status'] != null ? json['status'] == 1 : null,
      userId: json['user_id'] as String?,
      deleteAt: json['delete_at'] != null
          ? DateTime.parse(json['delete_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meal_id': mealId,
      'meal_name': mealName,
      'recipes': recipes,
      'status': status != null ? (status! ? 1 : 0) : null,
      'user_id': userId,
      'delete_at': deleteAt?.toIso8601String(),
    };
  }

  Meal copyWith({
    String? mealId,
    String? mealName,
    String? recipes,
    bool? status,
    String? userId,
    DateTime? deleteAt,
  }) {
    return Meal(
      mealId: mealId ?? this.mealId,
      mealName: mealName ?? this.mealName,
      recipes: recipes ?? this.recipes,
      status: status ?? this.status,
      userId: userId ?? this.userId,
      deleteAt: deleteAt ?? this.deleteAt,
    );
  }

  @override
  String toString() {
    return 'Meal(mealId: $mealId, mealName: $mealName, recipes: $recipes, status: $status, userId: $userId, deleteAt: $deleteAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Meal &&
      other.mealId == mealId &&
      other.mealName == mealName &&
      other.recipes == recipes &&
      other.status == status &&
      other.userId == userId &&
      other.deleteAt == deleteAt;
  }

  @override
  int get hashCode {
    return mealId.hashCode ^
      mealName.hashCode ^
      recipes.hashCode ^
      status.hashCode ^
      userId.hashCode ^
      deleteAt.hashCode;
  }
}

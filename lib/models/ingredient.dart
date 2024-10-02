import 'package:meta/meta.dart';

class Ingredient {
  final String ingredientId;
  final String mealId;
  final String? ingredient;
  final String? description;

  Ingredient({
    required this.ingredientId,
    required this.mealId,
    this.ingredient,
    this.description,
  });

  /*Ingredient.empty()
      : ingredientId = '',
        mealId = '';*/

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      ingredientId: json['ingredient_id'] as String,
      mealId: json['meal_id'] as String,
      ingredient: json['ingredient'] as String?,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ingredient_id': ingredientId,
      'meal_id': mealId,
      'ingredient': ingredient,
      'description': description,
    };
  }

  Ingredient copyWith({
    String? ingredientId,
    String? mealId,
    String? ingredient,
    String? description,
  }) {
    return Ingredient(
      ingredientId: ingredientId ?? this.ingredientId,
      mealId: mealId ?? this.mealId,
      ingredient: ingredient ?? this.ingredient,
      description: description ?? this.description,
    );
  }

  @override
  String toString() {
    return 'Ingredient(ingredientId: $ingredientId, mealId: $mealId, ingredient: $ingredient, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Ingredient &&
      other.ingredientId == ingredientId &&
      other.mealId == mealId &&
      other.ingredient == ingredient &&
      other.description == description;
  }

  @override
  int get hashCode {
    return ingredientId.hashCode ^
      mealId.hashCode ^
      ingredient.hashCode ^
      description.hashCode;
  }
}

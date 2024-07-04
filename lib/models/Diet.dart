
class Diet {
  String? diet_id;
  String? label;

  Diet.EmptyUser();
  Diet({
    required this.diet_id,
    required this.label,
  });

  factory Diet.fromJson(Map<String, dynamic> json) {
    return Diet(
      diet_id: json['diet_id'],
      label: json['label'],
    );
  }
}

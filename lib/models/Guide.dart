
class Guide {
  String? guide_id;
  String? label;
  String? guide;
  String? diet_id;

  Guide.EmptyUser();
  Guide({
    required this.guide_id,
    required this.label,
    required this.guide,
    required this.diet_id,
  });

  factory Guide.fromJson(Map<String, dynamic> json) {
    return Guide(
      guide_id: json['guide_id'],
      guide: json['guide'],
      label: json['label'],
      diet_id: json['diet_id'],
    );
  }
}

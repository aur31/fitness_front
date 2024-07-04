
class Sport {
  String? sport_id;
  String? type;

  Sport.EmptyUser();
  Sport({
    required this.sport_id,
    required this.type,
  });

  factory Sport.fromJson(Map<String, dynamic> json) {
    return Sport(
      sport_id: json['sport_id'],
      type: json['type'],
    );
  }
}

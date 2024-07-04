
class Encouragement {
  String? encouragement_id;
  String? message;

  Encouragement.EmptyUser();
  Encouragement({
    required this.encouragement_id,
    required this.message,
  });

  factory Encouragement.fromJson(Map<String, dynamic> json) {
    return Encouragement(
      encouragement_id: json['encouragement_id'],
      message: json['message'],
    );
  }
}

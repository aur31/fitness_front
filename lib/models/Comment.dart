
class Comment {
  String? comment_id;
  String? user_id;
  String? comment;
  bool? status;

  Comment.EmptyUser();
  Comment({
    required this.comment_id,
    required this.user_id,
    required this.comment,
    required this.status,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      comment_id: json['comment_id'],
      user_id: json['user_id'],
      comment: json['comment'] ?? "",
      status: json['status'],
    );
  }
}

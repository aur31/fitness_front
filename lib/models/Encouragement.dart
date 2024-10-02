import 'package:meta/meta.dart';

class Encouragement {
  final String encouragementId;
  final String? encouragement;
  final bool? status;
  final String? userId;

  Encouragement({
    required this.encouragementId,
    this.encouragement,
    this.status,
    this.userId,
  });

  /*Encouragement.empty() : encouragementId = '';*/

  factory Encouragement.fromJson(Map<String, dynamic> json) {
    return Encouragement(
      encouragementId: json['encouragement_id'] as String,
      encouragement: json['encouragement'] as String?,
      status: json['status'] != null ? json['status'] == 1 : null,
      userId: json['user_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'encouragement_id': encouragementId,
      'encouragement': encouragement,
      'status': status != null ? (status! ? 1 : 0) : null,
      'user_id': userId,
    };
  }

  Encouragement copyWith({
    String? encouragementId,
    String? encouragement,
    bool? status,
    String? userId,
  }) {
    return Encouragement(
      encouragementId: encouragementId ?? this.encouragementId,
      encouragement: encouragement ?? this.encouragement,
      status: status ?? this.status,
      userId: userId ?? this.userId,
    );
  }

  @override
  String toString() {
    return 'Encouragement(encouragementId: $encouragementId, encouragement: $encouragement, status: $status, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Encouragement &&
      other.encouragementId == encouragementId &&
      other.encouragement == encouragement &&
      other.status == status &&
      other.userId == userId;
  }

  @override
  int get hashCode {
    return encouragementId.hashCode ^
      encouragement.hashCode ^
      status.hashCode ^
      userId.hashCode;
  }
}

import 'package:meta/meta.dart';

class Guide {
  final String guideId;
  final String? guide;
  final bool? status;
  final String? userId;

  Guide({
    required this.guideId,
    this.guide,
    this.status,
    this.userId,
  });

  /*Guide.empty() : guideId = '';*/

  factory Guide.fromJson(Map<String, dynamic> json) {
    return Guide(
      guideId: json['guide_id'] as String,
      guide: json['guide'] as String?,
      status: json['status'] != null ? json['status'] == 1 : null,
      userId: json['user_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'guide_id': guideId,
      'guide': guide,
      'status': status != null ? (status! ? 1 : 0) : null,
      'user_id': userId,
    };
  }

  Guide copyWith({
    String? guideId,
    String? guide,
    bool? status,
    String? userId,
  }) {
    return Guide(
      guideId: guideId ?? this.guideId,
      guide: guide ?? this.guide,
      status: status ?? this.status,
      userId: userId ?? this.userId,
    );
  }

  @override
  String toString() {
    return 'Guide(guideId: $guideId, guide: $guide, status: $status, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Guide &&
      other.guideId == guideId &&
      other.guide == guide &&
      other.status == status &&
      other.userId == userId;
  }

  @override
  int get hashCode {
    return guideId.hashCode ^
      guide.hashCode ^
      status.hashCode ^
      userId.hashCode;
  }
}

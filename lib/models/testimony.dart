import 'package:meta/meta.dart';

class Testimony {
  final String testimonyId;
  final String? testimony;
  final bool? status;
  final String? userId;

  Testimony({
    required this.testimonyId,
    this.testimony,
    this.status,
    this.userId,
  });

  /*Testimony.empty() : testimonyId = '';*/

  factory Testimony.fromJson(Map<String, dynamic> json) {
    return Testimony(
      testimonyId: json['testimony_id'] as String,
      testimony: json['testimony'] as String?,
      status: json['status'] != null ? json['status'] == 1 : null,
      userId: json['user_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'testimony_id': testimonyId,
      'testimony': testimony,
      'status': status != null ? (status! ? 1 : 0) : null,
      'user_id': userId,
    };
  }

  Testimony copyWith({
    String? testimonyId,
    String? testimony,
    bool? status,
    String? userId,
  }) {
    return Testimony(
      testimonyId: testimonyId ?? this.testimonyId,
      testimony: testimony ?? this.testimony,
      status: status ?? this.status,
      userId: userId ?? this.userId,
    );
  }

  @override
  String toString() {
    return 'Testimony(testimonyId: $testimonyId, testimony: $testimony, status: $status, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Testimony &&
      other.testimonyId == testimonyId &&
      other.testimony == testimony &&
      other.status == status &&
      other.userId == userId;
  }

  @override
  int get hashCode {
    return testimonyId.hashCode ^
      testimony.hashCode ^
      status.hashCode ^
      userId.hashCode;
  }
}

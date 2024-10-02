import 'package:meta/meta.dart';

class UserStatistics {
  final String userId;
  final int? dayCounter;

  UserStatistics({
    required this.userId,
    this.dayCounter,
  });

  /*UserStatistics.empty() : userId = '';*/

  factory UserStatistics.fromJson(Map<String, dynamic> json) {
    return UserStatistics(
      userId: json['user_id'] as String,
      dayCounter: json['day_counter'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'day_counter': dayCounter,
    };
  }

  UserStatistics copyWith({
    String? userId,
    int? dayCounter,
  }) {
    return UserStatistics(
      userId: userId ?? this.userId,
      dayCounter: dayCounter ?? this.dayCounter,
    );
  }

  @override
  String toString() {
    return 'UserStatistics(userId: $userId, dayCounter: $dayCounter)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserStatistics &&
      other.userId == userId &&
      other.dayCounter == dayCounter;
  }

  @override
  int get hashCode => userId.hashCode ^ dayCounter.hashCode;
}

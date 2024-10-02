import 'package:meta/meta.dart';

class MarketPlace {
  final String marketId;
  final String? name;
  final String? url;
  final bool? status;
  final String? userId;

  MarketPlace({
    required this.marketId,
    this.name,
    this.url,
    this.status,
    this.userId,
  });

  /*MarketPlace.empty() : marketId = '';*/

  factory MarketPlace.fromJson(Map<String, dynamic> json) {
    return MarketPlace(
      marketId: json['market_id'] as String,
      name: json['name'] as String?,
      url: json['url'] as String?,
      status: json['status'] != null ? json['status'] == 1 : null,
      userId: json['user_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'market_id': marketId,
      'name': name,
      'url': url,
      'status': status != null ? (status! ? 1 : 0) : null,
      'user_id': userId,
    };
  }

  MarketPlace copyWith({
    String? marketId,
    String? name,
    String? url,
    bool? status,
    String? userId,
  }) {
    return MarketPlace(
      marketId: marketId ?? this.marketId,
      name: name ?? this.name,
      url: url ?? this.url,
      status: status ?? this.status,
      userId: userId ?? this.userId,
    );
  }

  @override
  String toString() {
    return 'MarketPlace(marketId: $marketId, name: $name, url: $url, status: $status, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MarketPlace &&
      other.marketId == marketId &&
      other.name == name &&
      other.url == url &&
      other.status == status &&
      other.userId == userId;
  }

  @override
  int get hashCode {
    return marketId.hashCode ^
      name.hashCode ^
      url.hashCode ^
      status.hashCode ^
      userId.hashCode;
  }
}

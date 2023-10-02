class GetFavoritesResponse {
  final int status;
  final List<Favorite> favorites;

  const GetFavoritesResponse({required this.status, required this.favorites});

  factory GetFavoritesResponse.fromJson(Map<String, dynamic> json) {
    return GetFavoritesResponse(
      status: json[GetFavoritesAPIKeys.status].toInt(),
      favorites: (json[GetFavoritesAPIKeys.data] as List<dynamic>)
          .map((subJson) => Favorite(
              userId: subJson[GetFavoritesAPIKeys.userId].toInt(),
              campaignId: subJson[GetFavoritesAPIKeys.campaignId].toInt(),
              timestamp: subJson[GetFavoritesAPIKeys.timestamp].toInt()))
          .toList(),
    );
  }
}

class Favorite {
  final int userId;
  final int campaignId;
  final int timestamp;

  const Favorite({
    required this.userId,
    required this.campaignId,
    required this.timestamp,
  });
}

class GetFavoritesAPIKeys {
  static const String status = "status";
  static const String data = "data";
  static const String timestamp = "timestamp";
  static const String userId = "user_id";
  static const String campaignId = "campaign_id";
}

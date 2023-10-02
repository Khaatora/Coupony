class RemoveFavoriteResponse{
  final int status;

  const RemoveFavoriteResponse({required this.status});

  factory RemoveFavoriteResponse.fromJson(Map<String, dynamic> json) {
    return RemoveFavoriteResponse(
      status: json[RemoveFavoriteAPIKeys.status].toInt(),
    );
  }
}

class RemoveFavoriteAPIKeys{
  static const String campaignId = "campaign_id";
  static const String status = "status";
}
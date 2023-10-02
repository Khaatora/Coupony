class CreateFavoriteResponse{
final int status;

const CreateFavoriteResponse({required this.status});

factory CreateFavoriteResponse.fromJson(Map<String, dynamic> json) {
  return CreateFavoriteResponse(
    status: json[CreateFavoriteAPIKeys.status].toInt(),
  );
}
}

class CreateFavoriteAPIKeys{
  static const String campaignId = "campaign_id";
  static const String status = "status";
}
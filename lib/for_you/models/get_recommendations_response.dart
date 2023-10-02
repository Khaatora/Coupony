class GetRecommendationsResponse{
  final int status;
  final List<int> data;

  const GetRecommendationsResponse({required this.status, required this.data});

  factory GetRecommendationsResponse.fromJson(Map<String, dynamic> json) {
    return GetRecommendationsResponse(
      status: json[GetRecommendationsAPIKeys.status].toInt(),
      data: (json[GetRecommendationsAPIKeys.data].cast<int>()),
    );
  }
}

class GetRecommendationsAPIKeys{
  static const String status = "status";
  static const String region = "region";
  static const String data = "data";
}
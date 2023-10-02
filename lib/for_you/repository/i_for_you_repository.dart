import 'package:dartz/dartz.dart';
import 'package:maslaha/for_you/models/get_recommendations_response.dart';
import '../../core/errors/failures/server_failure.dart';

abstract class IForYouRepository{


  Future<Either<ServerFailure,GetRecommendationsResponse>> getRecommendations(GetRecommendationsParams params, String token);
}

class GetRecommendationsParams{
  final String region;

  GetRecommendationsParams(this.region);

  Map<String, dynamic> toJson() {
    return {
      GetRecommendationsAPIKeys.region: region,
    };
  }
}
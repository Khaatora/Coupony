import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:maslaha/for_you/models/get_recommendations_response.dart';
import 'package:maslaha/for_you/repository/i_for_you_repository.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/errors/exceptions/api/exceptions.dart';
import '../../../core/services/services_locator.dart';

abstract class IForYouRemoteDataSource {
  Future<GetRecommendationsResponse> getRecommendations(
      GetRecommendationsParams params, String token);

  const IForYouRemoteDataSource();
}

class APIForYouRemoteDataSource extends IForYouRemoteDataSource {
  const APIForYouRemoteDataSource();

  @override
  Future<GetRecommendationsResponse> getRecommendations(
      GetRecommendationsParams params, String token) async {
    log(params.region ?? "null");
    final response = await sl<Dio>().get(ApiConstants.getRecommendationsUrl(),
        queryParameters: params.region != null ? params.toJson() : null,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          ApiConstants.token: token,
        }));
    switch (response.statusCode) {
      case 200:
        return GetRecommendationsResponse.fromJson(response.data);
      default:
        throw const GenericAPIException();
    }
  }
}

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:maslaha/core/global/localization.dart';
import 'package:maslaha/home/model/get_banner_response.dart';
import 'package:maslaha/home/repository/i_home_repository.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/errors/exceptions/api/exceptions.dart';
import '../../../core/services/services_locator.dart';

abstract class IHomeRemoteDataSource {

  Future<GetBannerResponse> getBannerData(GetBannerParams params);

  const IHomeRemoteDataSource();
}

class APIHomeRemoteDataSource extends IHomeRemoteDataSource {
  const APIHomeRemoteDataSource();

  @override
  Future<GetBannerResponse> getBannerData(GetBannerParams params) async {
    try {
      final response = await sl<Dio>().get(ApiConstants.getBannerUrl(),
              data: json.encode(params.toJson()),
              options: Options(headers: {
                HttpHeaders.contentTypeHeader: "application/json",
              }));
      switch (response.statusCode) {
            case 200:
              return GetBannerResponse.fromJson(response.data);
            default:
              throw const GenericAPIException();
          }
    } on DioException catch (dioError) {
      log("${dioError.message}, stacktrace: ${dioError.stackTrace}");
      switch(dioError.type){
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw const GenericAPIException(EnglishLocalization.serverTookToLongToRespond);
        default:
          throw const GenericAPIException();
      }
    }
  }
}

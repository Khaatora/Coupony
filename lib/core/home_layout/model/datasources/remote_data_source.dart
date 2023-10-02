import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:maslaha/core/home_layout/model/create_order_response.dart';
import 'package:maslaha/core/home_layout/model/get_categories_response.dart';
import 'package:maslaha/core/home_layout/model/remove_favorite_response.dart';

import '../../../constants/api_constants.dart';
import '../../../errors/exceptions/api/exceptions.dart';
import '../../../global/localization.dart';
import '../../../services/services_locator.dart';
import '../../repository/i_home_layout_repository.dart';
import '../create_favorite_response.dart';
import '../favorites_response.dart';
import '../get_coupon_response.dart';
import '../get_data_campaigns_response.dart';

abstract class IHomeLayoutRemoteDataSource {
  Future<GetDataCampaignsResponse> getCampaignData(
      GetCampaignsParams params, String token);

  Future<GetCategoriesResponse> getCategories(String token);

  Future<GetCouponResponse> getCouponData(GetCouponParams params, String token);

  Future<CreateOrderResponse> createOrder(
      CreateOrderParams params, String token);

  Future<GetFavoritesResponse> getFavorites(
      GetFavoritesParams params, String token);

  Future<CreateFavoriteResponse> createFavorites(
      CreateFavoriteParams params, String token);

  Future<RemoveFavoriteResponse> removeFavorites(
      RemoveFavoriteParams params, String token);

  const IHomeLayoutRemoteDataSource();
}

class APIHomeLayoutRemoteDataSource extends IHomeLayoutRemoteDataSource {
  const APIHomeLayoutRemoteDataSource();

  @override
  Future<GetDataCampaignsResponse> getCampaignData(
      GetCampaignsParams params, String token) async {
    log(params.region ?? "null");
    final response = await sl<Dio>().get(ApiConstants.getCampaignsDataUrl(),
        queryParameters: params.region != null ? params.toJson() : null,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          ApiConstants.token: token,
        }));
    switch (response.statusCode) {
      case 200:
        return GetDataCampaignsResponse.fromJson(response.data);
      default:
        throw const GenericAPIException();
    }
  }

  @override
  Future<GetCategoriesResponse> getCategories(String token) async {
    final response = await sl<Dio>().get(ApiConstants.getCategoriesUrl(),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          ApiConstants.token: token,
        }));
    switch (response.statusCode) {
      case 200:
        log("success, ${response.data}");
        return GetCategoriesResponse.fromJson(response.data);
      default:
        throw const GenericAPIException();
    }
  }

  @override
  Future<GetCouponResponse> getCouponData(
      GetCouponParams params, String token) async {
    log(params.channel);
    try {
      final response = await sl<Dio>().get(ApiConstants.getCouponUrl(),
          queryParameters: params.toJson(),
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            ApiConstants.token: token,
          }));
      switch (response.statusCode) {
        case 200:
          return GetCouponResponse.fromJson(response.data);
        default:
          throw const GenericAPIException();
      }
    } on DioException catch (dioError) {
      log("${dioError.message}, message: ${dioError.response?.statusMessage}, stacktrace: ${dioError.stackTrace}");
      switch (dioError.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw const GenericAPIException(
              EnglishLocalization.serverTookToLongToRespond);
        default:
          throw const GenericAPIException();
      }
    }
  }

  @override
  Future<CreateOrderResponse> createOrder(
      CreateOrderParams params, String token) async {
    try {
      final response = await sl<Dio>().post(ApiConstants.createOrderUrl(),
              data: params.toJson(),
              options: Options(headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                ApiConstants.token: token,
              }));
      switch(response.statusCode){
        case 200:
          return CreateOrderResponse.fromJson(response.data);
        default:
          throw const GenericAPIException();
      }
    } on DioException catch (dioError) {
      log("${dioError.message}, message: ${dioError.response?.statusMessage}, stacktrace: ${dioError.stackTrace}");
      switch (dioError.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw const GenericAPIException(
              EnglishLocalization.serverTookToLongToRespond);
        default:
          throw const GenericAPIException();
      }
    }

  }

  @override
  Future<GetFavoritesResponse> getFavorites(
      GetFavoritesParams params, String token) async {
    final response = await sl<Dio>().get(ApiConstants.getFavoritesUrl(),
        queryParameters: params.toJson(),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          ApiConstants.token: token,
        }));
    switch (response.statusCode) {
      case 200:
        return GetFavoritesResponse.fromJson(response.data);
      default:
        throw const GenericAPIException();
    }
  }

  @override
  Future<CreateFavoriteResponse> createFavorites(CreateFavoriteParams params, String token) async {
    final response = await sl<Dio>().post(ApiConstants.createFavoriteUrl(),
        data: params.toJson(),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          ApiConstants.token: token,
        }));
    switch (response.statusCode) {
      case 200:
        return CreateFavoriteResponse.fromJson(response.data);
      default:
        throw const GenericAPIException(EnglishLocalization.couldntAddToFavoritesServerNotResponsive);
    }
  }

  @override
  Future<RemoveFavoriteResponse> removeFavorites(RemoveFavoriteParams params, String token) async {
    final response = await sl<Dio>().post(ApiConstants.destroyFavoriteUrl(),
        data: params.toJson(),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          ApiConstants.token: token,
        }));
    switch (response.statusCode) {
      case 200:
        return RemoveFavoriteResponse.fromJson(response.data);
      default:
        throw const GenericAPIException(EnglishLocalization.couldntRemoveFromFavoriteServerNotResponsive);
    }
  }


}

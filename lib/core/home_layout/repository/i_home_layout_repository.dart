import 'package:dartz/dartz.dart';
import 'package:maslaha/core/errors/failures/cache_failure.dart';
import 'package:maslaha/core/errors/failures/server_failure.dart';
import 'package:maslaha/core/home_layout/model/create_favorite_response.dart';
import 'package:maslaha/core/home_layout/model/create_order_response.dart';
import 'package:maslaha/core/home_layout/model/get_categories_response.dart';
import 'package:maslaha/core/home_layout/model/user_data_response.dart';

import '../model/favorites_response.dart';
import '../model/get_coupon_response.dart';
import '../model/get_data_campaigns_response.dart';
import '../model/remove_favorite_response.dart';

abstract class IHomeLayoutRepository{

  Future<Either<ServerFailure,GetDataCampaignsResponse>> getDataCampaigns(GetCampaignsParams params,String token);

  Future<Either<CacheFailure, UserDataResponse>> getCachedData();

  Future<Either<ServerFailure, GetCategoriesResponse>> getCategoriesData(String token);

  Future<Either<ServerFailure, void>> checkInternetConnection();

  Future<Either<ServerFailure,GetCouponResponse>> getCouponData(GetCouponParams params, String token);

  Future<Either<ServerFailure,CreateOrderResponse>> createOrder(CreateOrderParams params, String token);

  Future<Either<ServerFailure,GetFavoritesResponse>> getFavorites(GetFavoritesParams params, String token);

  Future<Either<ServerFailure,CreateFavoriteResponse>> createFavorites(CreateFavoriteParams params, String token);

  Future<Either<ServerFailure,RemoveFavoriteResponse>> removeFavorites(RemoveFavoriteParams params, String token);
}

class GetCouponParams{
  final int campaignId;
  final String channel;

  GetCouponParams(this.campaignId, this.channel,);

  Map<String, dynamic> toJson() {
    return {
      GetCouponAPIKeys.campaignId: campaignId,
      GetCouponAPIKeys.channel: channel,
    };
  }
}

class GetCampaignsParams{
  final String? region;

  GetCampaignsParams(this.region);

  Map<String, dynamic> toJson() {
    return {
      GetDataCampaignsJsonKeys.region: region,
    };
  }
}

class CreateOrderParams{
  final String? code;

  CreateOrderParams(this.code);

  Map<String, dynamic> toJson() {
    return {
      CreateOrderAPIKeys.code: code,
    };
  }
}

class GetFavoritesParams{

  const GetFavoritesParams();

  Map<String, dynamic> toJson() {
    return {};
  }
}

class CreateFavoriteParams{

  final int campaignId;

  const CreateFavoriteParams({required this.campaignId});

  Map<String, dynamic> toJson() {
    return {
      CreateFavoriteAPIKeys.campaignId : campaignId,
    };
  }
}

class RemoveFavoriteParams{

  final int campaignId;

  const RemoveFavoriteParams({required this.campaignId});

  Map<String, dynamic> toJson() {
    return {
      RemoveFavoriteAPIKeys.campaignId : campaignId,
    };
  }
}
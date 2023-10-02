import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maslaha/core/errors/failures/cache_failure.dart';
import 'package:maslaha/core/errors/failures/server_failure.dart';
import 'package:maslaha/core/global/localization.dart';
import 'package:maslaha/core/home_layout/model/create_favorite_response.dart';
import 'package:maslaha/core/home_layout/model/create_order_response.dart';
import 'package:maslaha/core/home_layout/model/datasources/local_data_source.dart';
import 'package:maslaha/core/home_layout/model/datasources/remote_data_source.dart';
import 'package:maslaha/core/home_layout/model/get_categories_response.dart';
import 'package:maslaha/core/home_layout/model/remove_favorite_response.dart';
import 'package:maslaha/core/home_layout/model/user_data_response.dart';
import 'package:maslaha/core/services/network/network_info.dart';

import '../../errors/exceptions/api/exceptions.dart';
import '../../errors/exceptions/cache_exception.dart';
import '../../errors/exceptions/server_exception.dart';
import '../model/favorites_response.dart';
import '../model/get_coupon_response.dart';
import '../model/get_data_campaigns_response.dart';
import 'i_home_layout_repository.dart';


class HomeLayoutRepositoryImpl implements IHomeLayoutRepository{

  final IHomeLayoutLocalDataSource localDataSource;
  final IHomeLayoutRemoteDataSource remoteDataSource;
  final INetworkInfo networkInfo;


  HomeLayoutRepositoryImpl(this.localDataSource, this.remoteDataSource, this.networkInfo,);

  @override
  Future<Either<ServerFailure, GetDataCampaignsResponse>> getDataCampaigns(GetCampaignsParams params, String token) async{
    try {
      if(!await _checkInternetConnection()) throw const InternetDisconnectedException();
      final result = await remoteDataSource.getCampaignData(params, token);
      return Right(result);
    } on ServerException catch (serverFailure) {
      log("SeverException Error");
      // log("${serverFailure.runtimeType}: ${serverFailure.message}");
      return Left(ServerFailure(serverFailure.message));
    } on DioException catch (dioFailure) {
      log("DioException Error");
      log("${dioFailure.runtimeType}: ${dioFailure.message}, ${dioFailure.stackTrace}");
      return Left(ServerFailure(
          "response type: ${dioFailure.type},${dioFailure.response?.statusMessage ?? dioFailure.message ?? dioFailure.toString()}"));
    }
  }

  @override
  Future<Either<CacheFailure, UserDataResponse>> getCachedData() async {
    try {
      final result = await localDataSource.getCachedData();
      return Right(result);
    } on CacheException catch (failure) {
      return Left(CacheFailure(failure.message));
    }
  }

  Future<bool> _checkInternetConnection() async {
    return networkInfo.isConnected;
  }

  @override
  Future<Either<ServerFailure, void>> checkInternetConnection() async {
    try {
      if(!await _checkInternetConnection()) throw const InternetDisconnectedException();
      return const Right(null);
    } on InternetDisconnectedException {
      return const Left(ServerFailure(EnglishLocalization.noInternetErrorMessage));
    } catch (e){
      log(e.toString());
      return const Left(ServerFailure(EnglishLocalization.genericErrorMessage));
    }
  }

  @override
  Future<Either<ServerFailure, GetCategoriesResponse>> getCategoriesData(String token) async {
    try {
      if(!await _checkInternetConnection()) throw const InternetDisconnectedException();
      final result = await remoteDataSource.getCategories(token);
      return Right(result);
    } on ServerException catch (serverFailure) {
      log("SeverException Error");
      // log("${serverFailure.runtimeType}: ${serverFailure.message}");
      return Left(ServerFailure(serverFailure.message));
    } on DioException catch (dioFailure) {
      log("DioException Error");
      log("${dioFailure.runtimeType}: ${dioFailure.message}, ${dioFailure.stackTrace}");
      return Left(ServerFailure(
          "response type: ${dioFailure.type},${dioFailure.response?.statusMessage ?? dioFailure.message ?? dioFailure.toString()}"));
    }
  }

  @override
  Future<Either<ServerFailure, GetCouponResponse>> getCouponData(GetCouponParams params, String token) async {
    try {
      if(!await _checkInternetConnection()) throw const InternetDisconnectedException();
      final result = await remoteDataSource.getCouponData(params, token);
      return Right(result);
    } on ServerException catch (serverFailure) {
      log("SeverException Error");
      // log("${serverFailure.runtimeType}: ${serverFailure.message}");
      return Left(ServerFailure(serverFailure.message));
    } on DioException catch (dioFailure) {
      log("DioException Error");
      log("${dioFailure.runtimeType}: ${dioFailure.message}, ${dioFailure.stackTrace}");
      return Left(ServerFailure(
          "response type: ${dioFailure.type},${dioFailure.response?.statusMessage ?? dioFailure.message ?? dioFailure.toString()}"));
    }
  }

  @override
  Future<Either<ServerFailure, CreateOrderResponse>> createOrder(CreateOrderParams params, String token) async {
    try {
      if(!await _checkInternetConnection()) throw const InternetDisconnectedException();
    final result = await remoteDataSource.createOrder(params, token);
    return Right(result);
    } on ServerException catch (serverFailure) {
    log("SeverException Error");
    // log("${serverFailure.runtimeType}: ${serverFailure.message}");
    return Left(ServerFailure(serverFailure.message));
    } on DioException catch (dioFailure) {
    log("DioException Error");
    log("${dioFailure.runtimeType}: ${dioFailure.message}, ${dioFailure.stackTrace}");
    return Left(ServerFailure(
    "response type: ${dioFailure.type},${dioFailure.response?.statusMessage ?? dioFailure.message ?? dioFailure.toString()}"));
    }
  }

  @override
  Future<Either<ServerFailure, GetFavoritesResponse>> getFavorites(
      GetFavoritesParams params, String token) async {
    try {
      if (!await _checkInternetConnection()) throw const InternetDisconnectedException();
      final result = await remoteDataSource.getFavorites(params, token);
      return Right(result);
    } on ServerException catch (serverFailure) {
      log("SeverException Error");
      // log("${serverFailure.runtimeType}: ${serverFailure.message}");
      return Left(ServerFailure(serverFailure.message));
    } on DioException catch (dioFailure) {
      log("DioException Error");
      log("${dioFailure.runtimeType}: ${dioFailure.message}, ${dioFailure.stackTrace}");
      return Left(ServerFailure(
          "response type: ${dioFailure.type},${dioFailure.response?.statusMessage ?? dioFailure.message ?? dioFailure.toString()}"));
    }
  }

  @override
  Future<Either<ServerFailure, CreateFavoriteResponse>> createFavorites(CreateFavoriteParams params, String token) async {
    try {
      if (!await _checkInternetConnection()) throw const InternetDisconnectedException();
      final result = await remoteDataSource.createFavorites(params, token);
      return Right(result);
    } on ServerException catch (serverFailure) {
      log("SeverException Error");
      // log("${serverFailure.runtimeType}: ${serverFailure.message}");
      return Left(ServerFailure(serverFailure.message));
    } on DioException catch (dioFailure) {
      log("DioException Error");
      log("${dioFailure.runtimeType}: ${dioFailure.message}, ${dioFailure.stackTrace}");
      return Left(ServerFailure(
          "response type: ${dioFailure.type},${dioFailure.response?.statusMessage ?? dioFailure.message ?? dioFailure.toString()}"));
    }
  }

  @override
  Future<Either<ServerFailure, RemoveFavoriteResponse>> removeFavorites(RemoveFavoriteParams params, String token) async {
    try {
      if (!await _checkInternetConnection()) throw const InternetDisconnectedException();
      final result = await remoteDataSource.removeFavorites(params, token);
      return Right(result);
    } on ServerException catch (serverFailure) {
      log("SeverException Error");
      // log("${serverFailure.runtimeType}: ${serverFailure.message}");
      return Left(ServerFailure(serverFailure.message));
    } on DioException catch (dioFailure) {
      log("DioException Error");
      log("${dioFailure.runtimeType}: ${dioFailure.message}, ${dioFailure.stackTrace}");
      return Left(ServerFailure(
          "response type: ${dioFailure.type},${dioFailure.response?.statusMessage ?? dioFailure.message ?? dioFailure.toString()}"));
    }
  }
}
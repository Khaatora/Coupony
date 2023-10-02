import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maslaha/core/errors/failures/server_failure.dart';
import 'package:maslaha/home/model/get_banner_response.dart';
import 'package:maslaha/home/repository/i_home_repository.dart';

import '../../core/errors/exceptions/api/exceptions.dart';
import '../../core/errors/exceptions/server_exception.dart';
import '../../core/services/network/network_info.dart';
import '../model/datasources/remote_data_source.dart';

class HomeRepositoryImpl implements IHomeRepository{

  final INetworkInfo networkInfo;
  final IHomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.networkInfo, this.remoteDataSource);


  @override
  Future<Either<ServerFailure, GetBannerResponse>> getBannerData(GetBannerParams params) async {
    try {
      if(!await _checkInternetConnection()) throw const InternetDisconnectedException();
      final result = await remoteDataSource.getBannerData(params);
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

  Future<bool> _checkInternetConnection() async {
    return networkInfo.isConnected;
  }
}
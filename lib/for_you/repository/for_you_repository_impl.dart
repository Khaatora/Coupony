import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maslaha/core/errors/failures/server_failure.dart';
import 'package:maslaha/for_you/models/datasources/remote_data_source.dart';
import 'package:maslaha/for_you/models/get_recommendations_response.dart';
import 'package:maslaha/for_you/repository/i_for_you_repository.dart';
import '../../core/errors/exceptions/api/exceptions.dart';
import '../../core/errors/exceptions/server_exception.dart';
import '../../core/services/network/network_info.dart';

class ForYouRepositoryImpl implements IForYouRepository {
  final INetworkInfo networkInfo;
  final IForYouRemoteDataSource remoteDataSource;

  ForYouRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<ServerFailure, GetRecommendationsResponse>> getRecommendations(
      GetRecommendationsParams params, String token) async {
    try {
      if (!await _checkInternetConnection()) throw const InternetDisconnectedException();
      final result = await remoteDataSource.getRecommendations(params, token);
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

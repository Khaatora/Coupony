import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maslaha/core/errors/failures/server_failure.dart';
import 'package:maslaha/sign_in/model/datasources/remote/remote_data_source.dart';
import 'package:maslaha/sign_in/model/login_response.dart';
import 'package:maslaha/sign_in/repository/i_login_repository.dart';

import '../../core/errors/exceptions/api/exceptions.dart';
import '../../core/errors/exceptions/server_exception.dart';
import '../../core/services/device_info/device_info.dart';
import '../../core/services/network/network_info.dart';
import '../../core/services/secured_storage_data/secured_storage_data.dart';
import '../model/guest_login_response.dart';

class LoginRepositoryImpl extends ILoginRepository {
  final ILoginRemoteDataSource remoteDataSource;
  final INetworkInfo networkInfo;
  final IDeviceInfo dipDeviceInfo;

  LoginRepositoryImpl(
      this.remoteDataSource, this.networkInfo, this.dipDeviceInfo);

  @override
  Future<Either<ServerFailure, LoginResponse>> login(LoginParams params) async {
    try {
      _checkInternetConnection();
      final result = await remoteDataSource.login(params);
      return Right(result);
    } on ServerException catch (serverFailure) {
      log("${serverFailure.runtimeType}: ${serverFailure.message}");
      return Left(ServerFailure(serverFailure.message));
    } on DioError catch (dioFailure) {
      log("${dioFailure.runtimeType}: ${dioFailure.message}, ${dioFailure.stackTrace}");
      return Left(ServerFailure(dioFailure.message!));
    }
  }



  @override
  Future<Either<ServerFailure, GuestLoginResponse>> guestLogin() async {
    try {
      await _checkInternetConnection();
      final userAgent = await dipDeviceInfo
          .deviceInfo; // sets params device info using device info service
      final lang = FSSSecuredStorageData.tempCache[LoginJsonKeys.lang];
      final region = FSSSecuredStorageData.tempCache[LoginJsonKeys.region];
      final result = await remoteDataSource.guestLogin(GuestParams(
        region: region,
        lang: lang,
        userAgent: userAgent,
      ));
      return Right(result);
    } on ServerException catch (serverFailure) {
      log("${serverFailure.runtimeType}: ${serverFailure.message}");
      return Left(ServerFailure(serverFailure.message));
    } on DioError catch (dioFailure) {
      log("${dioFailure.runtimeType}: ${dioFailure.message}, ${dioFailure.stackTrace}");
      return Left(ServerFailure(dioFailure.message!));
    }
  }

  Future<void> _checkInternetConnection() async {
    if (!await networkInfo.isConnected) throw const NoInternetException();
  }
}

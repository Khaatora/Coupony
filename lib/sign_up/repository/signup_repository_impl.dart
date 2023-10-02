import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maslaha/core/errors/failures/server_failure.dart';
import 'package:maslaha/core/services/secured_storage_data/secured_storage_data.dart';
import 'package:maslaha/core/MVVM/model/code_verification_response.dart';
import 'package:maslaha/sign_up/model/email_verification_response.dart';
import 'package:maslaha/sign_up/model/signup_response.dart';
import '../../core/constants/cache_constants.dart';
import '../../core/errors/exceptions/api/exceptions.dart';
import '../../core/errors/exceptions/server_exception.dart';
import '../../core/services/device_info/device_info.dart';
import '../../core/services/network/network_info.dart';
import '../model/datasources/remote/remote_data_source.dart';
import 'i_signup_repository.dart';

class SignupRepositoryImpl extends ISignupRepository {
  final ISignupRemoteDataSource remoteDataSource;
  final INetworkInfo networkInfo;
  final IDeviceInfo dipDeviceInfo;

  SignupRepositoryImpl(this.remoteDataSource, this.networkInfo, this.dipDeviceInfo);

  @override
  Future<Either<ServerFailure, SignupResponse>> signup(SignupParams params) async {
    try {
      if(!await _checkInternetConnection()) throw const InternetDisconnectedException();
      final result = await remoteDataSource.signup(params);
      return Right(result);
    } on ServerException catch (serverFailure) {
      log("${serverFailure.runtimeType}: ${serverFailure.message}");
      return Left(ServerFailure(serverFailure.message));
    } on DioException catch (dioFailure) {
      log("${dioFailure.runtimeType}: ${dioFailure.message}, ${dioFailure.stackTrace}");
      return Left(ServerFailure(
          "response type: ${dioFailure.type},${dioFailure.response?.statusMessage ?? dioFailure.message ?? dioFailure.toString()}"));
    }
  }

  @override
  Future<Either<ServerFailure, CodeVerificationResponse>> verifyCode(CodeVerificationParams params) async {
    try {
      if(!await _checkInternetConnection()) throw const InternetDisconnectedException();
      final result = await remoteDataSource.verifyCode(params);
      return Right(result);
    } on ServerException catch (serverFailure) {
      log("${serverFailure.runtimeType}: ${serverFailure.message}");
      return Left(ServerFailure(serverFailure.message));
    } on DioException catch (dioFailure) {
      log("${dioFailure.runtimeType}: ${dioFailure.message}, ${dioFailure.stackTrace}");
      return Left(ServerFailure(
          "response type: ${dioFailure.type},${dioFailure.response?.statusMessage ?? dioFailure.message ?? dioFailure.toString()}"));
    }
  }

  @override
  Future<Either<ServerFailure, EmailVerificationResponse>> verifyEmail(EmailVerificationParams params) async {
    try {
      if(!await _checkInternetConnection()) throw const InternetDisconnectedException();
      params.userAgent = await dipDeviceInfo.deviceInfo; // sets params device info using device info service
      params.lang = FSSSecuredStorageData.tempCache[CachedJsonKeys.lang];
      final result = await remoteDataSource.verifyEmail(params);
      return Right(result);
    } on ServerException catch (serverFailure) {
      log("${serverFailure.runtimeType}: ${serverFailure.message}");
      return Left(ServerFailure(serverFailure.message));
    } on DioException catch (dioFailure) {
      log("${dioFailure.runtimeType}: ${dioFailure.message}, ${dioFailure.stackTrace}");
      return Left(ServerFailure(
          "response type: ${dioFailure.type},${dioFailure.response?.statusMessage ?? dioFailure.message ?? dioFailure.toString()}"));
    }
  }

  Future<bool> _checkInternetConnection() async {
    return networkInfo.isConnected;
  }

}

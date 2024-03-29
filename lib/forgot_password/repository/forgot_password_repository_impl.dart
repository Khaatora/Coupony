import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maslaha/core/errors/exceptions/server_exception.dart';
import 'package:maslaha/core/errors/failures/IFailures.dart';
import 'package:maslaha/forgot_password/model/initiate_password_reset_response.dart';
import 'package:maslaha/forgot_password/model/remote/api_forgot_password_remote_data_source.dart';
import 'package:maslaha/forgot_password/model/reset_password_response.dart';
import 'package:maslaha/forgot_password/repository/i_forgot_password_repository.dart';

import '../../core/MVVM/model/code_verification_response.dart';
import '../../core/errors/exceptions/api/exceptions.dart';
import '../../core/errors/failures/server_failure.dart';
import '../../core/services/network/network_info.dart';

class ForgotPasswordRepositoryImpl extends IForgotPasswordRepository{

  final IForgotPasswordRemoteDataSource remoteDataSource;
  final INetworkInfo networkInfo;


  ForgotPasswordRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<IFailure, InitiatePasswordResetResponse>> initiatePasswordReset(InitiatePasswordResetParams params) async {
    try {
      if(!await _checkInternetConnection()) throw const InternetDisconnectedException();
      final result = await remoteDataSource.initiatePasswordReset(params);
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
  Future<Either<IFailure, ResetPasswordResponse>> resetPassword(ResetPasswordParams params) async {
    try {
      if(!await _checkInternetConnection()) throw const InternetDisconnectedException();
      final result = await remoteDataSource.resetPassword(params);
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

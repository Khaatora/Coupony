import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:maslaha/forgot_password/model/initiate_password_reset_response.dart';
import 'package:maslaha/forgot_password/model/reset_password_response.dart';
import 'package:maslaha/forgot_password/repository/i_forgot_password_repository.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/errors/exceptions/api/exceptions.dart';
import '../../../core/services/services_locator.dart';

abstract class IRemoteDataSource{

  Future<InitiatePasswordResetResponse> initiatePasswordReset(InitiatePasswordResetParams params);

  Future<ResetPasswordResponse> resetPassword(ResetPasswordParams params);

}


class APIRemoteDataSource extends IRemoteDataSource{
  @override
  Future<InitiatePasswordResetResponse> initiatePasswordReset(InitiatePasswordResetParams params) async {
    final response = await sl<Dio>().post(ApiConstants.initiatePasswordResetPath,
        data: jsonEncode(params.toJson()),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    switch (response.statusCode) {
      case 200:
        return InitiatePasswordResetResponse.fromJson(response.data);
    // TODO: other cases
    // case 307:
      default:
        throw const GenericAPIException();
    }

  }

  @override
  Future<ResetPasswordResponse> resetPassword(ResetPasswordParams params) async {
    final response = await sl<Dio>().post(ApiConstants.resetPasswordPath,
        data: jsonEncode(params.toJson()),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    switch (response.statusCode) {
      case 200:
        return ResetPasswordResponse.fromJson(response.data);
    // TODO: other cases
    // case 301:
    // case 308:
      default:
        throw const GenericAPIException();
    }

  }

}
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:maslaha/forgot_password/model/initiate_password_reset_response.dart';
import 'package:maslaha/forgot_password/model/reset_password_response.dart';
import 'package:maslaha/forgot_password/repository/i_forgot_password_repository.dart';

import '../../../core/MVVM/model/code_verification_response.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/errors/exceptions/api/exceptions.dart';
import '../../../core/services/services_locator.dart';

abstract class IForgotPasswordRemoteDataSource{

  Future<InitiatePasswordResetResponse> initiatePasswordReset(InitiatePasswordResetParams params);

  //verify-code
  Future<CodeVerificationResponse> verifyCode(CodeVerificationParams params);

  Future<ResetPasswordResponse> resetPassword(ResetPasswordParams params);

}


class APIForgotPasswordRemoteDataSource extends IForgotPasswordRemoteDataSource{
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
      case 403:
        throw InvalidEmailException(response.data["message"] as String);
      default:
        throw const GenericAPIException();
    }

  }

  @override
  Future<CodeVerificationResponse> verifyCode(CodeVerificationParams params) async {
    final response = await sl<Dio>().post(ApiConstants.verifyCodePath,
        data: jsonEncode(params.toJson()),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    log("response body : ${response.data}, response status code:${response.statusCode}");
    switch (response.statusCode) {
      case 200:
        return CodeVerificationResponse.fromJson(response.data);
      case 403:
        throw IncorrectVerificationCodeException(response.data["message"] as String);
      default:
        throw GenericAPIException(response.data["message"] as String);
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
      case 401:
        throw SessionNotVerifiedException(response.data["message"] as String);
      case 408:
        throw PasswordAlreadyUsedException(response.data["message"] as String);
      default:
        throw const GenericAPIException();
    }

  }

}
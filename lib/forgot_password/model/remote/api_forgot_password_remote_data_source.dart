import 'dart:convert';
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
      case 307:
        throw const InvalidEmailException();
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

    switch (response.statusCode) {
      case 200:
        return CodeVerificationResponse.fromJson(response.data);
      case 304:
        throw const IncorrectVerificationCodeException();
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
      case 301:
        throw const SessionNotVerifiedException();
      case 308:
        throw const PasswordAlreadyUsedException();
      default:
        throw const GenericAPIException();
    }

  }

}
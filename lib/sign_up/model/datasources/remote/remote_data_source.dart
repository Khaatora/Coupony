import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:maslaha/core/constants/api_constants.dart';
import 'package:maslaha/core/errors/exceptions/api/exceptions.dart';
import 'package:maslaha/core/services/secured_storage_data/secured_storage_data.dart';

import '../../../../core/services/services_locator.dart';
import '../../../repository/i_signup_repository.dart';
import '../../../../core/MVVM/model/code_verification_response.dart';
import '../../email_verification_response.dart';
import '../../signup_response.dart';



abstract class ISignupRemoteDataSource {
  //verify-email
  Future<EmailVerificationResponse> verifyEmail(EmailVerificationParams params);

  //verify-code
  Future<CodeVerificationResponse> verifyCode(CodeVerificationParams params);

  //add-user
  Future<SignupResponse> signup(SignupParams params);
}

class APISignupRemoteDataSource extends ISignupRemoteDataSource {

  final ISecuredStorageData securedStorageData;

  APISignupRemoteDataSource(this.securedStorageData);

  @override
  Future<SignupResponse> signup(SignupParams params) async {
    final response = await sl<Dio>().post(ApiConstants.addUserPath,
        data: jsonEncode(params.toJson()),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));

    switch (response.statusCode) {
      case 200:
        securedStorageData.addToken(response.data[SignupJsonKeys.jwt]);
        return SignupResponse.fromJson(response.data);
      // TODO: other cases
      // case 400:
      // case 401:
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
    // TODO: other cases
    // case 400:
    // case 401:
      default:
        throw const GenericAPIException();
    }
  }

  @override
  Future<EmailVerificationResponse> verifyEmail(EmailVerificationParams params) async {
    final response = await sl<Dio>().post(ApiConstants.verifyEmailPath,
        data: jsonEncode(params.toJson()),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));

    switch (response.statusCode) {
      case 200:
        return EmailVerificationResponse.fromJson(response.data);
    // TODO: other cases
    // case 400:
    // case 401:
      default:
        throw const GenericAPIException();
    }
  }

}

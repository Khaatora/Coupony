import 'package:dio/dio.dart';
import 'package:maslaha/core/constants/api_constants.dart';
import 'package:maslaha/core/errors/exceptions/api/exceptions.dart';
import 'package:maslaha/core/services/secured_storage_data/secured_storage_data.dart';
import 'package:maslaha/sign_in/repository/i_login_repository.dart';
import 'dart:convert';
import 'dart:io';


import '../../../../core/services/services_locator.dart';
import '../../login_response.dart';
import '../../guest_login_response.dart';

abstract class ILoginRemoteDataSource {
  
  
  Future<LoginResponse> login(LoginParams params);

  Future<GuestLoginResponse> guestLogin(GuestParams params);

  const ILoginRemoteDataSource();

}

class APILoginRemoteDataSource extends ILoginRemoteDataSource {
  final ISecuredStorageData securedStorageData;

  const APILoginRemoteDataSource(this.securedStorageData);

  @override
  Future<LoginResponse> login(LoginParams params) async {
    final response = await sl<Dio>().post(ApiConstants.loginPath,
        data: jsonEncode(params.toJson()),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));

    switch (response.statusCode) {
      case 200:
        securedStorageData.addToken(response.data[LoginJsonKeys.jwt]);
        securedStorageData.cacheLoggedInUserSettings(response.data[LoginJsonKeys.userSettings]);
        return LoginResponse.fromJson(response.data);
      case 406:
        throw Exception("something went wrong");
        throw InvalidCredentialsException(response.data["message"] as String);
      default:
        throw const GenericAPIException();
    }
  }

  @override
  Future<GuestLoginResponse> guestLogin(GuestParams params) async {
    final response = await sl<Dio>().post(ApiConstants.guestUserPath,
        data: jsonEncode(params.toJson()),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    switch (response.statusCode) {
      case 200:
        securedStorageData.addToken(response.data[GuestLoginKeys.jwt]);
        securedStorageData.cacheLoggedInUserSettings(response.data[GuestLoginKeys.userSettings]);
        return GuestLoginResponse.fromJson(response.data);
      default:
        throw const GenericAPIException();
    }
  }
}

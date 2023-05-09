import 'dart:io';
import 'package:dio/dio.dart';
import 'package:maslaha/core/MVVM/model/token_verification_response.dart';
import '../../../constants/api_constants.dart';
import '../../../errors/exceptions/api/exceptions.dart';
import '../../../services/services_locator.dart';

abstract class ITokenVerificationRemoteDataSource {
  Future<TokenVerificationResponse> validateToken(String token);
}

class APITokenVerificationRemoteDataSource implements ITokenVerificationRemoteDataSource {

  @override
  Future<TokenVerificationResponse> validateToken(String jwt) async {
    final response = await sl<Dio>().post(ApiConstants.verifyTokenPath,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: jwt
        }));
    switch (response.statusCode) {
      case 200:
        return TokenVerificationResponse.fromJson(response.data);
      case 298:
        throw MissingTokenException(response.data["message"]);
      case 299:
        throw ExpiredTokenException(response.data["message"]);
      case 303:
        throw InvalidTokenException(response.data["message"]);
      default:
        throw const GenericAPIException();
    }
  }

}

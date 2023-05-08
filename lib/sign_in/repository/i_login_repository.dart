import 'package:dartz/dartz.dart';
import 'package:maslaha/core/errors/failures/server_failure.dart';
import 'package:maslaha/sign_in/model/login_response.dart';

import '../model/guest_login_response.dart';

abstract class ILoginRepository {
  Future<Either<ServerFailure, LoginResponse>> login(LoginParams params);

  Future<Either<ServerFailure, GuestLoginResponse>> guestLogin();
}

class LoginParams {
  final String email;
  final String password;

  const LoginParams(this.email, this.password);

  Map<String, dynamic> toJson() {
    return {
      LoginJsonKeys.email: email,
      LoginJsonKeys.password: password,
    };
  }
}

class GuestParams{
  final String region;
  final String lang;
  final String userAgent;

  const GuestParams({required this.region, required this.lang, required this.userAgent});

  Map<String, dynamic> toJson() {
    return {
      LoginJsonKeys.region: region,
      LoginJsonKeys.lang: lang,
      LoginJsonKeys.userAgent: userAgent,
    };
  }
}

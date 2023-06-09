import 'package:dartz/dartz.dart';
import 'package:maslaha/core/errors/failures/server_failure.dart';
import '../../core/MVVM/model/code_verification_response.dart';
import '../model/email_verification_response.dart';
import '../model/signup_response.dart';

abstract class ISignupRepository {
  Future<Either<ServerFailure, SignupResponse>> signup(SignupParams params);

  Future<Either<ServerFailure, EmailVerificationResponse>> verifyEmail(
      EmailVerificationParams params);

  Future<Either<ServerFailure, CodeVerificationResponse>> verifyCode(
      CodeVerificationParams params);
}

class CodeVerificationParams {
  final String sessionId;
  final String code;

  CodeVerificationParams(this.sessionId, this.code);

  Map<String, dynamic> toJson() {
    return {
      CodeVerificationJsonKeys.sessionId: sessionId,
      CodeVerificationJsonKeys.code: code,
    };
  }
}

class EmailVerificationParams {
  final String email;
  final String password;
  final String region;
  String lang;
  String userAgent;
  final String dob;

   EmailVerificationParams(
       {this.email = "ahosari20@gmail.com",
    this.password= "a01129376126",
    this.region= "EG",
    this.lang= "arabic",
    this.userAgent= "Maslaha/1.0.0 Model/Moto G (4)",
    this.dob= "2000-05-04",}
  );

  Map<String, dynamic> toJson() {
    return {
      EmailVerificationJsonKeys.email: email,
      EmailVerificationJsonKeys.password: password,
      EmailVerificationJsonKeys.region: region,
      EmailVerificationJsonKeys.lang: lang,
      EmailVerificationJsonKeys.userAgent: userAgent,
      EmailVerificationJsonKeys.dob: dob,

    };
  }
}

class SignupParams {
  final String sessionId;

  const SignupParams(this.sessionId);

  Map<String, dynamic> toJson() {
    return {
      SignupJsonKeys.sessionId: sessionId,
    };
  }
}

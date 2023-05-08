import 'package:dartz/dartz.dart';
import 'package:maslaha/core/errors/failures/IFailures.dart';
import 'package:maslaha/forgot_password/model/initiate_password_reset_response.dart';
import 'package:maslaha/forgot_password/model/reset_password_response.dart';

abstract class IForgotPasswordRepository{

  Future<Either<IFailure, InitiatePasswordResetResponse>> initiatePasswordReset(InitiatePasswordResetParams params);

  Future<Either<IFailure, ResetPasswordResponse>> resetPassword(ResetPasswordParams params);

}

class ResetPasswordParams{
  final String sessionId;
  final String password;

  const ResetPasswordParams(this.sessionId, this.password);

  Map<String, dynamic> toJson(){
    return {
      ResetPasswordJsonKeys.sessionId : sessionId,
      ResetPasswordJsonKeys.password : password,
    };
  }

}

class InitiatePasswordResetParams {
  final String email;

  const InitiatePasswordResetParams(this.email);

  Map<String, dynamic> toJson(){
    return {
      InitiatePasswordResetJsonKeys.email : email,
    };
  }
}
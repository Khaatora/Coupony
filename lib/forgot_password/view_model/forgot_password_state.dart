part of 'forgot_password_cubit.dart';

enum PasswordResetState {
  init,
  verifyingEmail,
  awaitingCodeInput,
  verifyingCode,
  awaitingPasswordInput,
  finishingUp,
  success,
  error
}

class ForgotPasswordState extends Equatable {
  final String email;
  final String password;

  final String sessionId;
  final String code;

  final PasswordResetState passwordResetState;
  final String message;

  const ForgotPasswordState({
    this.email = "",
    this.password = "",
    this.sessionId = "",
    this.code = "",
    this.passwordResetState = PasswordResetState.init,
    this.message = "",
  });

  ForgotPasswordState copyWith({
    String? email,
    String? password,
    String? gender,
    PasswordResetState? passwordResetState,
    String? message,
    String? sessionId,
    String? code,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      password: password ?? this.password,
      sessionId: sessionId ?? this.sessionId,
      code: code ?? this.code,
      passwordResetState: passwordResetState ?? this.passwordResetState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        email,
        password,
        sessionId,
        code,
        passwordResetState,
        message,
      ];
}

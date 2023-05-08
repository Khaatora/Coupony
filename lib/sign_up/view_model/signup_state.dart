part of 'signup_cubit.dart';

enum SignUpState {
  init,
  awaitingCode,
  awaitingUserInput,
  verifyingCode,
  finishingUp,
  success,
  error
}

@immutable
class SignupState extends Equatable {
  // verify-email state
  final String email;
  final String password;
  final String gender;
  final DateTime? dob;

  // verify-code & add-user state
  final String sessionId;
  final String code;

  final SignUpState signUpState;
  final String message;

  const SignupState({
    this.email= "",
    this.password = "",
    this.gender = "Male",
    this.dob,
    this.signUpState = SignUpState.init,
    this.message = "",
    this.sessionId = "NA",
    this.code = "NA",
  });

  SignupState copyWith({
    String? email,
    String? password,
    String? gender,
    DateTime? dob,
    SignUpState? signUpState,
    String? message,
    String? sessionId,
    String? code,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      sessionId: sessionId ?? this.sessionId,
      code: code ?? this.code,
      signUpState: signUpState ?? this.signUpState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        email,
        password,
        gender,
        sessionId,
        code,
        signUpState,
        message,
      ];
}

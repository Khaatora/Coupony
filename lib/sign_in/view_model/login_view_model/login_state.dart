part of 'login_cubit.dart';

enum LoginType {
  account,
  guest,
}

class LoginState extends Equatable {
  final String email;

  // final String password;
  final LoadingState loadingState;

  // final String token;
  final String message;

  final LoginType type;

  const LoginState(
      {required this.email,
      // required this.password,
      this.loadingState = LoadingState.init,
      // this.token = 'unknown',
      this.message = '',
      this.type = LoginType.account});

  LoginState copyWith(
      {String? email,
      // String? password,
      LoadingState? loadingState,
      // String? token,
      String? message,
      LoginType? type}) {
    return LoginState(
      email: email ?? this.email,
      // password: password ?? this.password,
      loadingState: loadingState ?? this.loadingState,
      // token: token ?? this.token,
      message: message ?? this.message,
      type: type ?? this.type,
    );
  }

  @override
  List<Object> get props => [
        email,
        // password,
        loadingState,
        // token,
        message,
        type,
      ];
}

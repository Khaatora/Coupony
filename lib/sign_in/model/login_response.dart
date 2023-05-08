import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  final int status;
  final String jwt;
  final Map<String, String> userSettings;

  const LoginResponse({
    required this.jwt,
    required this.status,
    required this.userSettings,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      jwt: json[LoginJsonKeys.jwt],
      status: json[LoginJsonKeys.status],
      userSettings: json[LoginJsonKeys.userSettings],
    );
  }

  @override
  List<Object?> get props => [
        jwt,
        status,
        userSettings,
      ];
}

class LoginJsonKeys {
  static const String status = "status";
  static const String jwt = "jwt";
  static const String userSettings = "user_settings";
  static const String email = "email";
  static const String password = "password";
  static const String userAgent = "user_agent";
  static const String region = "region";
  static const String lang = "lang";

}

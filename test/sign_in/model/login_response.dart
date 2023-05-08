import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  final int status;
  final String jwt;

  const LoginResponse({
    required this.jwt,
    required this.status,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      jwt: json[LoginJsonKeys.jwt],
      status: json[LoginJsonKeys.status],
    );
  }

  @override
  List<Object?> get props => [
        jwt,
        status,
      ];
}

class LoginJsonKeys {
  static const String status = "status";
  static const String jwt = "jwt";
}

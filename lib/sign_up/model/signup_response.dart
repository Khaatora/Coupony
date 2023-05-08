import 'package:equatable/equatable.dart';

class SignupResponse extends Equatable {
  final int status;
  final String jwt;


  const SignupResponse({
    required this.jwt,
    required this.status,

  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      jwt: json[SignupJsonKeys.jwt],
      status: json[SignupJsonKeys.status],
    );
  }

  @override
  List<Object?> get props => [
        jwt,
        status,
      ];
}

class SignupJsonKeys {
  static const String status = "status";
  static const String jwt = "jwt";
  static const String sessionId = "session_id";
}

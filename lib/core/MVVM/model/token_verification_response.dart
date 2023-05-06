import 'package:equatable/equatable.dart';

class TokenVerificationResponse extends Equatable {
  final int status;
  final String jwt;
  final String message;

  const TokenVerificationResponse({
    required this.status,
    required this.jwt,
    required this.message,
  });

  @override
  List<Object?> get props => [
        status,
        jwt,
        message,
      ];

  factory TokenVerificationResponse.fromJson(Map<String, dynamic> json) {
    return TokenVerificationResponse(
      status: json[TokenVerificationJsonKeys.status],
      jwt: json[TokenVerificationJsonKeys.jwt],
      message: json[TokenVerificationJsonKeys.message],
    );
  }
}

class TokenVerificationJsonKeys {
  static const String jwt = "jwt";
  static const String message = "message";
  static const String status = "status";
}

import 'package:equatable/equatable.dart';

class GuestLoginResponse extends Equatable {
  final int status;
  final String jwt;


  const GuestLoginResponse({
    required this.jwt,
    required this.status,

  });

  factory GuestLoginResponse.fromJson(Map<String, dynamic> json) {
    return GuestLoginResponse(
      jwt: json[GuestLoginKeys.jwt],
      status: json[GuestLoginKeys.status],
    );
  }

  @override
  List<Object?> get props => [
    jwt,
    status,
  ];
}

class GuestLoginKeys {
  static const String status = "status";
  static const String jwt = "jwt";
  static const String sessionId = "session_id";
  static const String userSettings = "user_settings";
}

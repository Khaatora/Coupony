import 'package:equatable/equatable.dart';

class EmailVerificationResponse extends Equatable{
  final int status;
  final String sessionId;



  const EmailVerificationResponse({
    required this.status,
    required this.sessionId,
  });

  factory EmailVerificationResponse.fromJson(Map<String, dynamic> json) {
    return EmailVerificationResponse(
      status: json[EmailVerificationJsonKeys.status],
      sessionId: json[EmailVerificationJsonKeys.sessionId],
    );
  }

  @override
  List<Object?> get props => [
    status,
    sessionId,
  ];
}

class EmailVerificationJsonKeys {
  static const String status = "status";
  static const String password = "password";
  static const String region = "region";
  static const String email = "email";
  static const String lang = "lang";
  static const String userAgent = "user_agent";
  static const String gender = "gender";
  static const String dob = "dob";
  static const String sessionId = "session_id";

}
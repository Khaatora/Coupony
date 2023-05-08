import 'package:equatable/equatable.dart';

class CodeVerificationResponse extends Equatable{
  final int status;
  final String sessionId;
  final String message;


  const CodeVerificationResponse({
    required this.status,
    required this.sessionId,
    required this.message

  });

  factory CodeVerificationResponse.fromJson(Map<String, dynamic> json) {
    return CodeVerificationResponse(
      status: json[CodeVerificationJsonKeys.status],
      sessionId: json[CodeVerificationJsonKeys.sessionId],
      message: json[CodeVerificationJsonKeys.message],
    );
  }

  @override
  List<Object?> get props => [
    status,
    sessionId,
    message
  ];
}

class CodeVerificationJsonKeys {
  static const String status = "status";
  static const String message = "message";
  static const String code = "code";
  static const String sessionId = "session_id";

}
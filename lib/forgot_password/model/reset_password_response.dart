class ResetPasswordResponse{
  final int status;
  final String message;

  const ResetPasswordResponse(this.status, this.message);

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
      json[ResetPasswordJsonKeys.status],
      json[ResetPasswordJsonKeys.message],
    );
  }
}


class ResetPasswordJsonKeys{
  static const String password = "password";
  static const String status = "status";
  static const String sessionId = "session_id";
  static const String message = "message";
}
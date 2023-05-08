class InitiatePasswordResetResponse {
  final int status;
  final String sessionId;

  const InitiatePasswordResetResponse(this.status, this.sessionId);

  factory InitiatePasswordResetResponse.fromJson(Map<String, dynamic> json) {
    return InitiatePasswordResetResponse(
      json[InitiatePasswordResetJsonKeys.status],
      json[InitiatePasswordResetJsonKeys.sessionId],
    );
  }
}

class InitiatePasswordResetJsonKeys {
  static const String email = "email";
  static const String status = "status";
  static const String sessionId = "session_id";
}

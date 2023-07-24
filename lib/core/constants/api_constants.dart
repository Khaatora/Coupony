class ApiConstants {
  static const String apiKey = "";
  static const String baseUrl = "https://16a5-41-47-174-54.eu.ngrok.io/";
  static const String tempBaseUrl = "http://localhost:3000";
  // paths
  static const String verifyTokenPath = "/verify-token";
  static const String verifyCodePath = "/verify-code";
  static const String verifyEmailPath = "/verify-email";
  static const String addUserPath = "/add-user";
  static const String loginPath = "/login";
  static const String initiatePasswordResetPath = "/initiate-password-reset";
  static const String resetPasswordPath = "/reset-password";
  static const String guestUserPath = "/gt";
  static const String getCampaignsData = "/get_campaigns_data";

  static String verifyTokenUrl() => "$baseUrl$loginPath";
  static String verifyCodeUrl() => "$baseUrl$verifyCodePath";
  static String verifyEmailUrl() => "$baseUrl$verifyEmailPath";
  static String addUserUrl() => "$baseUrl$addUserPath";
  static String loginUrl() => "$baseUrl$loginPath";
  static String initiatePasswordResetUrl() =>
      "$baseUrl$initiatePasswordResetPath";
  static String resetPasswordUrl() => "$baseUrl$resetPasswordPath";
  static String guestUserUrl() => "$baseUrl$guestUserPath";
  static String getCampaignsDataUrl() => "$tempBaseUrl$getCampaignsData";
}

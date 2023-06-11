
class ApiConstants{

  static const String apiKey = "";
  static const String baseUrl = "https://3803-197-48-119-47.ngrok-free.app/";
  // paths
  static const String verifyTokenPath = "/verify-token";
  static const String verifyCodePath = "/verify-code";
  static const String verifyEmailPath = "/verify-email";
  static const String addUserPath = "/add-user";
  static const String loginPath = "/login";
  static const String initiatePasswordResetPath = "/initiate-password-reset";
  static const String resetPasswordPath = "/reset-password";
  static const String guestUserPath = "/gt";


  static String verifyTokenUrl() => "$baseUrl$loginPath";
  static String verifyCodeUrl() => "$baseUrl$verifyCodePath";
  static String verifyEmailUrl() => "$baseUrl$verifyEmailPath";
  static String addUserUrl() => "$baseUrl$addUserPath";
  static String loginUrl() => "$baseUrl$loginPath";
  static String initiatePasswordResetUrl() => "$baseUrl$initiatePasswordResetPath";
  static String resetPasswordUrl() => "$baseUrl$resetPasswordPath";
  static String guestUserUrl() => "$baseUrl$guestUserPath";

}
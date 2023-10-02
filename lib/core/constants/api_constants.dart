class ApiConstants {
  static const String apiKey = "";
  static const String baseUrl = "https://9949-65-109-106-118.ngrok-free.app/";
  static const String tempBaseUrl = "http://localhost:3000";
  static const String token = "token";
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
  static const String getCoupon = "/get_coupon";
  static const String getBanner = "/get_banners";
  static const String getCategories = "/get_categories";
  static const String createOrder = "/create_order";
  static const String getRecommendations = "/get_recommendations";
  static const String getFavorites = "/get_favourites";
  static const String createFavorite = "/create_fav";
  static const String destroyFavorite = "/destroy_fav";

  static String verifyTokenUrl() => "$baseUrl$loginPath";
  static String verifyCodeUrl() => "$baseUrl$verifyCodePath";
  static String verifyEmailUrl() => "$baseUrl$verifyEmailPath";
  static String addUserUrl() => "$baseUrl$addUserPath";
  static String loginUrl() => "$baseUrl$loginPath";
  static String initiatePasswordResetUrl() =>
      "$baseUrl$initiatePasswordResetPath";
  static String resetPasswordUrl() => "$baseUrl$resetPasswordPath";
  static String guestUserUrl() => "$baseUrl$guestUserPath";
  static String getCampaignsDataUrl() => "$baseUrl$getCampaignsData";
  static String getCouponUrl() => "$baseUrl$getCoupon";
  static String getBannerUrl() => "$baseUrl$getBanner";
  static String getCategoriesUrl() => "$baseUrl$getCategories";
  static String createOrderUrl() => "$baseUrl$createOrder";
  static String getRecommendationsUrl() => "$baseUrl$getRecommendations";
  static String getFavoritesUrl() => "$baseUrl$getFavorites";
  static String createFavoriteUrl() => "$baseUrl$createFavorite";
  static String destroyFavoriteUrl() => "$baseUrl$destroyFavorite";
}

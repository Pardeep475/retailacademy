class RouteString {
  static final RouteString _routeString = RouteString._internal();

  factory RouteString() {
    return _routeString;
  }

  RouteString._internal();

  static const String splashScreen = "/SPLASH_SCREEN";
  static const String loginScreen = "/LOGIN_SCREEN";
  static const String dashBoardScreen = "/DASHBOARD_SCREEN";
  static const String funFactsAndMasterClassScreen =
      "/FUN_FACTS_AND_MASTER_CLASS_SCREEN";
  static const String funFactsAndMasterClassContentScreen =
      "/FUN_FACTS_AND_MASTER_CLASS_CONTENT_SCREEN";
  static const String forgotPasswordScreen = "/FORGOT_PASSWORD_SCREEN";
  static const String whatsHotBlogScreen = "/WHATS_HOT_BLOG_SCREEN";
  static const String whatsHotBlogContentScreen =
      "/WHATS_HOT_BLOG_CONTENT_SCREEN";
  static const String podCastScreen = "/POD_CAST_SCREEN";
  static const String quizMasterScreen = "/QUIZ_MASTER_SCREEN";
  static const String podCastContentScreen = "/POD_CAST_CONTENT_SCREEN";
  static const String podCastDetailScreen = "/POD_CAST_DETAIL_SCREEN";
  static const String quizMasterDetailScreen = "/QUIZ_MASTER_DETAIL_SCREEN";
  static const String retailReelsContentScreen =
      "/RETAIL_REELS_CONTENT_SCREEN";
}

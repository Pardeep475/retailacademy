class RouteString {
  static final RouteString _routeString = RouteString._internal();

  factory RouteString() {
    return _routeString;
  }

  RouteString._internal();

  static const String splashScreen = "/SPLASH_SCREEN";
  static const String loginScreen = "/LOGIN_SCREEN";
  static const String dashBoardScreen = "/DASHBOARD_SCREEN";
  static const String funFactsAndMasterClassScreen = "/FUN_FACTS_AND_MASTER_CLASS_SCREEN";
  static const String forgotPasswordScreen = "/FORGOT_PASSWORD_SCREEN";

}
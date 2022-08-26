class BindingConst {
  static final BindingConst _bindingConst = BindingConst._internal();

  factory BindingConst() {
    return _bindingConst;
  }

  BindingConst._internal();

  static const String splashScreenBinding = "SPLASH_SCREEN_BINDING";
  static const String loginScreenBinding = "LOGIN_SCREEN_BINDING";
  static const String dashboardScreenBinding = "DASHBOARD_SCREEN_BINDING";
  static const String homeScreenBinding = "HOME_SCREEN_BINDING";
  static const String knowledgeScreenBinding = "KNOWLEDGE_SCREEN_BINDING";
  static const String retailReelsScreenBinding = "RETAIL_REELS_SCREEN_BINDING";
  static const String infoSessionsScreenBinding = "INFO_SESSIONS_SCREEN_BINDING";
  static const String profileScreenBinding = "PROFILE_SCREEN_BINDING";
  static const String funFactsAndMasterClassScreenBinding = "FUN_FACTS_AND_MASTER_CLASS_SCREEN_BINDING";

}
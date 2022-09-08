class ApiConstants {
  static final ApiConstants _apiConstants = ApiConstants._internal();

  factory ApiConstants() {
    return _apiConstants;
  }

  ApiConstants._internal();
  // live
  static String baseUrl = "https://demo1kentico8.raybiztech.com/api/";
  // local
  // static String baseUrl = "http://3190-2405-201-300b-38-85cd-c84c-4b95-dd45.ngrok.io";


  // live
  static String onLoginApi = "UserAuthentication";
  static String onForgotPasswordApi = "ForgotPasswordV2";
  static String onLogoutApi = "Logout";
  static String getPointsApi = "RetailStatus";
  static String getTrendingApi = "ActivityStreamList";
  static String addTrendingLike = "ActivityStreamLike";
  static String getContentKnowledgeSection = "ContentListV2";



}

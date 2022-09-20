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

  static String fetchUserDetails({required String userId}) =>
      "UserDetailsShow?userid=$userId";
  static String updateProfileImage = "ProfilePhotoUpdate";
  static String getPointsApi = "RetailStatus";
  static String getTrendingApi({required String userId,required String orgId}) => "ActivityStreamList?userid=$userId&orgid=$orgId";
  static String getTrendingApiWithPagination = "ActivityStreamList";
  static String getKnowledgeApi({required String userId,required String orgId}) => "FolderListV2?userid=$userId&orgid=$orgId";
  static String addTrendingLike = "ActivityStreamLike";
  static String getContentKnowledgeSection = "ContentListV2";
  static String likeOrDislikeContentKnowledgeSection = "ContentLikes";
  static String fetchBlogCategories = "BlogCategory";
  static String fetchBlogContent = "Blog";
  static String fetchBlogLikeContent = "BlogLikes";
}

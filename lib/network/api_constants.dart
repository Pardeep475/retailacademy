class ApiConstants {
  static final ApiConstants _apiConstants = ApiConstants._internal();

  factory ApiConstants() {
    return _apiConstants;
  }

  ApiConstants._internal();

  // live
  static String baseUrl = "https://demo5kentico8.raybiztech.com/api/";

  // static String baseUrl = "https://demo1kentico8.raybiztech.com/api/";

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

  static String getTrendingApi(
          {required String userId, required String orgId}) =>
      "ActivityStreamList?userid=$userId&orgid=$orgId";
  static String getTrendingApiWithPagination = "ActivityStreamList";

  static String getKnowledgeApi(
          {required String userId, required String orgId}) =>
      "FolderListV2?userid=$userId&orgid=$orgId";
  static String addTrendingLike = "ActivityStreamLike";
  static String getContentKnowledgeSection = "ContentListV2";
  static String likeOrDislikeContentKnowledgeSection = "ContentLikes";
  static String fetchBlogCategories = "BlogCategory";
  static String fetchBlogContent = "Blog";
  static String fetchBlogLikeContent = "BlogLikes";

  static String getQuizCategory(
          {required String userId, required String orgId}) =>
      "UserQuizCategoryInfoV2?userid=$userId&orgid=$orgId";
  static String consolidatedQuizQuestions = "ConsolidatedQuizQuestions";
  static String trendingCommentList = "ActivityStreamCommentList";
  static String knowledgeCommentList = "ContentComments";
  static String trendingDeleteCommentApi = "ActivityStreamDeleteComment";
  static String knowledgeContentDeleteCommentApi = "ContentDeleteComment";

  static String fetchRetailReelsCategories({required String userId}) =>
      "ReelCategory?userid=$userId";
  static String fetchRetailReelsList = "ReelsList";
  static String retailReelsLike = "ReelLikes";
  static String retailReelsComments = "ReelComments";
  static String retailReelsDeleteComments = "ReelDeleteComment";

  // podcast api's
  static String recentPodcastList(
          {required String userId, required String orgId}) =>
      "RecentPodcastList?userid=$userId&orgid=$orgId";
  static String podcastList = 'PodcastList';
  static String podcastContinueListeningList({required String userId}) => 'ContinueListeningPodcastList?userId=$userId';
  static String podcastCategory({required String userId}) => 'PodcastCategory?userid=$userId';
  static String podcastLike = 'PodcastLikes';
  static String podcastDeleteComment = 'PodcastDeleteComment';
  static String podcastCommentList = 'PodcastCommentList';
  static String podcastViewedByUser = 'PodcastViewedByUser';
  static String maintenanceMessage = 'MaintenanceMessage';
  static String contentDisplayApi = 'ContentDisplay';
  static String whatsHotBlogCommentApi = 'AddBlogPost';
  static String whatsHotBlogDeleteCommentApi = 'BlogDeleteComment';
}

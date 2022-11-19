import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:retail_academy/network/modal/knowledge/like_or_dislike_content_knowledge_section_request.dart';
import 'package:retail_academy/network/modal/knowledge/whats_hot_blog_content_response.dart';
import 'package:retail_academy/network/modal/login/login_request.dart';
import 'package:retail_academy/network/modal/login/login_response.dart';
import 'package:retail_academy/network/modal/notification/notification_list_request.dart';
import 'package:retail_academy/network/modal/podcast/pod_cast_request.dart';
import 'package:retail_academy/network/modal/points/point_response.dart';
import 'package:retail_academy/network/modal/trending/like_trending_request.dart';
import 'package:retail_academy/network/modal/trending/trending_response.dart';
import '../common/app_strings.dart';
import '../common/utils.dart';
import 'api_constants.dart';
import 'logging_interceptor.dart';
import 'modal/base/base_response.dart';
import 'modal/forgot_password/forgot_password_request.dart';
import 'modal/info_session/info_session_registration_request.dart';
import 'modal/info_session/info_session_response.dart';
import 'modal/knowledge/consolidated_quiz_questions_request.dart';
import 'modal/knowledge/consolidated_quiz_questions_response.dart';
import 'modal/knowledge/content_display_request.dart';
import 'modal/knowledge/content_display_response.dart';
import 'modal/knowledge/content_knowledge_request.dart';
import 'modal/knowledge/content_knowledge_response.dart';
import 'modal/knowledge/delete_knowledge_content_request.dart';
import 'modal/knowledge/knowledge_api_response.dart';
import 'modal/knowledge/knowledge_content_comment_request.dart';
import 'modal/knowledge/knowledge_content_comment_response.dart';
import 'modal/knowledge/quiz_category_response.dart';
import 'modal/knowledge/whats_hot_blog_comment_request.dart';
import 'modal/knowledge/whats_hot_blog_comment_response.dart';
import 'modal/knowledge/whats_hot_blog_content_like_or_dislike.dart';
import 'modal/knowledge/whats_hot_blog_content_request.dart';
import 'modal/knowledge/whats_hot_blog_delete_comment_request.dart';
import 'modal/knowledge/whats_hot_blog_response.dart';
import 'modal/maintainance_message/maintainance_message_response.dart';
import 'modal/notification/notification_enable_request.dart';
import 'modal/notification/notification_list_response.dart';
import 'modal/podcast/pod_cast_category_response.dart';
import 'modal/podcast/pod_cast_comment_request.dart';
import 'modal/podcast/pod_cast_comment_response.dart';
import 'modal/podcast/pod_cast_delete_comment_request.dart';
import 'modal/podcast/pod_cast_like_request.dart';
import 'modal/podcast/pod_cast_response.dart';
import 'modal/podcast/pod_cast_viewed_by_user_request.dart';
import 'modal/points/point_request.dart';
import 'modal/profile/logout_request.dart';
import 'modal/profile/logout_response.dart';
import 'modal/profile/profile_response.dart';
import 'modal/profile/update_profile_image_request.dart';
import 'modal/retails_reels/retail_reels_categories_response.dart';
import 'modal/retails_reels/retail_reels_comment_request.dart';
import 'modal/retails_reels/retail_reels_comment_response.dart';
import 'modal/retails_reels/retail_reels_delete_comment_request.dart';
import 'modal/retails_reels/retail_reels_like_request.dart';
import 'modal/retails_reels/retail_reels_list_request.dart';
import 'modal/retails_reels/retail_reels_list_response.dart';
import 'modal/trending/delete_trending_request.dart';
import 'modal/trending/trending_comment_request.dart';
import 'modal/trending/trending_comment_response.dart';
import 'modal/trending/trending_pagination_request.dart';

class ApiProvider {
  static final ApiProvider apiProvider = ApiProvider._internal();

  factory ApiProvider() {
    return apiProvider;
  }

  ApiProvider._internal();

  static BaseOptions options = BaseOptions(
    receiveTimeout: 90000000,
    connectTimeout: 90000000,
    baseUrl: ApiConstants.baseUrl,
  );

  static final Dio _dio = Dio(options)..interceptors.add(LoggingInterceptor());

  Future<dynamic> loginApi({required LoginRequest request}) async {
    try {
      Response response = await _dio.post(
        ApiConstants.onLoginApi,
        data: request.toJson(),
      );
      return LoginResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> logoutApi({required LogoutRequest request}) async {
    try {
      Response response = await _dio.post(
        ApiConstants.onLogoutApi,
        data: request.toJson(),
      );
      return LogoutResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> fetchUserDetails({required String userId}) async {
    try {
      Response response = await _dio.get(
        ApiConstants.fetchUserDetails(userId: userId),
      );
      return ProfileResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> updateProfileImage(
      {required UpdateProfileImageRequest request}) async {
    try {
      Response response = await _dio.post(
        ApiConstants.updateProfileImage,
        data: request.toJson(),
      );
      return BaseResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> pointsApi({required PointRequest request}) async {
    try {
      Response response = await _dio.post(
        ApiConstants.getPointsApi,
        data: request.toJson(),
      );
      return PointResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> getTrendingApi(
      {required String userId, required String orgId}) async {
    try {
      Response response = await _dio.get(
        ApiConstants.getTrendingApi(userId: userId, orgId: orgId),
      );
      return TrendingResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> getTrendingApiWithPagination(
      {required TrendingPaginationRequest request}) async {
    try {
      Response response = await _dio.post(
        ApiConstants.getTrendingApiWithPagination,
        data: request.toJson(),
      );
      return TrendingResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> trendingLikeApi(
      {required LikeTrendingRequest request}) async {
    try {
      Response response = await _dio.post(
        ApiConstants.addTrendingLike,
        data: request.toJson(),
      );
      return BaseResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> forgotPasswordApi(
      {required ForgotPasswordRequest request}) async {
    try {
      Response response = await _dio.post(
        ApiConstants.onForgotPasswordApi,
        data: request.toJson(),
      );
      return BaseResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> getKnowledgeApi(
      {required String userId, required String orgId}) async {
    try {
      Response response = await _dio.get(
        ApiConstants.getKnowledgeApi(userId: userId, orgId: orgId),
      );
      return KnowledgeApiResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> getContentKnowledgeSectionApi(
      {required ContentKnowledgeRequest request}) async {
    try {
      Response response = await _dio.post(
        ApiConstants.getContentKnowledgeSection,
        data: request.toJson(),
      );
      return ContentKnowledgeResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> likeOrDislikeContentKnowledgeSectionApi(
      {required LikeOrDislikeContentKnowledgeSectionRequest request}) async {
    try {
      Response response = await _dio.post(
        ApiConstants.likeOrDislikeContentKnowledgeSection,
        data: request.toJson(),
      );
      return BaseResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> fetchWhatsHotBlog() async {
    try {
      Response response = await _dio.get(
        ApiConstants.fetchBlogCategories,
      );
      return WhatsHotBlogResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> fetchWhatsHotBlogContent(
      {required WhatsHotBlogContentRequest request}) async {
    try {
      Response response = await _dio.post(
        ApiConstants.fetchBlogContent,
        data: request.toJson(),
      );
      return WhatsHotBlogContentResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> likeOrDislikeBlogApi(
      {required WhatsHotBlogContentLikeOrDisLikeRequest request}) async {
    try {
      Response response = await _dio.post(
        ApiConstants.fetchBlogLikeContent,
        data: request.toJson(),
      );
      return BaseResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> getQuizCategoryApi(
      {required String userId, required String orgId}) async {
    try {
      Response response = await _dio.get(
        ApiConstants.getQuizCategory(userId: userId, orgId: orgId),
      );
      return QuizCategoryResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> consolidatedQuizQuestionsApi(
      {required ConsolidatedQuizQuestions request}) async {
    try {
      Response response = await _dio.post(
        ApiConstants.consolidatedQuizQuestions,
        data: request.toJson(),
      );
      return ConsolidatedQuizQuestionsResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> consolidatedQuizSubmitApi(
      {required ConsolidatedQuizQuestions request}) async {
    try {
      Response response = await _dio.post(
        ApiConstants.consolidatedQuizQuestions,
        data: request.toJson(),
      );
      return response;
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> trendingCommentsApi(
      {required TrendingCommentRequest request}) async {
    try {
      Response response = await _dio.post(
        ApiConstants.trendingCommentList,
        data: request.toJson(),
      );
      return TrendingCommentResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> knowledgeContentCommentsApi(
      {required KnowledgeContentCommentRequest request}) async {
    try {
      Response response = await _dio.post(
        ApiConstants.knowledgeCommentList,
        data: request.toJson(),
      );
      return KnowledgeContentCommentResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

//  trendingDeleteCommentApi

  Future<dynamic> deleteTrendingCommentApi(
      {required DeleteTrendingRequest request}) async {
    debugPrint('Request_COMMENT:-  ${request.toJson()}');
    try {
      Response response = await _dio.post(
        ApiConstants.trendingDeleteCommentApi,
        data: request.toJson(),
      );
      return BaseResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> deleteKnowledgeContentCommentApi(
      {required DeleteKnowledgeContentRequest request}) async {
    try {
      Response response = await _dio.post(
        ApiConstants.knowledgeContentDeleteCommentApi,
        data: request.toJson(),
      );
      return BaseResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> fetchRetailsReelsCategories({required String userId}) async {
    try {
      Response response = await _dio.get(
        ApiConstants.fetchRetailReelsCategories(userId: userId),
      );
      return RetailReelsCategoriesResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> fetchRetailsReelsList(
      {required RetailReelsListRequest request}) async {
    try {
      Response response = await _dio.post(
        ApiConstants.fetchRetailReelsList,
        data: request.toJson(),
      );
      return RetailReelsListResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> fetchRetailsReelsLike(
      {required RetailReelsLikeRequest request}) async {
    try {
      Response response = await _dio.post(
        ApiConstants.retailReelsLike,
        data: request.toJson(),
      );
      return BaseResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> fetchRetailsReelsComment(
      {required RetailReelsCommentRequest request}) async {
    try {
      Response response = await _dio.post(
        ApiConstants.retailReelsComments,
        data: request.toJson(),
      );
      return RetailReelsCommentResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> fetchRetailsReelsDeleteComment(
      {required RetailReelsDeleteCommentRequest request}) async {
    try {
      Response response = await _dio.post(
        ApiConstants.retailReelsDeleteComments,
        data: request.toJson(),
      );
      return BaseResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  // podcast api's
  Future<dynamic> getRecentPodcastListApi(
      {required String userId, required String orgId}) async {
    try {
      Response response = await _dio.get(
        ApiConstants.recentPodcastList(userId: userId, orgId: orgId),
      );
      return PodCastResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> getPodcastCategoryListApi({required String userId}) async {
    try {
      Response response = await _dio.get(
        ApiConstants.podcastCategory(userId: userId),
      );
      return PodCastCategoryResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> getPodcastContinueListeningListApi(
      {required String userId}) async {
    try {
      Response response = await _dio.get(
        ApiConstants.podcastContinueListeningList(userId: userId),
      );
      return PodCastResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> getPodcastListApi({required PodCastRequest request}) async {
    try {
      Response response = await _dio.post(
        ApiConstants.podcastList,
        data: request.toJson(),
      );
      return PodCastResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> podcastLikeApi({required PodCastLikeRequest request}) async {
    try {
      Response response = await _dio.post(
        ApiConstants.podcastLike,
        data: request.toJson(),
      );
      return BaseResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> podcastDeleteCommentApi(
      {required PodCastDeleteCommentRequest request}) async {
    try {
      Response response = await _dio.post(
        ApiConstants.podcastDeleteComment,
        data: request.toJson(),
      );
      return BaseResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> fetchAndAddPodcastCommentApi(
      {required PodCastCommentRequest request}) async {
    try {
      Response response = await _dio.post(
        ApiConstants.podcastCommentList,
        data: request.toJson(),
      );
      return PodCastCommentResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> podcastViewedByUserApi(
      {required PodcastViewedByUserRequest request}) async {
    debugPrint('PODCAST_DURATION:-  ${request.toJson()}');
    try {
      Response response = await _dio.post(
        ApiConstants.podcastViewedByUser,
        data: request.toJson(),
      );
      return BaseResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> maintenanceMessageApi() async {
    try {
      Response response = await _dio.get(
        ApiConstants.maintenanceMessage,
      );
      return MaintenanceMessageResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> contentDisplayApi(
      {required ContentDisplayRequest request}) async {
    debugPrint('PODCAST_DURATION:-  ${request.toJson()}');
    try {
      Response response = await _dio.post(
        ApiConstants.contentDisplayApi,
        data: request.toJson(),
      );
      // quizid
      return ContentDisplayResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> whatsHotBlogCommentsApi(
      {required WhatsHotBlogCommentRequest request}) async {
    try {
      Response response = await _dio.post(
        ApiConstants.whatsHotBlogCommentApi,
        data: request.toJson(),
      );
      return WhatsHotBlogCommentResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> whatsHotBlogDeleteCommentsApi(
      {required WhatsHotBlogDeleteCommentRequest request}) async {
    try {
      Response response = await _dio.post(
        ApiConstants.whatsHotBlogDeleteCommentApi,
        data: request.toJson(),
      );
      return BaseResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> getInfoSession({required String userId}) async {
    try {
      Response response = await _dio.get(
        ApiConstants.infoSession(userId: userId),
      );
      return InfoSessionResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> getInfoSessionRegistration(
      {required InfoSessionRegistrationRequest request}) async {
    try {
      Response response = await _dio.post(
        ApiConstants.infoSessionZoomRegister,
        data: request.toJson(),
      );
      return BaseResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> notificationEnableApi(
      {required NotificationEnableRequest request}) async {
    try {
      Response response = await _dio.post(
        ApiConstants.notificationEnableDisable,
        data: request.toJson(),
      );
      return BaseResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> fetchNotificationListApi(
      {required NotificationListRequest request}) async {
    try {
      Response response = await _dio.post(
        ApiConstants.notificationList,
        data: request.toJson(),
      );
      return NotificationListResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }
}

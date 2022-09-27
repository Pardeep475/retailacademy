import 'package:dio/dio.dart';
import 'package:retail_academy/network/modal/knowledge/like_or_dislike_content_knowledge_section_request.dart';
import 'package:retail_academy/network/modal/knowledge/whats_hot_blog_content_response.dart';
import 'package:retail_academy/network/modal/login/login_request.dart';
import 'package:retail_academy/network/modal/login/login_response.dart';
import 'package:retail_academy/network/modal/points/point_response.dart';
import 'package:retail_academy/network/modal/trending/like_trending_request.dart';
import 'package:retail_academy/network/modal/trending/trending_response.dart';
import '../common/app_strings.dart';
import '../common/utils.dart';
import 'api_constants.dart';
import 'logging_interceptor.dart';
import 'modal/base/base_response.dart';
import 'modal/forgot_password/forgot_password_request.dart';
import 'modal/knowledge/consolidated_quiz_questions_request.dart';
import 'modal/knowledge/consolidated_quiz_questions_response.dart';
import 'modal/knowledge/content_knowledge_request.dart';
import 'modal/knowledge/content_knowledge_response.dart';
import 'modal/knowledge/knowledge_api_response.dart';
import 'modal/knowledge/knowledge_content_comment_request.dart';
import 'modal/knowledge/knowledge_content_comment_response.dart';
import 'modal/knowledge/quiz_category_response.dart';
import 'modal/knowledge/whats_hot_blog_content_like_or_dislike.dart';
import 'modal/knowledge/whats_hot_blog_content_request.dart';
import 'modal/knowledge/whats_hot_blog_response.dart';
import 'modal/points/point_request.dart';
import 'modal/profile/logout_request.dart';
import 'modal/profile/logout_response.dart';
import 'modal/profile/profile_response.dart';
import 'modal/profile/update_profile_image_request.dart';
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
}

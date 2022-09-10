import 'package:dio/dio.dart';
import 'package:retail_academy/network/modal/knowledge/like_or_dislike_content_knowledge_section_request.dart';
import 'package:retail_academy/network/modal/login/login_request.dart';
import 'package:retail_academy/network/modal/login/login_response.dart';
import 'package:retail_academy/network/modal/logout/logout_response.dart';
import 'package:retail_academy/network/modal/points/point_response.dart';
import 'package:retail_academy/network/modal/trending/like_trending_request.dart';
import 'package:retail_academy/network/modal/trending/trending_response.dart';
import '../common/app_strings.dart';
import '../common/utils.dart';
import 'api_constants.dart';
import 'logging_interceptor.dart';
import 'modal/base/base_response.dart';
import 'modal/forgot_password/forgot_password_request.dart';
import 'modal/knowledge/content_knowledge_request.dart';
import 'modal/knowledge/content_knowledge_response.dart';
import 'modal/logout/logout_request.dart';
import 'modal/points/point_request.dart';

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
        ApiConstants.getTrendingApi + '?userid=$userId&orgid=$orgId',
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

  Future<dynamic> getContentKnowledgeSectionApi({required ContentKnowledgeRequest request}) async {
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

}

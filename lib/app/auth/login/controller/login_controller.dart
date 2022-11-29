import 'dart:io';

import 'package:get/get.dart';
import 'package:retail_academy/network/modal/login/login_request.dart';
import 'package:retail_academy/network/modal/login/login_response.dart';
import '../../../../common/app_strings.dart';
import '../../../../common/local_storage/session_manager.dart';
import '../../../../common/routes/route_strings.dart';
import '../../../../common/utils.dart';
import '../../../../network/api_provider.dart';
import '../../../../network/modal/login/recent_user_activity_request.dart';
import '../../../../network/modal/points/point_request.dart';
import '../../../../network/modal/points/point_response.dart';

class LoginController extends GetxController {
  var showLoader = false.obs;

  String? validateEmail({required String? value}) {
    if (value == null || value.isEmpty) {
      return AppStrings.usernameIsRequired;
    }
    return null;
  }

  String? validatePassword({required String? value}) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordIsRequired;
    }

    return null;
  }

  @override
  void onInit() {
    super.onInit();
    clearAllData();
    Utils.logger.e("on init");
  }

  @override
  void onReady() {
    super.onReady();
    Utils.logger.e("on ready");
  }

  @override
  void onClose() {
    super.onClose();
    Utils.logger.e("on close");
  }

  void clearAllData() {
    showLoader.value = false;
  }

  Future fetchUserResponseApi(
      {required String userName, required String password}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        String platform = Platform.isAndroid ? "android" : "ios";
        var response = await ApiProvider.apiProvider.loginApi(
            request: LoginRequest.name('employeenumber', userName.trim(),
                'deviceToken', platform, password.trim()));
        if (response != null) {
          LoginResponse loginResponse = (response as LoginResponse);
          if (loginResponse.status) {
            getPointsApi(loginResponse: loginResponse, userName: userName);
          } else {
            Utils.errorSnackBar(AppStrings.error, loginResponse.message);
          }
        }
      } catch (e) {
        Utils.errorSnackBar(AppStrings.error, e.toString());
      } finally {
        showLoader.value = false;
      }
    }
    return null;
  }

  Future getPointsApi(
      {required LoginResponse loginResponse, required String userName}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        var response = await ApiProvider.apiProvider.pointsApi(
          request: PointRequest(
            userid: loginResponse.userid,
          ),
        );
        if (response != null) {
          PointResponse value = (response as PointResponse);
          if (value.status) {
            if (value.leaderBoardUserList != null &&
                value.leaderBoardUserList!.isNotEmpty) {
              AppStrings.pointConstant =
                  value.leaderBoardUserList![0].points.toString();
            }
          }
        }

        await ApiProvider.apiProvider.onRecentUserActivityApi(
          request: RecentUserActivityRequest(
              userId: loginResponse.userid,
              startDate: '2022-06-01',
              endDate: '2022-06-06',
              brandGuid: AppStrings.brandUDID),
        );
      } finally {
        showLoader.value = false;
        Utils.logger.e("token_is:-   ${loginResponse.jwtToken}");
        Utils.logger.e("token_is:-   ${loginResponse.userid}");
        SessionManager.setToken(loginResponse.jwtToken);
        SessionManager.setUserName(userName);
        SessionManager.setUserEmail(loginResponse.emailID);
        SessionManager.setUserId(loginResponse.userid);
        var userId = await SessionManager.getUserId();
        Utils.logger.e("token_is:-   $userId");
        SessionManager.setDeviceToken('deviceToken');
        SessionManager.setLogin(true);
        Get.offAndToNamed(
          RouteString.dashBoardScreen,
        );
      }
    }
    return null;
  }
}

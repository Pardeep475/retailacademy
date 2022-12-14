import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:retail_academy/network/modal/login/login_request.dart';
import 'package:retail_academy/network/modal/login/login_response.dart';

import '../../../../common/app_strings.dart';
import '../../../../common/local_storage/session_manager.dart';
import '../../../../common/routes/route_strings.dart';
import '../../../../common/utils.dart';
import '../../../../network/api_provider.dart';
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

  Future fetchUserResponseApi(
      {required String userName, required String password}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        String platform = Platform.isAndroid ? "android" : "ios";
        var response = await ApiProvider.apiProvider.loginApi(
            request: LoginRequest.name(
                'employeenumber', userName, 'deviceToken', platform, password));
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
        String userId = await SessionManager.getUserId();
        var response = await ApiProvider.apiProvider.pointsApi(
          request: PointRequest(
            userid: userId,
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
      } finally {
        showLoader.value = false;
        Utils.logger.e("token_is:-   ${loginResponse.jwtToken}");
        SessionManager.setToken(loginResponse.jwtToken);
        SessionManager.setUserName(userName);
        SessionManager.setUserId(loginResponse.userid);
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

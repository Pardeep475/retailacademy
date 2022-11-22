import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:retail_academy/network/modal/points/point_request.dart';
import 'package:retail_academy/network/modal/points/point_response.dart';

import '../../../../common/app_strings.dart';
import '../../../../common/local_storage/session_manager.dart';
import '../../../../common/routes/route_strings.dart';
import '../../../../common/utils.dart';
import '../../../../network/api_provider.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getPointsApi();
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

  openFurtherScreen() async {
    Future.delayed(const Duration(milliseconds: 3000), () async {
      bool isLogin = await SessionManager.isLogin();

      Get.offAndToNamed(
          isLogin ? RouteString.dashBoardScreen : RouteString.loginScreen);
    });
  }

  Future getPointsApi() async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
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
        bool isLogin = await SessionManager.isLogin();
        
        Get.offAndToNamed(
            isLogin ? RouteString.dashBoardScreen : RouteString.loginScreen);
      }
    }
    return null;
  }
}

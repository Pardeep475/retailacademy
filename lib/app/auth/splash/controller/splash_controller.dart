import 'package:get/get.dart';
import 'package:retail_academy/network/modal/points/point_request.dart';
import 'package:retail_academy/network/modal/points/point_response.dart';

import '../../../../common/app_strings.dart';
import '../../../../common/local_storage/session_manager.dart';
import '../../../../common/routes/route_strings.dart';
import '../../../../common/utils.dart';
import '../../../../network/api_provider.dart';
import '../../../../network/modal/login/login_response.dart';
import '../../../../network/modal/login/recent_user_activity_request.dart';
import '../../../../network/modal/login/user_verification_request.dart';

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

  Future getPointsApi() async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        String userId = await SessionManager.getUserId();
        if (userId.isNotEmpty) {
          String? jwtToken = await SessionManager.getToken();
          if (jwtToken != null) {
            var userVerificationApi =
                await ApiProvider.apiProvider.onUserVerificationApi(
              request: UserVerificationRequest(jwtToken: jwtToken),
            );
            LoginResponse value = (userVerificationApi as LoginResponse);
            SessionManager.setToken(value.jwtToken);
          }
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

          await ApiProvider.apiProvider.onRecentUserActivityApi(
            request: RecentUserActivityRequest(
                userId: userId,
                startDate: '2022-06-01',
                endDate: '2022-06-06',
                brandGuid: AppStrings.brandUDID),
          );
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

import 'dart:io';

import 'package:get/get.dart';
import 'package:retail_academy/common/local_storage/session_manager.dart';
import 'package:retail_academy/network/modal/logout/logout_request.dart';
import 'package:retail_academy/network/modal/logout/logout_response.dart';

import '../../../common/app_strings.dart';
import '../../../common/routes/route_strings.dart';
import '../../../common/utils.dart';
import '../../../network/api_provider.dart';

class ProfileController extends GetxController {
  var showLoader = false.obs;
  var notificationSwitchEnabled = false.obs;

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

  updateNotificationSwitch(bool value) {
    notificationSwitchEnabled.value = value;
  }

  Future logoutApi() async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        String platform = Platform.isAndroid ? "android" : "ios";
        String deviceToken = await SessionManager.getDeviceToken();
        String userId = await SessionManager.getUserId();
        var response = await ApiProvider.apiProvider.logoutApi(
          request: LogoutRequest(
            deviceToken: deviceToken,
            platform: platform,
            userid: userId,
          ),
        );

        if (response != null) {
          LogoutResponse value = (response as LogoutResponse);
          if (value.status) {
            Utils.errorSnackBar(AppStrings.success, value.message,
                isSuccess: true);
            await SessionManager.clearAllData();
            Get.offAndToNamed(RouteString.loginScreen);
          } else {
            Utils.errorSnackBar(AppStrings.error, value.message);
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
}

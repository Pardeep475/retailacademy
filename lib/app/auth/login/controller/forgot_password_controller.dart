import 'package:get/get.dart';
import 'package:retail_academy/network/modal/base/base_response.dart';
import 'package:retail_academy/network/modal/forgot_password/forgot_password_request.dart';

import '../../../../common/app_strings.dart';
import '../../../../common/utils.dart';
import '../../../../network/api_provider.dart';

class ForgotPasswordController extends GetxController {
  var showLoader = false.obs;

  String? validateEmail({required String? value}) {
    if (value == null || value.isEmpty) {
      return AppStrings.emailIsRequired;
    } else if (!GetUtils.isEmail(value)) {
      return AppStrings.provideValidEmail;
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

  void clearAllData(){
    showLoader.value = false;
  }

  Future forgotPasswordApi({
    required String emailId,
  }) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        var response = await ApiProvider.apiProvider.forgotPasswordApi(
            request: ForgotPasswordRequest(emailId: emailId));
        if (response != null) {
          BaseResponse baseResponse = (response as BaseResponse);
          if (baseResponse.status) {
            Get.back();
            Utils.errorSnackBar(AppStrings.success, baseResponse.message,
                isSuccess: true);
          } else {
            Utils.errorSnackBar(AppStrings.error, baseResponse.message);
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

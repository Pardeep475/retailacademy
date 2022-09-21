import 'package:get/get.dart';
import 'package:retail_academy/network/modal/base/base_response.dart';
import 'package:retail_academy/network/modal/forgot_password/forgot_password_request.dart';

import '../../../../common/app_strings.dart';
import '../../../../common/utils.dart';
import '../../../../network/api_provider.dart';

class HelpAndContactRetailController extends GetxController {
  var showLoader = false.obs;

  String? validateValue({required String? value, required int screenType}) {
    if (value == null || value.isEmpty) {
      if (screenType == 0) {
        // help == 0, contact retail == 1
        return AppStrings.valueIsRequired;
      } else {
        return AppStrings.valueIsRequired;
      }
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

  Future helpApi({
    required String txt,
  }) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        var response = await ApiProvider.apiProvider
            .forgotPasswordApi(request: ForgotPasswordRequest(emailId: txt));
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

  Future contactRetailApi({
    required String txt,
  }) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        var response = await ApiProvider.apiProvider
            .forgotPasswordApi(request: ForgotPasswordRequest(emailId: txt));
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

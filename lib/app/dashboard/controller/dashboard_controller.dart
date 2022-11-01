import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:retail_academy/network/modal/maintainance_message/maintainance_message_response.dart';
import '../../../../common/utils.dart';
import '../../../common/app_color.dart';
import '../../../common/app_strings.dart';
import '../../../common/widget/alert_dialog_box.dart';
import '../../../common/widget/app_text.dart';
import '../../../network/api_provider.dart';

class DashboardController extends GetxController {
  var showLoader = false.obs;

  var currentSelectedIndex = 0.obs;

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

  void clearAllData(){
   showLoader.value = false;
   currentSelectedIndex.value = 0;
  }

  updateCurrentIndex(int selectedIndex) {
    currentSelectedIndex.value = selectedIndex;
  }

  Future maintenanceMessageApi() async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        var response = await ApiProvider.apiProvider.maintenanceMessageApi();
        if (response != null) {
          MaintenanceMessageResponse maintenanceMessageResponse =
              (response as MaintenanceMessageResponse);
          if (maintenanceMessageResponse.status &&
              maintenanceMessageResponse.maintenanceMessage != null) {
            _commonDialog(
                title: maintenanceMessageResponse.maintenanceMessage!.message,
                barrierDismissible: maintenanceMessageResponse.navigation,
                onPressed: () {
                  if (maintenanceMessageResponse.navigation) {
                    Get.back();
                  } else {
                    // TODO clear the application
                    SystemNavigator.pop();
                  }
                });
          }
        }
      } catch (e) {
        Utils.errorSnackBar(AppStrings.error, e.toString());
      }
    }
    return null;
  }

  _commonDialog(
      {required String title,
      VoidCallback? onPressed,
      bool barrierDismissible = true}) {
    AlertDialogBox(
      showCrossIcon: true,
      context: Get.context!,
      barrierDismissible: barrierDismissible,
      padding: EdgeInsets.zero,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 15.h,
              ),
              AppText(
                text: AppStrings.alert,
                textSize: 22.sp,
                color: AppColor.black,
                maxLines: 2,
                lineHeight: 1.3,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 15.h,
              ),
              Divider(
                height: 1.sp,
                color: AppColor.grey,
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.h),
                child: AppText(
                  text: title,
                  textSize: 18.sp,
                  color: AppColor.black,
                  maxLines: 10,
                  textAlign: TextAlign.center,
                  lineHeight: 1.3,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Divider(
                height: 1.sp,
                color: AppColor.grey,
              ),
              Row(
                children: [
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onPressed ?? () => Get.back(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 18.h),
                          child: AppText(
                            text: AppStrings.ok,
                            textSize: 22.sp,
                            color: Colors.lightBlue,
                            maxLines: 2,
                            lineHeight: 1.3,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ).show();
  }
}

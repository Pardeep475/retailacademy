import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/app_strings.dart';
import '../../../common/local_storage/session_manager.dart';
import '../../../common/utils.dart';
import '../../../network/api_provider.dart';
import '../../../network/modal/retails_reels/retail_reels_categories_response.dart';

class RetailReelsController extends GetxController {
  var showLoader = false.obs;
  final RxList<RetailReelsCategoryElement> dataList = RxList();

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

  Future fetchRetailsReelsCategoriesApi({bool isLoader = true}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        if (isLoader) {
          showLoader.value = true;
        }
        String userId = await SessionManager.getUserId();

        var response = await ApiProvider.apiProvider
            .fetchRetailsReelsCategories(userId: userId);
        if (response != null) {
          RetailReelsCategoriesResponse retailReelsCategoriesResponse =
              (response as RetailReelsCategoriesResponse);
          if (retailReelsCategoriesResponse.status) {
            dataList.clear();
            dataList.addAll(
                retailReelsCategoriesResponse.retailReelsCategoryList ?? []);
            int value = 0;
            for (int i = 0; i < dataList.length; i++) {
              dataList[i].color = colorList[value];
              if (value == 8) {
                value = 0;
              } else {
                value = ++value;
              }
            }
            dataList.refresh();
          } else {
            Utils.errorSnackBar(
                AppStrings.error, retailReelsCategoriesResponse.message);
          }
        }
      } catch (e) {
        Utils.errorSnackBar(AppStrings.error, e.toString());
      } finally {
        if (isLoader) {
          showLoader.value = false;
        }
      }
    }
    return null;
  }
}

const colorList = [
  Color(0xffFCED22),
  Color(0xff83E7F7),
  Color(0xffF76D6D),
  Color(0xffF8A5AD),
  Color(0xffE3A541),
  Color(0xffC1FF5C),
  Color(0xff74F7C5),
  Color(0xffA66CFF),
  Color(0xffFFBC85),
];

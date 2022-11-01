import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/app_strings.dart';
import '../../../common/local_storage/session_manager.dart';
import '../../../common/utils.dart';
import '../../../network/api_provider.dart';
import '../../../network/modal/podcast/pod_cast_category_response.dart';
import '../../../network/modal/podcast/pod_cast_response.dart';

class PodCastController extends GetxController {
  var showLoader = true.obs;

  RxList<PodcastElement> recentDataList = RxList();
  RxList<PodcastElement> continueListeningDataList = RxList();
  RxList<PodCastCategoryElement> categoryDataList = RxList();

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

  void clearAllData() {
    showLoader.value = false;
    recentDataList = RxList();
    continueListeningDataList = RxList();
    categoryDataList = RxList();
  }

  Future getPodCastApi({bool isLoader = true}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        if (isLoader) {
          showLoader.value = true;
        }
        String userId = await SessionManager.getUserId();
        var responses = await Future.wait([
          ApiProvider.apiProvider
              .getPodcastContinueListeningListApi(userId: userId),
          ApiProvider.apiProvider
              .getRecentPodcastListApi(userId: userId, orgId: AppStrings.orgId),
          ApiProvider.apiProvider.getPodcastCategoryListApi(userId: userId),
        ]);
        _updateAllList(responses);
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

  _updateAllList(List<dynamic> responses) {
    for (int i = 0; i < responses.length; i++) {
      if (responses[i] == null) {
        continue;
      }
      switch (i) {
        case 0:
          {
            if (responses[i].status) {
              continueListeningDataList.clear();
              continueListeningDataList.addAll(responses[i].podcasts ?? []);
            } /*else {
              Utils.errorSnackBar(AppStrings.error, responses[i].message);
            }*/
          }
          break;
        case 1:
          {
            if (responses[i].status) {
              recentDataList.clear();
              recentDataList.addAll(responses[i].podcasts ?? []);
            } else {
              Utils.errorSnackBar(AppStrings.error, responses[i].message);
            }
          }
          break;
        case 2:
          {
            if (responses[i].status) {
              categoryDataList.clear();
              categoryDataList.addAll(responses[i].podCastCategoryList ?? []);
              int value = 0;
              for (int i = 0; i < categoryDataList.length; i++) {
                categoryDataList[i].color = colorList[value];
                if (value == 8) {
                  value = 0;
                } else {
                  value = ++value;
                }
              }
            } else {
              Utils.errorSnackBar(AppStrings.error, responses[i].message);
            }
          }
          break;
        default:
          {}
      }
    }
    continueListeningDataList.refresh();
    recentDataList.refresh();
    categoryDataList.refresh();
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

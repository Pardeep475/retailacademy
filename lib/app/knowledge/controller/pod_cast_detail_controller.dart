import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/app_strings.dart';
import '../../../common/local_storage/session_manager.dart';
import '../../../common/utils.dart';
import '../../../network/api_provider.dart';
import '../../../network/modal/base/base_response.dart';
import '../../../network/modal/knowledge/whats_hot_blog_response.dart';
import '../../../network/modal/podcast/pod_cast_like_request.dart';
import '../../../network/modal/podcast/pod_cast_response.dart';
import '../../../network/modal/podcast/pod_cast_viewed_by_user_request.dart';

class PodCastDetailController extends GetxController {
  var showLoader = true.obs;
  var showLoaderQuiz = false.obs;
  PodcastElement? item;
  var hasLiked = false.obs;
  RxList<BlogCategoryElement> dataList = RxList();
  var timeSpentOnPodcast = '00:00:00';

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
    showLoaderQuiz.value = false;
    item = null;
    hasLiked.value = false;
    dataList = RxList();
    timeSpentOnPodcast = '00:00';
  }

  // Future getQuizMasterApi({bool isLoader = true}) async {
  //   bool value = await Utils.checkConnectivity();
  //   if (value) {
  //     try {
  //       if (isLoader) {
  //         showLoader.value = true;
  //       }
  //       var response = await ApiProvider.apiProvider.fetchWhatsHotBlog();
  //       if (response != null) {
  //         WhatsHotBlogResponse whatsHotBlogResponse =
  //             (response as WhatsHotBlogResponse);
  //         if (whatsHotBlogResponse.status) {
  //           dataList.clear();
  //           dataList.addAll(whatsHotBlogResponse.blogCategoryList ?? []);
  //           dataList.refresh();
  //         } else {
  //           Utils.errorSnackBar(AppStrings.error, whatsHotBlogResponse.message);
  //         }
  //       }
  //     } catch (e) {
  //       Utils.errorSnackBar(AppStrings.error, e.toString());
  //     } finally {
  //       if (isLoader) {
  //         showLoader.value = false;
  //       }
  //     }
  //   }
  //   return null;
  // }

  Future likeOrDislikePodcastApi({required int podcastId}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        String userId = await SessionManager.getUserId();
        var response = await ApiProvider.apiProvider.podcastLikeApi(
          request: PodCastLikeRequest(
            podcastId: podcastId,
            userId: userId,
          ),
        );
        if (response != null) {
          BaseResponse baseResponse = (response as BaseResponse);
          hasLiked.value =baseResponse.status;
        }
      } catch (e) {
        Utils.errorSnackBar(AppStrings.error, e.toString());
      } finally {
        showLoader.value = false;
      }
    }
    return null;
  }

  Future podcastViewedByUserApi(
      {required int podcastId, bool isBackPressed = false}) async {
    debugPrint('TIME_SPENT:-  $timeSpentOnPodcast');
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        String userId = await SessionManager.getUserId();
        await ApiProvider.apiProvider.podcastViewedByUserApi(
          request: PodcastViewedByUserRequest(
              podcastId: podcastId.toString(),
              userid: userId,
              userSpentOnPodcast: timeSpentOnPodcast),
        );
      } catch (e) {
        Utils.errorSnackBar(AppStrings.error, e.toString());
      } finally {
        showLoader.value = false;
        if (isBackPressed) {
          Get.back(result: hasLiked.value);
        }
      }
    }
    return null;
  }
}

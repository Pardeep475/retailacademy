import 'package:get/get.dart';

import '../../../common/app_strings.dart';
import '../../../common/local_storage/session_manager.dart';
import '../../../common/utils.dart';
import '../../../network/api_provider.dart';
import '../../../network/modal/base/base_response.dart';
import '../../../network/modal/podcast/pod_cast_category_response.dart';
import '../../../network/modal/podcast/pod_cast_like_request.dart';
import '../../../network/modal/podcast/pod_cast_request.dart';
import '../../../network/modal/podcast/pod_cast_response.dart';

class PodCastContentController extends GetxController {
  var showLoader = false.obs;
  final RxList<PodcastElement> dataList = RxList();
  PodCastCategoryElement? item;

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

  Future getPodCastApi({bool isLoader = true}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        if (isLoader) {
          showLoader.value = true;
        }
        String userId = await SessionManager.getUserId();
        var response = await ApiProvider.apiProvider.getPodcastListApi(
          request: PodCastRequest(
              userId: userId,
              podcastCategoryId: item == null ? -1 : item!.podCastCategoryId),
        );

        if (response != null) {
          PodCastResponse podCastResponse = (response as PodCastResponse);
          if (podCastResponse.status) {
            dataList.clear();
            dataList.addAll(podCastResponse.podcasts ?? []);
            dataList.refresh();
          } else {
            Utils.errorSnackBar(AppStrings.error, podCastResponse.message);
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

  Future likeOrDislikePodcastApi(
      {required int index, required int podcastId}) async {
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
          updateLikePodCast(index: index, value: baseResponse.status);
        }
      } catch (e) {
        Utils.errorSnackBar(AppStrings.error, e.toString());
      } finally {
        showLoader.value = false;
      }
    }
    return null;
  }

  updateLikePodCast({required int index, required bool value}) {
    PodcastElement item = dataList[index];
    item.hasLiked = value;
    dataList[index] = item;
    dataList.refresh();
  }
}

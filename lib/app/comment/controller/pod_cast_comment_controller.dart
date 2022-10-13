import 'package:get/get.dart';

import '../../../common/app_strings.dart';
import '../../../common/local_storage/session_manager.dart';
import '../../../common/utils.dart';
import '../../../network/api_provider.dart';
import '../../../network/modal/base/base_response.dart';
import '../../../network/modal/podcast/pod_cast_comment_request.dart';
import '../../../network/modal/podcast/pod_cast_comment_response.dart';
import '../../../network/modal/podcast/pod_cast_delete_comment_request.dart';
import '../../../network/modal/podcast/pod_cast_like_request.dart';

class PodCastCommentController extends GetxController {
  var showLoader = false.obs;
  RxList<PodcastCommentElement> dataList = RxList();
  var showPagination = false.obs;
  int podCastId = 0;
  var userProfileImage = ''.obs;
  var hasLiked = false.obs;
  var isCommentShown = true.obs;
  var userId = '';

  @override
  void onInit() {
    super.onInit();
    Utils.logger.e("on init");
  }

  clearValues() {
    showLoader.value = false;
    dataList = RxList();
    showPagination.value = false;
    podCastId = 0;
    userProfileImage.value = '';
    hasLiked.value = false;
    isCommentShown.value = true;
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

  fetchProfileImage() async {
    var img = await SessionManager.getProfileImage();
    userProfileImage.value = img;
  }

  Future podCastCommentsApi({bool isLoader = true}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        if (isLoader) {
          showLoader.value = true;
        }
        if (userId.isEmpty) {
          userId = await SessionManager.getUserId();
        }
        var response =
            await ApiProvider.apiProvider.fetchAndAddPodcastCommentApi(
          request: PodCastCommentRequest(
              userId: userId, podcastId: podCastId.toString()),
        );
        if (response != null) {
          PodCastCommentResponse podCastCommentResponse =
              (response as PodCastCommentResponse);
          if (podCastCommentResponse.status) {
            dataList.clear();
            dataList.addAll(podCastCommentResponse.podcastComments ?? []);
            dataList.refresh();
          } else {
            if (podCastCommentResponse.message.isNotEmpty) {
              Utils.errorSnackBar(
                  AppStrings.error, podCastCommentResponse.message);
            }
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

  Future podCastPostCommentsApi({required String comment}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        if (userId.isEmpty) {
          userId = await SessionManager.getUserId();
        }
        var response =
            await ApiProvider.apiProvider.fetchAndAddPodcastCommentApi(
          request: PodCastCommentRequest(
              userId: userId,
              podcastId: podCastId.toString(),
              podcastCommentPost: comment),
        );
        if (response != null) {
          PodCastCommentResponse podCastCommentResponse =
              (response as PodCastCommentResponse);
          if (podCastCommentResponse.status) {
            if (podCastCommentResponse.podcastComments != null) {
              dataList.add(podCastCommentResponse.podcastComments!.first);
              dataList.refresh();
            }
          } else {
            if (podCastCommentResponse.message.isNotEmpty) {
              Utils.errorSnackBar(
                  AppStrings.error, podCastCommentResponse.message);
            }
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

// Future getTrendingApiWithPagination() async {
//   bool value = await Utils.checkConnectivity();
//   if (value) {
//     try {
//       showPagination.value = true;
//       String userId = await SessionManager.getUserId();
//       var response =
//           await ApiProvider.apiProvider.getTrendingApiWithPagination(
//         request: TrendingPaginationRequest(
//             userId: int.parse(userId),
//             orgId: AppStrings.orgId,
//             aIDAfter: dataList[dataList.length - 1].activityStreamId),
//       );
//       if (response != null) {
//         TrendingResponse trendingResponse = (response as TrendingResponse);
//         if (trendingResponse.status) {
//           dataList.addAll(trendingResponse.activityStreams ?? []);
//           dataList.refresh();
//         } else {
//           Utils.errorSnackBar(AppStrings.error, trendingResponse.message);
//         }
//       }
//     } catch (e) {
//       Utils.errorSnackBar(AppStrings.error, e.toString());
//     } finally {
//       showPagination.value = false;
//     }
//   }
//   return null;
// }

  Future podCastLikeApi() async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        String userId = await SessionManager.getUserId();
        var response = await ApiProvider.apiProvider.podcastLikeApi(
          request: PodCastLikeRequest(
            podcastId: podCastId,
            userId: userId,
          ),
        );
        if (response != null) {
          BaseResponse baseResponse = (response as BaseResponse);
          hasLiked.value = baseResponse.status;
          // if (baseResponse.status) {
          //   hasLiked.value = !hasLiked.value;
          // } else {
          //   if (baseResponse.message.isNotEmpty) {
          //     Utils.errorSnackBar(AppStrings.error, baseResponse.message);
          //   }
          // }
        }
      } catch (e) {
        Utils.errorSnackBar(AppStrings.error, e.toString());
      } finally {
        showLoader.value = false;
      }
    }
    return null;
  }

  updateCommentShown() {
    isCommentShown.value = !isCommentShown.value;
  }

  Future deletePodCastApi({required int index, required int commentId}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        if (userId.isEmpty) {
          userId = await SessionManager.getUserId();
        }
        var response = await ApiProvider.apiProvider.podcastDeleteCommentApi(
            request: PodCastDeleteCommentRequest(
          commentId: commentId.toString(),
          podcastId: podCastId.toString(),
          userId: userId,
        ));
        if (response != null) {
          BaseResponse baseResponse = (response as BaseResponse);
          if (baseResponse.status) {
            dataList.removeAt(index);
            dataList.refresh();
          } else {
            if (baseResponse.message.isNotEmpty) {
              Utils.errorSnackBar(AppStrings.error, baseResponse.message);
            }
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

  fetchUserId() async {
    userId = await SessionManager.getUserId();
  }
}

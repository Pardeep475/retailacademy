import 'package:get/get.dart';

import '../../../common/app_strings.dart';
import '../../../common/local_storage/session_manager.dart';
import '../../../common/utils.dart';
import '../../../network/api_provider.dart';
import '../../../network/modal/base/base_response.dart';
import '../../../network/modal/retails_reels/retail_reels_comment_request.dart';
import '../../../network/modal/retails_reels/retail_reels_comment_response.dart';
import '../../../network/modal/retails_reels/retail_reels_delete_comment_request.dart';
import '../../../network/modal/retails_reels/retail_reels_like_request.dart';

class RetailReelsCommentController extends GetxController {
  var showLoader = false.obs;
  RxList<ReelCommentElement> dataList = RxList();
  var showPagination = false.obs;
  int reelId = 0;
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
    reelId = 0;
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

  Future retailReelsCommentsApi({bool isLoader = true}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        if (isLoader) {
          showLoader.value = true;
        }
        if (userId.isEmpty) {
          userId = await SessionManager.getUserId();
        }
        var response = await ApiProvider.apiProvider.fetchRetailsReelsComment(
          request: RetailReelsCommentRequest(
              userId: userId, reelId: reelId.toString()),
        );
        if (response != null) {
          RetailReelsCommentResponse reelsCommentResponse =
              (response as RetailReelsCommentResponse);
          if (reelsCommentResponse.status) {
            dataList.clear();
            dataList.addAll(reelsCommentResponse.reelComments ?? []);
            dataList.refresh();
          } else {
            if (reelsCommentResponse.message.isNotEmpty) {
              Utils.errorSnackBar(
                  AppStrings.error, reelsCommentResponse.message);
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

  Future retailReelsPostCommentsApi({required String comment}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        if (userId.isEmpty) {
          userId = await SessionManager.getUserId();
        }
        var response = await ApiProvider.apiProvider.fetchRetailsReelsComment(
          request: RetailReelsCommentRequest(
              userId: userId, reelId: reelId.toString(), commentText: comment),
        );
        if (response != null) {
          RetailReelsCommentResponse reelsCommentResponse =
              (response as RetailReelsCommentResponse);
          if (reelsCommentResponse.status) {
            if (reelsCommentResponse.reelComments != null) {
              dataList.add(reelsCommentResponse.reelComments!.first);
              dataList.refresh();
            }
          } else {
            if (reelsCommentResponse.message.isNotEmpty) {
              Utils.errorSnackBar(
                  AppStrings.error, reelsCommentResponse.message);
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

  Future retailReelsLikeApi() async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        String userId = await SessionManager.getUserId();
        var response = await ApiProvider.apiProvider.fetchRetailsReelsLike(
          request: RetailReelsLikeRequest(
            reelId: reelId.toString(),
            userId: userId,
          ),
        );
        if (response != null) {
          BaseResponse baseResponse = (response as BaseResponse);
          if (baseResponse.status) {
            hasLiked.value = !hasLiked.value;
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

  updateCommentShown() {
    isCommentShown.value = !isCommentShown.value;
  }

  Future deleteRetailReelsApi(
      {required int index, required int commentId}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        if (userId.isEmpty) {
          userId = await SessionManager.getUserId();
        }
        var response =
            await ApiProvider.apiProvider.fetchRetailsReelsDeleteComment(
                request: RetailReelsDeleteCommentRequest(
          commentId: commentId.toString(),
          reelId: reelId.toString(),
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

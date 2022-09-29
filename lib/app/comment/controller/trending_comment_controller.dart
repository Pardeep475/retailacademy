import 'package:get/get.dart';

import '../../../common/app_strings.dart';
import '../../../common/local_storage/session_manager.dart';
import '../../../common/utils.dart';
import '../../../network/api_provider.dart';
import '../../../network/modal/base/base_response.dart';
import '../../../network/modal/trending/delete_trending_request.dart';
import '../../../network/modal/trending/like_trending_request.dart';
import '../../../network/modal/trending/trending_comment_request.dart';
import '../../../network/modal/trending/trending_comment_response.dart';

class TrendingCommentController extends GetxController {
  var showLoader = false.obs;
  RxList<CommentElement> dataList = RxList();
  var showPagination = false.obs;
  int activityStreamId = 0;
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
    activityStreamId = 0;
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

  Future trendingCommentsApi({bool isLoader = true}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        if (isLoader) {
          showLoader.value = true;
        }
        if (userId.isEmpty) {
          userId = await SessionManager.getUserId();
        }
        var response = await ApiProvider.apiProvider.trendingCommentsApi(
          request: TrendingCommentRequest(
              userid: userId, activityStreamId: activityStreamId),
        );
        if (response != null) {
          TrendingCommentResponse trendingCommentResponse =
              (response as TrendingCommentResponse);
          if (trendingCommentResponse.status) {
            dataList.clear();
            dataList.addAll(trendingCommentResponse.commentElementList ?? []);
            dataList.refresh();
          } else {
            if (trendingCommentResponse.message.isNotEmpty) {
              Utils.errorSnackBar(
                  AppStrings.error, trendingCommentResponse.message);
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

  Future postCommentsApi({required String comment}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        if (userId.isEmpty) {
          userId = await SessionManager.getUserId();
        }
        var response = await ApiProvider.apiProvider.trendingCommentsApi(
          request: TrendingCommentRequest(
              userid: userId,
              activityStreamId: activityStreamId,
              comment: comment),
        );
        if (response != null) {
          TrendingCommentResponse trendingCommentResponse =
              (response as TrendingCommentResponse);
          if (trendingCommentResponse.status) {
            if (trendingCommentResponse.commentElementList != null) {
              dataList.add(trendingCommentResponse.commentElementList!.first);
              dataList.refresh();
            }
          } else {
            if (trendingCommentResponse.message.isNotEmpty) {
              Utils.errorSnackBar(
                  AppStrings.error, trendingCommentResponse.message);
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

  Future trendingLikeApi() async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        if (userId.isEmpty) {
          userId = await SessionManager.getUserId();
        }
        var response = await ApiProvider.apiProvider.trendingLikeApi(
            request: LikeTrendingRequest(
          orgId: AppStrings.orgId,
          activityStreamId: activityStreamId,
          userid: userId,
        ));
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

  Future deleteTrendingApi({required int index, required int commentId}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        if (userId.isEmpty) {
          userId = await SessionManager.getUserId();
        }
        var response = await ApiProvider.apiProvider.deleteTrendingCommentApi(
            request: DeleteTrendingRequest(
          commentId: commentId,
          activityStreamId: activityStreamId,
          userId: int.parse(userId),
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

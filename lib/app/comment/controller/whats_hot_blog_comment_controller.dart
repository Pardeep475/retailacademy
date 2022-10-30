import 'package:get/get.dart';

import '../../../common/app_strings.dart';
import '../../../common/local_storage/session_manager.dart';
import '../../../common/utils.dart';
import '../../../network/api_provider.dart';
import '../../../network/modal/base/base_response.dart';
import '../../../network/modal/knowledge/whats_hot_blog_comment_request.dart';
import '../../../network/modal/knowledge/whats_hot_blog_comment_response.dart';
import '../../../network/modal/knowledge/whats_hot_blog_delete_comment_request.dart';
import '../../../network/modal/trending/delete_trending_request.dart';

class WhatsHotBlogCommentController extends GetxController {
  var showLoader = false.obs;
  RxList<BlogCommentElement> dataList = RxList();
  var showPagination = false.obs;
  int blogId = 0;
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
    blogId = 0;
    userProfileImage.value = '';
    hasLiked.value = false;
    isCommentShown.value = true;
    userId = '';
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

  Future blogsCommentsApi({bool isLoader = true}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        if (isLoader) {
          showLoader.value = true;
        }
        if (userId.isEmpty) {
          userId = await SessionManager.getUserId();
        }
        var response = await ApiProvider.apiProvider.whatsHotBlogCommentsApi(
          request: WhatsHotBlogCommentRequest(userId: userId, blogId: blogId),
        );
        if (response != null) {
          WhatsHotBlogCommentResponse commentResponse =
              (response as WhatsHotBlogCommentResponse);
          if (commentResponse.status) {
            dataList.clear();
            dataList.addAll(commentResponse.blogComments ?? []);
            dataList.refresh();
          } else {
            // if (trendingCommentResponse.message.isNotEmpty) {
            //   Utils.errorSnackBar(
            //       AppStrings.error, trendingCommentResponse.message);
            // }
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
        var response = await ApiProvider.apiProvider.whatsHotBlogCommentsApi(
          request: WhatsHotBlogCommentRequest(
              userId: userId, blogId: blogId, blogPost: comment),
        );
        if (response != null) {
          WhatsHotBlogCommentResponse commentResponse =
              (response as WhatsHotBlogCommentResponse);
          if (commentResponse.status) {
            if (commentResponse.blogComments != null) {
              dataList.add(commentResponse.blogComments!.first);
              dataList.refresh();
            }
          } else {
            if (commentResponse.message.isNotEmpty) {
              Utils.errorSnackBar(AppStrings.error, commentResponse.message);
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
//             aIDAfter: dataList[dataList.length - 1].blogId),
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

  // Future blogsLikeApi() async {
  //   bool value = await Utils.checkConnectivity();
  //   if (value) {
  //     try {
  //       showLoader.value = true;
  //       if (userId.isEmpty) {
  //         userId = await SessionManager.getUserId();
  //       }
  //       var response = await ApiProvider.apiProvider.trendingLikeApi(
  //           request: LikeTrendingRequest(
  //         orgId: AppStrings.orgId,
  //         blogId: blogId,
  //         userid: userId,
  //       ));
  //       if (response != null) {
  //         BaseResponse baseResponse = (response as BaseResponse);
  //         if (baseResponse.status) {
  //           hasLiked.value = !hasLiked.value;
  //         } else {
  //           if (baseResponse.message.isNotEmpty) {
  //             Utils.errorSnackBar(AppStrings.error, baseResponse.message);
  //           }
  //         }
  //       }
  //     } catch (e) {
  //       Utils.errorSnackBar(AppStrings.error, e.toString());
  //     } finally {
  //       showLoader.value = false;
  //     }
  //   }
  //   return null;
  // }

  updateCommentShown() {
    isCommentShown.value = !isCommentShown.value;
  }

  Future deleteBlogsApi({required int index, required int commentId}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        if (userId.isEmpty) {
          userId = await SessionManager.getUserId();
        }
        var response =
            await ApiProvider.apiProvider.whatsHotBlogDeleteCommentsApi(
                request: WhatsHotBlogDeleteCommentRequest(
          commentId: commentId,
          blogId: blogId,
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

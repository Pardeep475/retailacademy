
import 'package:get/get.dart';

import '../../../common/app_strings.dart';
import '../../../common/local_storage/session_manager.dart';
import '../../../common/utils.dart';
import '../../../network/api_provider.dart';
import '../../../network/modal/base/base_response.dart';
import '../../../network/modal/knowledge/whats_hot_blog_content_like_or_dislike.dart';
import '../../../network/modal/knowledge/whats_hot_blog_content_request.dart';
import '../../../network/modal/knowledge/whats_hot_blog_content_response.dart';

class WhatsHotBlogDetailController extends GetxController {
  var showLoader = false.obs;
  var hasLiked = false.obs;
  var blogDescription = ''.obs;
  var videoUrl = ''.obs;

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
    hasLiked.value = false;
    blogDescription.value = '';
    videoUrl.value = '';
  }

  Future fetchWhatsHotContentApi(
      {required int categoryId, required int blogId}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;

        String userId = await SessionManager.getUserId();
        WhatsHotBlogContentRequest request = WhatsHotBlogContentRequest(
            userId: int.parse(userId), categoryId: categoryId, blogId: blogId);
        var response = await ApiProvider.apiProvider
            .fetchWhatsHotBlogContent(request: request);
        if (response != null) {
          WhatsHotBlogContentResponse whatsHotBlogContentResponse =
              (response as WhatsHotBlogContentResponse);
          if (whatsHotBlogContentResponse.status &&
              whatsHotBlogContentResponse.blogContentList != null &&
              whatsHotBlogContentResponse.blogContentList!.isNotEmpty) {
            BlogContentElement blogContentElement =
                whatsHotBlogContentResponse.blogContentList!.first;
            videoUrl.value = blogContentElement.videoUrl;
            blogDescription.value = blogContentElement.blogDescription;
            hasLiked.value = blogContentElement.hasLiked;
          } else {
            Utils.errorSnackBar(
                AppStrings.error, whatsHotBlogContentResponse.message);
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

  Future likeOrDislikeBlogApi({required int blogId}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        String userId = await SessionManager.getUserId();
        var response = await ApiProvider.apiProvider.likeOrDislikeBlogApi(
          request: WhatsHotBlogContentLikeOrDisLikeRequest(
            blogId: blogId,
            userId: int.parse(userId),
          ),
        );
        if (response != null) {
          BaseResponse baseResponse = (response as BaseResponse);
          if (baseResponse.status) {
            hasLiked.value = !hasLiked.value;
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

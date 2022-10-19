import 'package:get/get.dart';
import 'package:retail_academy/network/modal/knowledge/like_or_dislike_content_knowledge_section_request.dart';
import '../../../common/app_strings.dart';
import '../../../common/local_storage/session_manager.dart';
import '../../../common/utils.dart';

import '../../../network/api_provider.dart';
import '../../../network/modal/base/base_response.dart';
import '../../../network/modal/knowledge/content_display_request.dart';
import '../../../network/modal/knowledge/content_display_response.dart';
import '../../../network/modal/knowledge/content_knowledge_response.dart';

class FunFactsAndMasterClassDetailController extends GetxController {
  var showLoader = false.obs;

  var isError = false.obs;
  var hasLiked = false.obs;

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

  clearValue() {
    showLoader.value = false;
    hasLiked.value = false;
    isError.value = false;
  }

  Future contentDisplayApi({required FileElement item}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        String userId = await SessionManager.getUserId();
        var response = await ApiProvider.apiProvider.contentDisplayApi(
          request: ContentDisplayRequest(
            fileId: item.fileId,
            userId: int.parse(userId),
          ),
        );
        if (response != null) {
          ContentDisplayResponse contentDisplayResponse =
              (response as ContentDisplayResponse);
          if (contentDisplayResponse.status) {
            hasLiked.value = contentDisplayResponse.likeByUser;
          } else {
            Utils.errorSnackBar(
                AppStrings.error, contentDisplayResponse.message);
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

  Future likeOrDislikeContentKnowledgeSectionApi(
      {required FileElement item}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        String userId = await SessionManager.getUserId();
        var response = await ApiProvider.apiProvider
            .likeOrDislikeContentKnowledgeSectionApi(
                request: LikeOrDislikeContentKnowledgeSectionRequest(
          fileId: item.fileId,
          userId: int.parse(userId),
          check: hasLiked.value ? 0 : 1,
        ));
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

  updateError(bool error) {
    isError.value = error;
  }
}

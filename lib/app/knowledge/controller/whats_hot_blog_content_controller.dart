import 'package:get/get.dart';

import '../../../common/app_strings.dart';
import '../../../common/local_storage/session_manager.dart';
import '../../../common/utils.dart';
import '../../../network/api_provider.dart';
import '../../../network/modal/knowledge/whats_hot_blog_content_request.dart';
import '../../../network/modal/knowledge/whats_hot_blog_content_response.dart';

class WhatsHotBlogContentController extends GetxController {
  var showLoader = true.obs;
  final RxList<BlogContentElement> dataList = RxList();
  var categoryId = -1;

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

  Future fetchWhatsHotContentApi({bool isLoader = true}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        if (isLoader) {
          showLoader.value = true;
        }
        String userId = await SessionManager.getUserId();
        WhatsHotBlogContentRequest request = WhatsHotBlogContentRequest(
            userId: int.parse(userId), categoryId: categoryId);
        var response = await ApiProvider.apiProvider
            .fetchWhatsHotBlogContent(request: request);
        if (response != null) {
          WhatsHotBlogContentResponse whatsHotBlogContentResponse =
              (response as WhatsHotBlogContentResponse);
          if (whatsHotBlogContentResponse.status) {
            dataList.clear();
            dataList.addAll(whatsHotBlogContentResponse.blogContentList ?? []);
            dataList.refresh();
          } else {
            Utils.errorSnackBar(
                AppStrings.error, whatsHotBlogContentResponse.message);
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

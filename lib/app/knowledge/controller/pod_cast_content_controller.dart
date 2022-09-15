import 'package:get/get.dart';

import '../../../common/app_strings.dart';
import '../../../common/utils.dart';
import '../../../network/api_provider.dart';
import '../../../network/modal/knowledge/whats_hot_blog_response.dart';

class PodCastContentController extends GetxController{
  var showLoader = false.obs;
  final RxList<BlogCategoryElement> dataList = RxList();


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


  Future getQuizMasterApi({bool isLoader = true}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        if (isLoader) {
          showLoader.value = true;
        }
        var response = await ApiProvider.apiProvider.fetchWhatsHotBlog();
        if (response != null) {
          WhatsHotBlogResponse whatsHotBlogResponse = (response as WhatsHotBlogResponse);
          if (whatsHotBlogResponse.status) {
            dataList.clear();
            dataList.addAll(whatsHotBlogResponse.blogCategoryList ?? []);
            dataList.refresh();
          } else {
            Utils.errorSnackBar(AppStrings.error, whatsHotBlogResponse.message);
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
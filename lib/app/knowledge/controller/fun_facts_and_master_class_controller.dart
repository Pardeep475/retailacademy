import 'package:get/get.dart';

import '../../../common/app_strings.dart';
import '../../../common/local_storage/session_manager.dart';
import '../../../common/utils.dart';
import '../../../network/api_provider.dart';
import '../../../network/modal/knowledge/content_knowledge_request.dart';
import '../../../network/modal/knowledge/content_knowledge_response.dart';

class FunFactsAndMasterClassController extends GetxController {
  var showLoader = true.obs;
  RxList<FileElement> dataList = RxList();
  RxList<FileElement> searchDataList = RxList();
  var fileId = 0;

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

  clearAllData() {
    showLoader.value = false;
    dataList = RxList();
    searchDataList = RxList();
    fileId = 0;
  }

  Future getContentKnowledgeSection({bool isLoader = true}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        if (isLoader) {
          showLoader.value = true;
        }
        String userId = await SessionManager.getUserId();
        var response = await ApiProvider.apiProvider
            .getContentKnowledgeSectionApi(
                request: ContentKnowledgeRequest(
                    folderId: fileId, userId: int.parse(userId)));
        if (response != null) {
          ContentKnowledgeResponse contentResponse =
              (response as ContentKnowledgeResponse);
          if (contentResponse.status) {
            dataList.clear();
            searchDataList.clear();
            dataList.addAll(contentResponse.files ?? []);
            searchDataList.addAll(contentResponse.files ?? []);
            searchDataList.refresh();
          } else {
            Utils.errorSnackBar(AppStrings.error, contentResponse.message);
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

  void searchFunctionality({required String value}) {
    if (value.isEmpty) {
      searchDataList.clear();
      searchDataList.addAll(dataList);
      searchDataList.refresh();
    } else {
      List<FileElement> searchList = dataList
          .where((element) =>
              element.fileName.toLowerCase().contains(value.toLowerCase()) ||
              element.description.toLowerCase().contains(value.toLowerCase()))
          .toList();
      searchDataList.clear();
      searchDataList.addAll(searchList);
      searchDataList.refresh();
    }
  }
}

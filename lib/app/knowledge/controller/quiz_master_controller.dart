import 'package:get/get.dart';

import '../../../common/app_strings.dart';
import '../../../common/local_storage/session_manager.dart';
import '../../../common/utils.dart';
import '../../../network/api_provider.dart';
import '../../../network/modal/knowledge/quiz_category_response.dart';

class QuizMasterController extends GetxController {
  var showLoader = true.obs;
  RxList<QuizCategoryElement> dataList = RxList();
  RxList<QuizCategoryElement> searchDataList = RxList();

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

  void clearAllData() {
    showLoader.value = false;
    dataList = RxList();
    searchDataList = RxList();
  }

  Future getQuizMasterApi({bool isLoader = true}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        if (isLoader) {
          showLoader.value = true;
        }
        String userId = await SessionManager.getUserId();
        var response = await ApiProvider.apiProvider.getQuizCategoryApi(
          userId: userId,
          orgId: AppStrings.orgId,
        );
        if (response != null) {
          QuizCategoryResponse quizCategoryResponse =
              (response as QuizCategoryResponse);
          if (quizCategoryResponse.status) {
            dataList.clear();
            searchDataList.clear();
            dataList.addAll(quizCategoryResponse.quizCategories ?? []);
            searchDataList.addAll(quizCategoryResponse.quizCategories ?? []);
            searchDataList.refresh();
          } else {
            Utils.errorSnackBar(AppStrings.error, quizCategoryResponse.message);
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
      List<QuizCategoryElement> searchList = dataList
          .where((element) =>
              element.categoryName
                  .toLowerCase()
                  .contains(value.toLowerCase()) ||
              element.categoryDescription
                  .toLowerCase()
                  .contains(value.toLowerCase()))
          .toList();
      searchDataList.clear();
      searchDataList.addAll(searchList);
      searchDataList.refresh();
    }
  }
}

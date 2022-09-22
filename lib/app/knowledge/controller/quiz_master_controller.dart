import 'package:get/get.dart';

import '../../../common/app_strings.dart';
import '../../../common/local_storage/session_manager.dart';
import '../../../common/utils.dart';
import '../../../network/api_provider.dart';
import '../../../network/modal/knowledge/quiz_category_response.dart';

class QuizMasterController extends GetxController {
  var showLoader = false.obs;
  final RxList<QuizCategoryElement> dataList = RxList();

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
            dataList.addAll(quizCategoryResponse.quizCategories ?? []);
            dataList.refresh();
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
}

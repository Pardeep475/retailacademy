import 'package:get/get.dart';

import '../../../common/app_strings.dart';
import '../../../common/local_storage/session_manager.dart';
import '../../../common/utils.dart';
import '../../../network/api_provider.dart';
import '../../../network/modal/knowledge/consolidated_quiz_questions_request.dart';
import '../../../network/modal/knowledge/consolidated_quiz_questions_response.dart';

class QuizMasterDetailController extends GetxController {
  var showLoader = false.obs;
  final RxList<QuizResponseElement> dataList = RxList();

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

  Future consolidatedQuizQuestionsApi({required int categoryId}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        String userId = await SessionManager.getUserId();
        var response =
            await ApiProvider.apiProvider.consolidatedQuizQuestionsApi(
          request: ConsolidatedQuizQuestions(
            categoryId: categoryId,
            userId: int.parse(userId),
          ),
        );
        if (response != null) {
          ConsolidatedQuizQuestionsResponse consolidatedQuizQuestionsResponse =
              (response as ConsolidatedQuizQuestionsResponse);
          if (consolidatedQuizQuestionsResponse.quizResponse != null) {
            dataList
                .addAll(consolidatedQuizQuestionsResponse.quizResponse ?? []);
            dataList.refresh();
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

  updateAnswers(
      {required int baseIndex, required int itemIndex, required dynamic value}) {
    if (dataList[baseIndex].answers != null) {
      if (itemIndex == -1) {
        dataList[baseIndex].setGroupValue(value);
      } else {
        dataList[baseIndex].answers![itemIndex].setSelected(value);
      }
    }
    dataList.refresh();
  }
}

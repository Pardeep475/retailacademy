import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:retail_academy/app/knowledge/repository/quiz_repository.dart';
import 'package:retail_academy/common/local_storage/hive/quiz_modal.dart';

import '../../../common/app_strings.dart';
import '../../../common/local_storage/hive/quiz_element_modal.dart';
import '../../../common/local_storage/session_manager.dart';
import '../../../common/utils.dart';
import '../../../network/api_provider.dart';
import '../../../network/modal/knowledge/consolidated_quiz_questions_request.dart';
import '../../../network/modal/knowledge/consolidated_quiz_questions_response.dart';
import 'package:collection/collection.dart';

class QuizMasterDetailController extends GetxController {
  var showLoader = false.obs;
  final RxList<QuizElementModal> dataList = RxList();

  Box<QuizModal> quizModalLocalRepository =
      Hive.box<QuizModal>(AppStrings.quizDataBaseName);

  var categoryValue = -1;
  var currentPage = 0;

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
    categoryValue = categoryId;
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        bool isResumed =
            await _checkIfQuizExistInLocalDataBase(categoryId: categoryId);
        if (!isResumed) {
          return;
        }
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
            QuizRepository _quizRepository = QuizRepository(
                categoryId: categoryId,
                quizResponse:
                    consolidatedQuizQuestionsResponse.quizResponse ?? [],
                localRepository: quizModalLocalRepository);
            _quizRepository.saveDataToLocal();
            _updateDataList(categoryId: categoryId);
            // dataList
            //     .addAll(consolidatedQuizQuestionsResponse.quizResponse ?? []);
            // dataList.refresh();
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

  Future<bool> _checkIfQuizExistInLocalDataBase(
      {required int categoryId}) async {
    if (!quizModalLocalRepository.isOpen) {
      await Hive.openBox<QuizModal>(AppStrings.quizDataBaseName);
    }
    QuizModal? modal = quizModalLocalRepository.values
        .firstWhereOrNull((element) => element.categoryId == categoryId);
    if (modal == null) {
      return true;
    }
    currentPage = modal.lastAnswered + 1;
    dataList.addAll(modal.quizResponse ?? []);
    dataList.refresh();
    return false;
  }

  _updateDataList({required int categoryId}) {
    QuizModal? modal = quizModalLocalRepository.values
        .firstWhereOrNull((element) => element.categoryId == categoryId);
    if (modal == null) {
      return;
    }
    dataList.addAll(modal.quizResponse ?? []);
    dataList.refresh();
  }

  updateAnswers(
      {required int baseIndex,
      required int itemIndex,
      required dynamic value}) {
    if (dataList[baseIndex].answers != null) {
      if (itemIndex == -1) {
        dataList[baseIndex].groupValue = value;
      } else {
        dataList[baseIndex].answers![itemIndex].isSelected = value;
      }
    }
    dataList.refresh();
  }

  // update group value
  updateValuesOnDataBase({required int index}) {
    int? modal = quizModalLocalRepository.keys.firstWhereOrNull((element) =>
        quizModalLocalRepository.getAt(element)!.categoryId == categoryValue);
    if (modal != null) {
      QuizModal _quizModal = quizModalLocalRepository.getAt(modal)!;
      _quizModal.lastAnswered = index;
      _quizModal.quizResponse![index] = dataList[index];
      quizModalLocalRepository.put(modal, _quizModal);
    }
  }

  checkHive() async {
    // Returns a List<String> of all keys
    final allCatKeys = await quizModalLocalRepository.keys;
    print(allCatKeys);

    // Returns a Map<String, Map> with all keys and entries
    final catMap = await quizModalLocalRepository.values;
    print(catMap);
  }
}

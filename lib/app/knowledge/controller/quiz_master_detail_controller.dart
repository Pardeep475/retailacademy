import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:retail_academy/app/knowledge/repository/quiz_repository.dart';
import 'package:retail_academy/common/local_storage/hive/quiz_modal.dart';

import '../../../common/app_color.dart';
import '../../../common/app_strings.dart';
import '../../../common/local_storage/hive/answer_element_modal.dart';
import '../../../common/local_storage/hive/correct_answer_element_modal.dart';
import '../../../common/local_storage/hive/quiz_element_modal.dart';
import '../../../common/local_storage/session_manager.dart';
import '../../../common/utils.dart';
import '../../../common/widget/alert_dialog_box.dart';
import '../../../common/widget/app_text.dart';
import '../../../network/api_provider.dart';
import '../../../network/modal/knowledge/consolidated_quiz_questions_request.dart';
import '../../../network/modal/knowledge/consolidated_quiz_questions_response.dart';
import 'package:collection/collection.dart';

class QuizMasterDetailController extends GetxController {
  var showLoader = false.obs;
  RxList<QuizElementModal> dataList = RxList();

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

  void clearAllData() {
    showLoader.value = false;
    dataList = RxList();
    categoryValue = -1;
    currentPage = 0;
    quizModalLocalRepository = Hive.box<QuizModal>(AppStrings.quizDataBaseName);
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
                userId: int.parse(userId),
                quizResponse:
                    consolidatedQuizQuestionsResponse.quizResponse ?? [],
                localRepository: quizModalLocalRepository);
            _quizRepository.saveDataToLocal();
            _updateDataList(categoryId: categoryId, userId: int.parse(userId));
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
    dataList.clear();
    // currentPage = modal.lastAnswered + 1;
    for (int i = 0; i < modal.quizResponse!.length; i++) {
      var element = modal.quizResponse![i];
      if (element.hasUserAttemptedQuestion) {
        currentPage = i + 1;
      }
      if (i > modal.lastAnswered || modal.lastAnswered == -1) {
        debugPrint(
            'Checking Position:---   ${modal.lastAnswered > i}  i  ==> $i  lastAnswered:==>  ${modal.lastAnswered}');
        element.groupValue = '';
        for (var elementElement in element.answers!) {
          elementElement.isSelected = false;
        }
      }
    }

    dataList.addAll(modal.quizResponse ?? []);
    dataList.refresh();
    return false;
  }

  _updateDataList({required int categoryId, required int userId}) {
    QuizModal? modal = quizModalLocalRepository.values.firstWhereOrNull(
        (element) =>
            element.categoryId == categoryId && element.userId == userId);
    if (modal == null) {
      return;
    }
    for (int i = 0; i < modal.quizResponse!.length; i++) {
      var element = modal.quizResponse![i];
      if (element.hasUserAttemptedQuestion) {
        currentPage = i + 1;
      }
    }
    dataList.clear();
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
      dataList[baseIndex].hasUserAttemptedQuestion = true;
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
      _quizModal.quizResponse![index].hasUserAttemptedQuestion = true;
      quizModalLocalRepository.put(modal, _quizModal);
    }
  }

  // checkHive() async {
  //   // Returns a List<String> of all keys
  //   final allCatKeys = await quizModalLocalRepository.keys;
  //   print(allCatKeys);
  //
  //   // Returns a Map<String, Map> with all keys and entries
  //   final catMap = await quizModalLocalRepository.values;
  //   print(catMap);
  // }

  String validateQuiz() {
    if (dataList[currentPage].questionType ==
        'Multiple Choice - Single Answer') {
      if (dataList[currentPage].groupValue.isNotEmpty) {
        return _checkIfSingleAnswerIsCorrect(
            value: int.parse(dataList[currentPage].groupValue));
      } else {
        return AppStrings.pleaseSelectYourAnswer;
      }
    } else {
      AnswerElementModal? answerElementModal = dataList[currentPage]
          .answers
          ?.firstWhereOrNull((element) => element.isSelected);
      if (answerElementModal == null) {
        return AppStrings.pleaseSelectYourAnswer;
      } else {
        return _checkIfMultipleAnswerIsCorrect(
            answers: dataList[currentPage].answers ?? [],
            correctAnswersList: dataList[currentPage].correctAnswersList ?? []);
      }
    }
  }

  String _checkIfSingleAnswerIsCorrect({required int value}) {
    CorrectAnswerElementModal? response = dataList[currentPage]
        .correctAnswersList
        ?.firstWhereOrNull((element) => element.correctAnswerNumber == value);

    if (response == null) {
      String correctAns =
          dataList[currentPage].correctAnswersList?.first.correctAnswer ?? '';
      return '${AppStrings.incorrectAnswer} $correctAns';
    } else {
      return AppStrings.yourAnswerIsCorrect;
    }
  }

  String _checkIfMultipleAnswerIsCorrect(
      {required List<AnswerElementModal> answers,
      required List<CorrectAnswerElementModal> correctAnswersList}) {
    int length = 0;
    for (var element in correctAnswersList) {
      AnswerElementModal? value = answers.firstWhereOrNull((ans) =>
          ans.answerNo == element.correctAnswerNumber && ans.isSelected);
      if (value != null) {
        ++length;
      }
    }
    if (length == correctAnswersList.length) {
      return AppStrings.yourAnswerIsCorrect;
    } else {
      String correctAns = '';
      for (int i = 0; i < correctAnswersList.length; i++) {
        var element = correctAnswersList[i];
        if (correctAns.isNotEmpty) {
          correctAns = '$correctAns\n${i + 1}. ${element.correctAnswer}';
        } else {
          correctAns = '${i + 1}. ${element.correctAnswer}';
        }
      }
      return '${AppStrings.incorrectAnswer} $correctAns';
    }
  }

  Future consolidatedQuizSubmitApi(
      {required BuildContext context, required int index}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        String userId = await SessionManager.getUserId();
        var response = await ApiProvider.apiProvider.consolidatedQuizSubmitApi(
          request: ConsolidatedQuizQuestions(
              categoryId: categoryValue,
              userId: int.parse(userId),
              isSubmitAnswers: true,
              submitAnswers: _singletSubmitAns(index: index)),
        );
        if (response != null) {
          int statusCode = (response.statusCode);
          if (statusCode == 200) {
            //quizscore
            var value = response.data['quizResponse'].last['quizscore'] ?? "0%";
            if (index == dataList.length - 1) {
              _commonDialog(
                  title: AppStrings.finalScore +
                      /*_checkScore()*/ value +
                      AppStrings.thanksForAttemptThisQuiz,
                  context: context,
                  onPressed: () async {
                    // await _deleteDataFromLocal();
                    Get.back(result: "DELETE");
                    Get.back(result: "DELETE");
                  },
                  barrierDismissible: false);
            }
          }
        }
        return null;
      } catch (e) {
        Utils.errorSnackBar(AppStrings.error, e.toString());
      } finally {
        showLoader.value = false;
      }
    }
    return null;
  }

  List<SubmitAnswerElement> _singletSubmitAns({required int index}) {
    List<SubmitAnswerElement> _list = [];

    var element = dataList[index];

    if (element.questionType == 'Multiple Choice - Single Answer') {
      _list.add(SubmitAnswerElement(
          questionId: element.questionId.toString(),
          answerSubmitted: element.groupValue,
          attemptedQuestions: element.questionId.toString()));
    } else {
      _list.add(SubmitAnswerElement(
        questionId: element.questionId.toString(),
        answerSubmitted:
            _makeCommaSeparatedMultipleQuestion(list: element.answers ?? []),
        attemptedQuestions: element.questionId.toString(),
      ));
    }

    /*for (var element in dataList) {
      if (element.questionType == 'Multiple Choice - Single Answer') {
        _list.add(SubmitAnswerElement(
            questionId: element.questionId.toString(),
            answerSubmitted: element.groupValue,
            attemptedQuestions: element.questionId.toString()));
      } else {
        _list.add(SubmitAnswerElement(
          questionId: element.questionId.toString(),
          answerSubmitted:
          _makeCommaSeparatedMultipleQuestion(list: element.answers ?? []),
          attemptedQuestions: element.questionId.toString(),
        ));
      }
    }*/
    return _list;
  }

  List<SubmitAnswerElement> _listSubmitAns() {
    List<SubmitAnswerElement> _list = [];
    for (var element in dataList) {
      if (element.questionType == 'Multiple Choice - Single Answer') {
        _list.add(SubmitAnswerElement(
            questionId: element.questionId.toString(),
            answerSubmitted: element.groupValue,
            attemptedQuestions: element.questionId.toString()));
      } else {
        _list.add(SubmitAnswerElement(
          questionId: element.questionId.toString(),
          answerSubmitted:
              _makeCommaSeparatedMultipleQuestion(list: element.answers ?? []),
          attemptedQuestions: element.questionId.toString(),
        ));
      }
    }
    return _list;
  }

  String _makeCommaSeparatedMultipleQuestion(
      {required List<AnswerElementModal> list}) {
    String value = '';
    for (int i = 0; i < list.length - 1; i++) {
      AnswerElementModal element = list[i];
      if (element.isSelected) {
        if (i == 0) {
          value = '${element.answerNo}';
        } else {
          value = '$value,${element.answerNo}';
        }
      }
    }
    return value;
  }

  _commonDialog(
      {required String title,
      required BuildContext context,
      VoidCallback? onPressed,
      bool barrierDismissible = true}) {
    AlertDialogBox(
      showCrossIcon: true,
      context: context,
      barrierDismissible: barrierDismissible,
      padding: EdgeInsets.zero,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 15.h,
              ),
              AppText(
                text: AppStrings.alert,
                textSize: 22.sp,
                color: AppColor.black,
                maxLines: 2,
                lineHeight: 1.3,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 15.h,
              ),
              Divider(
                height: 1.sp,
                color: AppColor.grey,
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.h),
                child: AppText(
                  text: title,
                  textSize: 18.sp,
                  color: AppColor.black,
                  maxLines: 10,
                  textAlign: TextAlign.center,
                  lineHeight: 1.3,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Divider(
                height: 1.sp,
                color: AppColor.grey,
              ),
              Row(
                children: [
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onPressed ?? () => Get.back(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          child: AppText(
                            text: AppStrings.ok,
                            textSize: 18.sp,
                            color: Colors.lightBlue,
                            maxLines: 2,
                            lineHeight: 1.3,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ).show();
  }

  String _checkScore() {
    double passingPercentageValue =
        100 * checkCorrectAnswers() / dataList.length;
    return '${passingPercentageValue.toStringAsFixed(2)}%';
  }

  int checkCorrectAnswers() {
    int score = 0;
    for (var element in dataList) {
      if (element.questionType == 'Multiple Choice - Single Answer') {
        CorrectAnswerElementModal correctAnswerElementModal =
            element.correctAnswersList!.first;
        if (int.parse(element.groupValue) ==
            correctAnswerElementModal.correctAnswerNumber) {
          ++score;
        }
      } else {
        if (_checkMultipleAnswerIsCorrect(element: element)) {
          ++score;
        }
      }
    }
    return score;
  }

  bool _checkMultipleAnswerIsCorrect({required QuizElementModal element}) {
    int correctAnswerLength = element.correctAnswersList!.length;
    int userAnsLength = 0;
    for (var correctElement in element.correctAnswersList!) {
      AnswerElementModal? value = element.answers!.firstWhereOrNull((ans) =>
          ans.answerNo == correctElement.correctAnswerNumber && ans.isSelected);
      if (value != null) {
        ++userAnsLength;
      }
    }

    if (correctAnswerLength == userAnsLength) {
      return true;
    }
    return false;
  }

  _deleteDataFromLocal() async {
    dynamic key;
    int modal = quizModalLocalRepository.keys.firstWhereOrNull((element) {
      if (quizModalLocalRepository.getAt(element)?.categoryId ==
          categoryValue) {
        key = element;
        return true;
      } else {
        return false;
      }
    });
    if (key != null) {
      await quizModalLocalRepository.delete(key);
    }
  }
}

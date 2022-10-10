import 'package:hive/hive.dart';

import '../../../common/local_storage/hive/answer_element_modal.dart';
import '../../../common/local_storage/hive/correct_answer_element_modal.dart';
import '../../../common/local_storage/hive/quiz_element_modal.dart';
import '../../../common/local_storage/hive/quiz_modal.dart';
import '../../../network/modal/knowledge/consolidated_quiz_questions_response.dart';

class QuizRepository {
  final int categoryId;
  final List<QuizResponseElement> quizResponse;
  final Box<QuizModal> localRepository;

  QuizRepository(
      {required this.categoryId,
      required this.quizResponse,
      required this.localRepository});

  saveDataToLocal() {
    localRepository.add(QuizModal(
        categoryId: categoryId,
        lastAnswered: -1,
        quizResponse: _convertToQuizElementModal()));
  }

  List<QuizElementModal> _convertToQuizElementModal() {
    List<QuizElementModal> _quizElementModalList = [];
    for (var element in quizResponse) {
      QuizElementModal _quizElementModal = QuizElementModal();
      _quizElementModal.questionId = element.questionId;
      _quizElementModal.question = element.question;
      _quizElementModal.questionType = element.questionType;
      _quizElementModal.noOfQuestion = element.noOfQuestion;
      _quizElementModal.status = element.status;
      _quizElementModal.message = element.message;
      _quizElementModal.feedback = element.feedback;
      _quizElementModal.mediaUrl = element.mediaUrl;
      _quizElementModal.quizEnd = element.quizEnd;
      _quizElementModal.quizScore = element.quizScore;
      _quizElementModal.answers = convertAnswerElement(element.answers ?? []);
      _quizElementModal.correctAnswersList =
          convertCorrectAnswerElement(element.correctAnswersList ?? []);
      _quizElementModalList.add(_quizElementModal);
    }
    return _quizElementModalList;
  }

  List<AnswerElementModal> convertAnswerElement(List<AnswerElement> answers) {
    List<AnswerElementModal> _answerElementModalList = [];
    for (var element in answers) {
      AnswerElementModal _answerElementModal = AnswerElementModal();
      _answerElementModal.answer = element.answer;
      _answerElementModal.answerNo = element.answerNo;
      _answerElementModalList.add(_answerElementModal);
    }
    return _answerElementModalList;
  }

  List<CorrectAnswerElementModal> convertCorrectAnswerElement(
      List<CorrectAnswersElement> correctAnswersList) {
    List<CorrectAnswerElementModal> _correctAnswerElementModalList = [];
    for (var element in correctAnswersList) {
      CorrectAnswerElementModal _correctAnswerElementModal =
          CorrectAnswerElementModal();
      _correctAnswerElementModal.correctAnswer = element.correctAnswer;
      _correctAnswerElementModal.correctAnswerNumber =
          element.correctAnswerNumber;
      _correctAnswerElementModalList.add(_correctAnswerElementModal);
    }
    return _correctAnswerElementModalList;
  }
}

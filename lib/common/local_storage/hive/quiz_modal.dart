import 'package:hive/hive.dart';
import 'package:retail_academy/common/local_storage/hive/quiz_element_modal.dart';

part 'quiz_modal.g.dart';

@HiveType(typeId: 0)
class QuizModal {
  @HiveField(0, defaultValue: 0)
  int categoryId;
  @HiveField(1)
  List<QuizElementModal>? quizResponse;
  @HiveField(2, defaultValue: -1)
  int lastAnswered;

  QuizModal(
      {required this.categoryId,
      required this.quizResponse,
      required this.lastAnswered});
}

/*class QuizElementModal {
  int questionId;
  String question;
  String questionType;
  int noOfQuestion;
  bool status;
  String message;
  String feedback;
  String mediaUrl;
  bool quizEnd;
  dynamic quizScore;
  List<AnswerElementModal>? answers;
  List<CorrectAnswerElementModal>? correctAnswersList;

  QuizElementModal(
      {this.questionId = -1,
      this.question = '',
      this.questionType = '',
      this.noOfQuestion = -1,
      this.status = false,
      this.message = '',
      this.feedback = '',
      this.mediaUrl = '',
      this.quizEnd = false,
      this.quizScore,
      this.answers,
      this.correctAnswersList});
}

class CorrectAnswerElementModal {
  int correctAnswerNumber;
  String correctAnswer;

  CorrectAnswerElementModal(
      {this.correctAnswerNumber = -1, this.correctAnswer = ''});
}

class AnswerElementModal {
  int answerNo;
  String answer;
  bool isSelected;

  AnswerElementModal(
      {this.answerNo = -1, this.answer = '', this.isSelected = false});
}*/

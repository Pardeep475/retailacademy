import 'package:hive/hive.dart';

import 'answer_element_modal.dart';
import 'correct_answer_element_modal.dart';

part 'quiz_element_modal.g.dart';

@HiveType(typeId: 1)
class QuizElementModal {
  @HiveField(0, defaultValue: -1)
  int questionId;
  @HiveField(1, defaultValue: '')
  String question;
  @HiveField(2, defaultValue: '')
  String questionType;
  @HiveField(3, defaultValue: -1)
  int noOfQuestion;
  @HiveField(4, defaultValue: false)
  bool status;
  @HiveField(5, defaultValue: '')
  String message;
  @HiveField(6, defaultValue: '')
  String feedback;
  @HiveField(7, defaultValue: '')
  String mediaUrl;
  @HiveField(8, defaultValue: false)
  bool quizEnd;
  @HiveField(9)
  dynamic quizScore;
  @HiveField(10)
  List<AnswerElementModal>? answers;
  @HiveField(11)
  List<CorrectAnswerElementModal>? correctAnswersList;
  @HiveField(12)
  String groupValue;

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
      this.groupValue = '',
      this.answers,
      this.correctAnswersList});
}

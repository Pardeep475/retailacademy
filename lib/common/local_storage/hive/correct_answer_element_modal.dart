import 'package:hive/hive.dart';

part 'correct_answer_element_modal.g.dart';

@HiveType(typeId: 3)
class CorrectAnswerElementModal {
  @HiveField(0, defaultValue: 0)
  int correctAnswerNumber;
  @HiveField(1, defaultValue: '')
  String correctAnswer;

  CorrectAnswerElementModal(
      {this.correctAnswerNumber = -1, this.correctAnswer = ''});
}

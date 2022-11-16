import 'package:hive/hive.dart';

part 'answer_element_modal.g.dart';

@HiveType(typeId: 2)
class AnswerElementModal {
  @HiveField(0, defaultValue: -1)
  int answerNo;
  @HiveField(1, defaultValue: '')
  String answer;
  @HiveField(2, defaultValue: false)
  bool isSelected;

  AnswerElementModal(
      {this.answerNo = -1, this.answer = '', this.isSelected = false});
}

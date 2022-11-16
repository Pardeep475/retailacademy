// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_element_modal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuizElementModalAdapter extends TypeAdapter<QuizElementModal> {
  @override
  final int typeId = 1;

  @override
  QuizElementModal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuizElementModal(
      questionId: fields[0] == null ? -1 : fields[0] as int,
      question: fields[1] == null ? '' : fields[1] as String,
      questionType: fields[2] == null ? '' : fields[2] as String,
      noOfQuestion: fields[3] == null ? -1 : fields[3] as int,
      status: fields[4] == null ? false : fields[4] as bool,
      message: fields[5] == null ? '' : fields[5] as String,
      feedback: fields[6] == null ? '' : fields[6] as String,
      mediaUrl: fields[7] == null ? '' : fields[7] as String,
      quizEnd: fields[8] == null ? false : fields[8] as bool,
      quizScore: fields[9] as dynamic,
      groupValue: fields[12] as String,
      answers: (fields[10] as List?)?.cast<AnswerElementModal>(),
      correctAnswersList:
          (fields[11] as List?)?.cast<CorrectAnswerElementModal>(),
    );
  }

  @override
  void write(BinaryWriter writer, QuizElementModal obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.questionId)
      ..writeByte(1)
      ..write(obj.question)
      ..writeByte(2)
      ..write(obj.questionType)
      ..writeByte(3)
      ..write(obj.noOfQuestion)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.message)
      ..writeByte(6)
      ..write(obj.feedback)
      ..writeByte(7)
      ..write(obj.mediaUrl)
      ..writeByte(8)
      ..write(obj.quizEnd)
      ..writeByte(9)
      ..write(obj.quizScore)
      ..writeByte(10)
      ..write(obj.answers)
      ..writeByte(11)
      ..write(obj.correctAnswersList)
      ..writeByte(12)
      ..write(obj.groupValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizElementModalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'correct_answer_element_modal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CorrectAnswerElementModalAdapter
    extends TypeAdapter<CorrectAnswerElementModal> {
  @override
  final int typeId = 3;

  @override
  CorrectAnswerElementModal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CorrectAnswerElementModal(
      correctAnswerNumber: fields[0] == null ? 0 : fields[0] as int,
      correctAnswer: fields[1] == null ? '' : fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CorrectAnswerElementModal obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.correctAnswerNumber)
      ..writeByte(1)
      ..write(obj.correctAnswer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CorrectAnswerElementModalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_element_modal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnswerElementModalAdapter extends TypeAdapter<AnswerElementModal> {
  @override
  final int typeId = 2;

  @override
  AnswerElementModal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnswerElementModal(
      answerNo: fields[0] == null ? -1 : fields[0] as int,
      answer: fields[1] == null ? '' : fields[1] as String,
      isSelected: fields[2] == null ? false : fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AnswerElementModal obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.answerNo)
      ..writeByte(1)
      ..write(obj.answer)
      ..writeByte(2)
      ..write(obj.isSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnswerElementModalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

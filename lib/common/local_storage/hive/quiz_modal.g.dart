// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_modal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuizModalAdapter extends TypeAdapter<QuizModal> {
  @override
  final int typeId = 0;

  @override
  QuizModal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuizModal(
      categoryId: fields[0] == null ? 0 : fields[0] as int,
      quizResponse: (fields[1] as List?)?.cast<QuizElementModal>(),
      lastAnswered: fields[2] == null ? -1 : fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, QuizModal obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.categoryId)
      ..writeByte(1)
      ..write(obj.quizResponse)
      ..writeByte(2)
      ..write(obj.lastAnswered);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizModalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

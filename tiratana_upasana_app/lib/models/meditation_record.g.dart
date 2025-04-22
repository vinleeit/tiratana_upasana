// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meditation_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MeditationRecordAdapter extends TypeAdapter<MeditationRecord> {
  @override
  final int typeId = 10;

  @override
  MeditationRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MeditationRecord(
      startDatetime: fields[0] as DateTime,
      duration: fields[1] as Duration,
      note: fields[2] == null ? '' : fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MeditationRecord obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.startDatetime)
      ..writeByte(1)
      ..write(obj.duration)
      ..writeByte(2)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeditationRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

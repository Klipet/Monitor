// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_sounds_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MySoundModelAdapter extends TypeAdapter<MySoundModel> {
  @override
  final int typeId = 0;

  @override
  MySoundModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MySoundModel(
      soundName: fields[0] as Sounds,
    );
  }

  @override
  void write(BinaryWriter writer, MySoundModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.soundName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MySoundModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

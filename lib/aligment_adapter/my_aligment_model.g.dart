// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_aligment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyAligmentModelAdapter extends TypeAdapter<MyAligmentModel> {
  @override
  final int typeId = 2;

  @override
  MyAligmentModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MyAligmentModel.topRight;
      case 1:
        return MyAligmentModel.topLeft;
      case 2:
        return MyAligmentModel.bottomRight;
      case 3:
        return MyAligmentModel.bottomLeft;
      default:
        return MyAligmentModel.topRight;
    }
  }

  @override
  void write(BinaryWriter writer, MyAligmentModel obj) {
    switch (obj) {
      case MyAligmentModel.topRight:
        writer.writeByte(0);
        break;
      case MyAligmentModel.topLeft:
        writer.writeByte(1);
        break;
      case MyAligmentModel.bottomRight:
        writer.writeByte(2);
        break;
      case MyAligmentModel.bottomLeft:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyAligmentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

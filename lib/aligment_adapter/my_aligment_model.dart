import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

part 'my_aligment_model.g.dart';

@HiveType(typeId: 2)
enum MyAligmentModel {
  @HiveField(0) topRight,
  @HiveField(1) topLeft,
  @HiveField(2) bottomRight,
  @HiveField(3) bottomLeft,
}

class AlignmentAdapter extends TypeAdapter<Alignment> {
  @override
  final int typeId = 0;

  @override
  Alignment read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Alignment.topRight;
      case 1:
        return Alignment.topLeft;
      case 2:
        return Alignment.bottomRight;
      case 3:
        return Alignment.bottomLeft;
      default:
        return Alignment.bottomRight;
    }
  }

  @override
  void write(BinaryWriter writer, Alignment obj) {
    if (obj == Alignment.topRight) {
      writer.writeByte(0);
    } else if (obj == Alignment.topLeft) {
      writer.writeByte(1);
    } else if (obj == Alignment.bottomRight) {
      writer.writeByte(2);
    } else if (obj == Alignment.bottomLeft) {
      writer.writeByte(3);
    }
  }
}
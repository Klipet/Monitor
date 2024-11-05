import 'package:hive/hive.dart';


@HiveType(typeId: 0)
class MySoundModel {
  @HiveField(0)
  final String soundName;
  @HiveField(1)
  final String soundFilePath;

  MySoundModel({required this.soundName, required this.soundFilePath});
}
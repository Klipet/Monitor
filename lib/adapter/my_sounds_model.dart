import 'package:hive/hive.dart';
import 'package:sound_library/sound_library.dart';

part 'my_sounds_model.g.dart';

@HiveType(typeId: 1)
class MySoundModel {
  @HiveField(0)
  final Sounds soundName;

  MySoundModel({required this.soundName});
}
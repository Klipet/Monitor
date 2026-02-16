import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
class ReapreApp {

  Future<SharedPreferences> appRepar() async {
    try {
      return await SharedPreferences.getInstance();
    } catch (e) {
      print("Ошибка чтения SharedPreferences: $e");

      // Удаляем файл вручную
      final directory = await path_provider.getApplicationSupportDirectory();
      final prefsFile = File('${directory.path}/shared_preferences.json');
      if (await prefsFile.exists()) {
        await prefsFile.delete();
        print("Поврежденный файл удален");
      }

      // Повторная попытка
      return await SharedPreferences.getInstance();
    }
  }
}

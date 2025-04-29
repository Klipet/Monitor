
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class SettingApp{
  static Box? _box;
  static List<String> keepKeys = const ['uri', 'licenseID'];

  static Future<void> init() async{
    try {
      _box = await Hive.openBox('setting_app');
      final keysToDelete = _box!.keys.where((k) => !keepKeys.contains(k)).toList();
      for (var key in keysToDelete) {
        await _box!.delete(key);
        print('🗑️ Удалён ключ: $key');
      }
      print('✅ Очистка завершена.${keysToDelete.length}');

    } catch (e) {
      print('❗ Ошибка открытия Hive: $e');
      _box = await Hive.openBox('settings');
    }
  }
  static Future<void> setLicenseID(String licenseID) async {
    await _box?.put('licenseID', licenseID);
  }

  static String? getLicenseID() {
    return _box?.get('licenseID');
  }

  static Future<void> setURI(String uri) async {
    await _box?.put('uri', uri);
    print('Save hive $uri');
  }

  static String? getURI() {
    return _box?.get('uri');
  }

  static Future<void>? closedBox() {
    return _box?.close();
  }
}
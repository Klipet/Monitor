

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class ScreenSettingsHeader extends ChangeNotifier {
  Color _backgroundColor = Colors.white;
  String _textTitle = 'Monitor p/u Cumparator';


  Color get backgroundColor => _backgroundColor;
  String get textTitle => _textTitle;

  ScreenSettingsHeader() {
    _loadSettings();
  }
  void _loadSettings() async {
    var box = Hive.box('settings');
    _backgroundColor = Color(box.get('backgroundColor', defaultValue: Colors.white.value));
    _textTitle = box.get('textTitle', defaultValue: 'Monitor p/u Cumparator');

    notifyListeners();
  }
  void _saveSettings() {
    var box = Hive.box('settings');
    box.put('backgroundColor', _backgroundColor.value);
    box.put('textTitle', _textTitle);
  }


  void updateBackgroundColor(Color color) {
    _backgroundColor = color;
    _saveSettings();
    notifyListeners();
  }
  void updateTitle(String text) {
    _textTitle = text;
    _saveSettings();
    notifyListeners();
  }

}
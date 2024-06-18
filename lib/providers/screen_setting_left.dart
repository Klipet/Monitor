
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class ScreenSettingsLeft extends ChangeNotifier {
  String _textLeftTitle = 'Left title';
  Color _leftColumnColor = Colors.white;
  Color _leftColorText = Colors.black;
  double _leftSizeText = 15.0;



  Color get leftColumnColor => _leftColumnColor;
  Color get leftColorText => _leftColorText;
  String get textLeftTitle => _textLeftTitle;
  double get leftSizeText => _leftSizeText;

  ScreenSettingsLeft() {
    _loadSettings();
  }
  void _loadSettings() async {
    var box = Hive.box('settings');
    _leftColorText = Color(box.get('backgroundBoxColor', defaultValue: Colors.black.value));
    _leftColumnColor = Color(box.get('backgroundBoxColor', defaultValue: Colors.white.value));
    _leftSizeText = box.get('leftSizeText', defaultValue: 15.0);
    _textLeftTitle = box.get('textLeftTitle', defaultValue: 'Left title');

    notifyListeners();
  }
  void _saveSettings() {
    var box = Hive.box('settings');
    box.put('leftColorText', _leftColorText.value);
    box.put('leftColumnColor', _leftColumnColor.value);
    box.put('leftSizeText', _leftSizeText);
    box.put('textLeftTitle', _textLeftTitle);
  }



  void updateLeftSizeText(double size) {
    _leftSizeText = size;
    _saveSettings();
    notifyListeners();
  }
  void updateLeftColumnColor(Color color) {
    _leftColumnColor = color;
    _saveSettings();
    notifyListeners();
  }
  void updateLeftColorText(Color color) {
    _leftColorText = color;
    _saveSettings();
    notifyListeners();
  }
  void updateLeftTitle(String text) {
    _textLeftTitle = text;
    _saveSettings();
    notifyListeners();
  }

}

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class ScreenSettingsRight extends ChangeNotifier {

  String _textRightTitle = 'Right Title';
  Color _rightColumnColor = Colors.white;
  Color _rightColorText = Colors.black;
  double _rightSizeText = 15.0;



  Color get rightColumnColor => _rightColumnColor;
  Color get rightColorText => _rightColorText;
  String get textRightTitle => _textRightTitle;
  double get rightSizeText => _rightSizeText;


  ScreenSettingsRight() {
    _loadSettings();
  }
  void _loadSettings() async {
    var box = Hive.box('settings');
    _rightColorText = Color(box.get('rightColorText', defaultValue: Colors.black.value));
    _rightColumnColor = Color(box.get('rightColumnColor', defaultValue: Colors.white.value));
    _rightSizeText = box.get('rightSizeText', defaultValue: 15.0);
    _textRightTitle = box.get('textRightTitle', defaultValue: 'Right Title');

    notifyListeners();
  }
  void _saveSettings() {
    var box = Hive.box('settings');
    box.put('rightColorText', _rightColorText.value);
    box.put('rightColumnColor', _rightColumnColor.value);
    box.put('rightSizeText', _rightSizeText);
    box.put('textRightTitle', _textRightTitle);
  }

  void updateRightSizeText(double size) {
    _rightSizeText = size;
    _saveSettings();
    notifyListeners();
  }

  void updateRightColumnColor(Color color) {
    _rightColumnColor = color;
    _saveSettings();
    notifyListeners();
  }
  void updateRightColorText(Color color) {
    _rightColorText = color;
    _saveSettings();
    notifyListeners();
  }

  void updateRightTitle(String text) {
    _textRightTitle = text;
    _saveSettings();
    notifyListeners();
  }

}
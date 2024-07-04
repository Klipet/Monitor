
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class ScreenSettingsLeft extends ChangeNotifier {
  String _textLeftTitle = 'Left title';
  Color _leftColumnColor = Colors.white;
  Color _leftColorText = Colors.black;
  Color _leftColorBorder = Colors.black;
  double _leftSizeText = 15.0;
  double _leftSizeBorder = 0.0;
  String _styleColumnLeft = 'Roboto';



  Color get leftColumnColor => _leftColumnColor;
  Color get leftColorText => _leftColorText;
  Color get leftColorBorder => _leftColorBorder;
  String get textLeftTitle => _textLeftTitle;
  double get leftSizeText => _leftSizeText;
  double get leftSizeBorder => _leftSizeBorder;
  String get styleColumnLeft => _styleColumnLeft;

  ScreenSettingsLeft() {
    _loadSettings();
  }
  void _loadSettings() async {
    var box = Hive.box('settings');
    _leftColorText = Color(box.get('leftColorText', defaultValue: Colors.black.value));
    _leftColumnColor = Color(box.get('leftColumnColor', defaultValue: Colors.white.value));
    _leftColorBorder = Color(box.get('leftColorBorder', defaultValue: Colors.black.value));
    _leftSizeText = box.get('leftSizeText', defaultValue: 15.0);
    _leftSizeBorder = box.get('leftSizeBorder', defaultValue: 0.0);
    _textLeftTitle = box.get('textLeftTitle', defaultValue: 'Left title');
    _styleColumnLeft = box.get('styleColumnLeft', defaultValue: 'Roboto');

    notifyListeners();
  }
  void _saveSettings() {
    var box = Hive.box('settings');
    box.put('leftColorText', _leftColorText.value);
    box.put('leftColumnColor', _leftColumnColor.value);
    box.put('leftSizeText', _leftSizeText);
    box.put('textLeftTitle', _textLeftTitle);
    box.put('leftColorBorder', _leftColorBorder);
    box.put('leftSizeBorder', _leftSizeBorder);
    box.put('styleColumnLeft', _styleColumnLeft);
  }



  void updateLeftSizeText(double size) {
    _leftSizeText = size;
    _saveSettings();
    notifyListeners();
  }
  void updateLeftSizeBorder(double size) {
    _leftSizeBorder = size;
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
  void updateLeftColorBorder(Color color) {
    _leftColorBorder = color;
    _saveSettings();
    notifyListeners();
  }
  void updateLeftTitle(String text) {
    _textLeftTitle = text;
    _saveSettings();
    notifyListeners();
  }  void updateStyleColumnLeft(String text) {
    _styleColumnLeft = text;
    _saveSettings();
    notifyListeners();
  }

}
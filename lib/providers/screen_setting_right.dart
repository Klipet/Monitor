
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class ScreenSettingsRight extends ChangeNotifier {

  String _textRightTitle = 'Right Title';
  Color _rightColumnColor = Colors.white;
  Color _rightColorText = Colors.black;
  Color _rightColorBorder = Colors.black;
  double _rightSizeText = 15.0;
  double _rightSizeBorder = 0.0;
  String _styleColumnRight = 'Roboto';
  late bool _borderRight;



  Color get rightColumnColor => _rightColumnColor;
  Color get rightColorText => _rightColorText;
  Color get rightColorBorder => _rightColorBorder;
  String get textRightTitle => _textRightTitle;
  double get rightSizeText => _rightSizeText;
  double get rightSizeBorder => _rightSizeBorder;
  String get styleColumnRight => _styleColumnRight;
  bool get borderRight => _borderRight;


  ScreenSettingsRight() {
    _loadSettings();
  }
  void _loadSettings() async {
    var box = Hive.box('settings');
    _rightColorText = Color(box.get('rightColorText', defaultValue: Colors.black.value));
    _rightColumnColor = Color(box.get('rightColumnColor', defaultValue: Colors.white.value));
    _rightColorBorder = Color(box.get('rightColorBorder', defaultValue: Colors.black.value));
    _rightSizeText = box.get('rightSizeText', defaultValue: 15.0);
    _rightSizeBorder = box.get('rightSizeBorder', defaultValue: 0.0);
    _textRightTitle = box.get('textRightTitle', defaultValue: 'Right Title');
    _styleColumnRight = box.get('styleColumnRight', defaultValue: 'Roboto');
    _borderRight = box.get('borderRight', defaultValue: false);

    notifyListeners();
  }
  void _saveSettings() {
    var box = Hive.box('settings');
    box.put('rightColorText', _rightColorText.value);
    box.put('rightColumnColor', _rightColumnColor.value);
    box.put('rightColorBorder', _rightColorBorder.value);
    box.put('rightSizeText', _rightSizeText);
    box.put('textRightTitle', _textRightTitle);
    box.put('rightSizeBorder', _rightSizeBorder);
    box.put('styleColumnRight', _styleColumnRight);
    box.put('borderRight', _borderRight);
  }

  void updateBorderRight(bool size) {
    _borderRight = size;
    _saveSettings();
    notifyListeners();
  }
  void updateRightSizeText(double size) {
    _rightSizeText = size;
    _saveSettings();
    notifyListeners();
  }
  void updateRightSizeBorder(double size) {
    _rightSizeBorder = size;
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
  void updateRightColorBorder(Color color) {
    _rightColorBorder = color;
    _saveSettings();
    notifyListeners();
  }

  void updateRightTitle(String text) {
    _textRightTitle = text;
    _saveSettings();
    notifyListeners();
  }
  void updateStyleColumnRight(String text) {
    _styleColumnRight = text;
    _saveSettings();
    notifyListeners();
  }

}
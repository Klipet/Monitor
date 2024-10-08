
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:monitor_for_sales/providers/screen_setting_left.dart';

class ScreenSettingsRight extends ChangeNotifier {

  String _textRightTitle = 'Right Title';
  Color _rightColumnColor = Colors.white;
  Color _rightColorText = Colors.black;
  Color _rightColorBorder = Colors.black;
  double _rightSizeText = 15.0;
  double _rightSizeBorder = 0.0;
  String _styleColumnRight = 'Roboto';
  late bool _borderRight;
  late bool _borderIsActiveBottomRight;
  late bool _borderIsActiveTopLeftRight;
  late bool _borderIsActiveLeftRight;
  late bool _borderIsActiveRightRight;



  Color get rightColumnColor => _rightColumnColor;
  Color get rightColorText => _rightColorText;
  Color get rightColorBorder => _rightColorBorder;
  String get textRightTitle => _textRightTitle;
  double get rightSizeText => _rightSizeText;
  double get rightSizeBorder => _rightSizeBorder;
  String get styleColumnRight => _styleColumnRight;
  bool get borderRight => _borderRight;
  bool get borderIsActiveBottomRight => _borderIsActiveBottomRight;
  bool get borderIsActiveTopRight => _borderIsActiveTopLeftRight;
  bool get borderIsActiveLeftRight => _borderIsActiveLeftRight;
  bool get borderIsActiveRightRight => _borderIsActiveRightRight;


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
    _borderIsActiveBottomRight = box.get('borderIsActiveBottomRight', defaultValue: false);
    _borderIsActiveTopLeftRight = box.get('borderIsActiveTopRight', defaultValue: false);
    _borderIsActiveLeftRight = box.get('borderIsActiveLeftRight', defaultValue: false);
    _borderIsActiveRightRight = box.get('borderIsActiveRightRight', defaultValue: false);

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
    box.put('borderIsActiveBottomRight', _borderIsActiveBottomRight);
    box.put('borderIsActiveTopRight', _borderIsActiveTopLeftRight);
    box.put('borderIsActiveLeftRight', _borderIsActiveLeftRight);
    box.put('borderIsActiveRightRight', _borderIsActiveRightRight);
  }

  void saveRight(){
    _saveSettings();
    print( 'save succes ScreenSettingsRight ');
  }

  void updateBorderIsActiveRightRight(bool value) {
    _borderIsActiveRightRight = value;
    _saveSettings();
    notifyListeners();
  }
  void updateBorderIsActiveLeftRight(bool value) {
    _borderIsActiveLeftRight = value;
    _saveSettings();
    notifyListeners();
  }
  void updateBorderIsActiveTopRight(bool value) {
    _borderIsActiveTopLeftRight = value;
    _saveSettings();
    notifyListeners();
  }
  void updateBorderIsActiveBottomRight(bool value) {
    _borderIsActiveBottomRight = value;
    _saveSettings();
    notifyListeners();
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

  void updateFromLeft(ScreenSettingsLeft leftSettings) {
    _rightColumnColor = leftSettings.leftColumnColor;
    _rightColorText = leftSettings.leftColorText;
    _rightColorBorder = leftSettings.leftColorBorder;
    _rightSizeText = leftSettings.leftSizeText;
    _rightSizeBorder = leftSettings.leftSizeBorder;
    _styleColumnRight = leftSettings.styleColumnLeft;
    _borderRight = leftSettings.borderLeft;
    _borderIsActiveBottomRight = leftSettings.borderIsActiveBottomLeft;
    _borderIsActiveLeftRight = leftSettings.borderIsActiveLeftLeft;
    _borderIsActiveRightRight = leftSettings.borderIsActiveRightLeft;
    _borderIsActiveTopLeftRight = leftSettings.borderIsActiveTopLeft;

    _saveSettings();
    notifyListeners();
  }

}

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:monitor_for_sales/providers/screen_setting_right.dart';

class ScreenSettingsLeft extends ChangeNotifier {
  String _textLeftTitle = 'Left title';
  Color _leftColumnColor = Colors.white;
  Color _leftColorText = Colors.black;
  Color _leftColorBorder = Colors.black;
  double _leftSizeText = 15.0;
  double _leftSizeBorder = 0.0;
  String _styleColumnLeft = 'Roboto';
  late bool _borderLeft;
  late bool _borderIsActiveBottomLeft;
  late bool _borderIsActiveTopLeft;
  late bool _borderIsActiveLeftLeft;
  late bool _borderIsActiveRightLeft;




  Color get leftColumnColor => _leftColumnColor;
  Color get leftColorText => _leftColorText;
  Color get leftColorBorder => _leftColorBorder;
  String get textLeftTitle => _textLeftTitle;
  double get leftSizeText => _leftSizeText;
  double get leftSizeBorder => _leftSizeBorder;
  String get styleColumnLeft => _styleColumnLeft;
  bool get borderLeft => _borderLeft;
  bool get borderIsActiveBottomLeft => _borderIsActiveBottomLeft;
  bool get borderIsActiveTopLeft => _borderIsActiveTopLeft;
  bool get borderIsActiveLeftLeft => _borderIsActiveLeftLeft;
  bool get borderIsActiveRightLeft => _borderIsActiveRightLeft;


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
    _borderLeft = box.get('borderLeft', defaultValue: false);
    _borderIsActiveBottomLeft = box.get('borderIsActiveBottomLeft', defaultValue: false);
    _borderIsActiveTopLeft = box.get('borderIsActiveTopLeft', defaultValue: false);
    _borderIsActiveLeftLeft = box.get('borderIsActiveLeftLeft', defaultValue: false);
    _borderIsActiveRightLeft = box.get('borderIsActiveRightLeft', defaultValue: false);
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
    box.put('borderLeft', _borderLeft);
    box.put('borderIsActiveBottomLeft', _borderIsActiveBottomLeft);
    box.put('borderIsActiveTopLeft', _borderIsActiveTopLeft);
    box.put('borderIsActiveLeftLeft', _borderIsActiveLeftLeft);
    box.put('borderIsActiveRightLeft', _borderIsActiveRightLeft);
  }
  void updateBorderIsActiveRightLeft(bool value) {
    _borderIsActiveRightLeft = value;
    _saveSettings();
    notifyListeners();
  }

  void updateBorderIsActiveLeftLeft(bool value) {
    _borderIsActiveLeftLeft = value;
    _saveSettings();
    notifyListeners();
  }
  void updateBorderIsActiveTopLeft(bool value) {
    _borderIsActiveTopLeft = value;
    _saveSettings();
    notifyListeners();
  }

  void updateBorderIsActiveBottomLeft(bool value) {
    _borderIsActiveBottomLeft = value;
    _saveSettings();
    notifyListeners();
  }

  void updateBorderLeft(bool value) {
    _borderLeft = value;
    _saveSettings();
    notifyListeners();
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
  void updateFromRight(ScreenSettingsRight rightSettings) {
    _leftColumnColor = rightSettings.rightColumnColor;
    _leftColorText = rightSettings.rightColorText;
    _leftColorBorder = rightSettings.rightColorBorder;
    _leftSizeText = rightSettings.rightSizeText;
    _leftSizeBorder = rightSettings.rightSizeBorder;
    _styleColumnLeft = rightSettings.styleColumnRight;
    _borderLeft = rightSettings.borderRight;
    _borderIsActiveBottomLeft = rightSettings.borderIsActiveBottomRight;
    _borderIsActiveTopLeft = rightSettings.borderIsActiveTopRight;
    _borderIsActiveLeftLeft = rightSettings.borderIsActiveLeftRight;
    _borderIsActiveRightLeft = rightSettings.borderIsActiveRightRight;
    _saveSettings();
    notifyListeners();
  }

}
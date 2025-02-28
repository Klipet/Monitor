
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:monitor_for_sales/broker/color_app.dart';
import 'package:monitor_for_sales/providers/screen_setting_right.dart';

class ScreenSettingsLeft extends ChangeNotifier {
  String _textLeftTitle = 'În pregătire:';
  String _leftColumnColor = colorLeft;
  String _leftColorText = colorTextTitleLeft;
  String _titleColorBox = colorTitleLeftBox;
  String _leftColorBorder = boxBorderColor;
  double _leftSizeText = 15.0;
  double _leftSizeBorder = 0.0;
  String _styleColumnLeft = 'Roboto';
//  late bool _borderLeft;
//  late bool _borderIsActiveBottomLeft;
//  late bool _borderIsActiveTopLeft;
//  late bool _borderIsActiveLeftLeft;
//  late bool _borderIsActiveRightLeft;




  String get leftColumnColor => _leftColumnColor;
  String get leftColorText => _leftColorText;
  String get leftColorBorder => _leftColorBorder;
  String get textLeftTitle => _textLeftTitle;
  String get titleColorBox => _titleColorBox;
  double get leftSizeText => _leftSizeText;
  double get leftSizeBorder => _leftSizeBorder;
  String get styleColumnLeft => _styleColumnLeft;
//  bool get borderLeft => _borderLeft;
//  bool get borderIsActiveBottomLeft => _borderIsActiveBottomLeft;
//  bool get borderIsActiveTopLeft => _borderIsActiveTopLeft;
//  bool get borderIsActiveLeftLeft => _borderIsActiveLeftLeft;
// bool get borderIsActiveRightLeft => _borderIsActiveRightLeft;


  ScreenSettingsLeft() {
    _loadSettings();
  }
  void _loadSettings() async {
    var box = Hive.box('settings');
    _leftColorText = box.get('leftColorText', defaultValue: colorTextTitleLeft);
    _leftColumnColor = box.get('leftColumnColor', defaultValue: colorLeft);
    _titleColorBox = box.get('titleColorBox', defaultValue: colorTitleLeftBox);
    _leftColorBorder = box.get('leftColorBorder', defaultValue: boxBorderColor);
    _leftSizeText = box.get('leftSizeText', defaultValue: 15.0);
    _leftSizeBorder = box.get('leftSizeBorder', defaultValue: 0.0);
    _textLeftTitle = box.get('textLeftTitle', defaultValue: 'În pregătire:');
    _styleColumnLeft = box.get('styleColumnLeft', defaultValue: 'Roboto');
  //  _borderLeft = box.get('borderLeft', defaultValue: false);
  //  _borderIsActiveBottomLeft = box.get('borderIsActiveBottomLeft', defaultValue: false);
  //  _borderIsActiveTopLeft = box.get('borderIsActiveTopLeft', defaultValue: false);
  //  _borderIsActiveLeftLeft = box.get('borderIsActiveLeftLeft', defaultValue: false);
  //  _borderIsActiveRightLeft = box.get('borderIsActiveRightLeft', defaultValue: false);
    notifyListeners();
  }
  void _saveSettings() {
    var box = Hive.box('settings');
    box.put('leftColorText', _leftColorText);
    box.put('leftColumnColor', _leftColumnColor);
    box.put('titleColorBox', _titleColorBox);
    box.put('leftSizeText', _leftSizeText);
    box.put('textLeftTitle', _textLeftTitle);
    box.put('leftColorBorder', _leftColorBorder);
    box.put('leftSizeBorder', _leftSizeBorder);
    box.put('styleColumnLeft', _styleColumnLeft);
  //  box.put('borderLeft', _borderLeft);
  //  box.put('borderIsActiveBottomLeft', _borderIsActiveBottomLeft);
  //  box.put('borderIsActiveTopLeft', _borderIsActiveTopLeft);
  //  box.put('borderIsActiveLeftLeft', _borderIsActiveLeftLeft);
  //  box.put('borderIsActiveRightLeft', _borderIsActiveRightLeft);
  }


//  void updateBorderIsActiveRightLeft(bool value) {
//    _borderIsActiveRightLeft = value;
//    _saveSettings();
//    notifyListeners();
//  }
//
//  void updateBorderIsActiveLeftLeft(bool value) {
//    _borderIsActiveLeftLeft = value;
//    _saveSettings();
//    notifyListeners();
//  }
//  void updateBorderIsActiveTopLeft(bool value) {
//    _borderIsActiveTopLeft = value;
//    _saveSettings();
//    notifyListeners();
//  }
//
//  void updateBorderIsActiveBottomLeft(bool value) {
//    _borderIsActiveBottomLeft = value;
//    _saveSettings();
//    notifyListeners();
//  }
//
//  void updateBorderLeft(bool value) {
//    _borderLeft = value;
//    _saveSettings();
//    notifyListeners();
//  }
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
  void updateLeftColumnColor(String color) {
    _leftColumnColor = color;
    _saveSettings();
    notifyListeners();
  }
  void updateLeftColorText(String color) {
    _leftColorText = color;
    _saveSettings();
    notifyListeners();
  }
  void updateTitleColorBox(String color) {
    _titleColorBox = color;
    _saveSettings();
    notifyListeners();
  }
  void updateLeftColorBorder(String color) {
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
  //  _borderLeft = rightSettings.borderRight;
  //  _borderIsActiveBottomLeft = rightSettings.borderIsActiveBottomRight;
  //  _borderIsActiveTopLeft = rightSettings.borderIsActiveTopRight;
  //  _borderIsActiveLeftLeft = rightSettings.borderIsActiveLeftRight;
  //  _borderIsActiveRightLeft = rightSettings.borderIsActiveRightRight;
    _saveSettings();
    notifyListeners();
  }
  void updaateDefault(){
    _leftColumnColor = colorLeft;
    _leftColorText = colorTextTitleLeft;
    _titleColorBox = colorTitleLeftBox;
    _textLeftTitle = 'În pregătire:';
    _saveSettings();
    notifyListeners();
  }

}
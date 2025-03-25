
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:monitor_for_sales/broker/color_app.dart';
import 'package:monitor_for_sales/providers/screen_setting_left.dart';

class ScreenSettingsRight extends ChangeNotifier {

  String _textRightTitle = 'Pregătite:';
  String _rightColumnColor = colorRight;
  String _rightColorText = colorTextTitleLeft;
  String _rightColorTitleBox = colorTitleRightBox;
  String _rightColorBorder = boxBorderColor;
  double _rightSizeText = 15.0;
  double _rightSizeBorder = 0.0;
  String _styleColumnRight = 'Roboto';
  Alignment _alignment = Alignment.bottomRight;
//  late bool _borderRight;
//  late bool _borderIsActiveBottomRight;
// late bool _borderIsActiveTopLeftRight;
//  late bool _borderIsActiveLeftRight;
// late bool _borderIsActiveRightRight;



  String get rightColumnColor => _rightColumnColor;
  String get rightColorText => _rightColorText;
  String get rightColorTitleBox => _rightColorTitleBox;
  String get rightColorBorder => _rightColorBorder;
  String get textRightTitle => _textRightTitle;
  double get rightSizeText => _rightSizeText;
  double get rightSizeBorder => _rightSizeBorder;
  String get styleColumnRight => _styleColumnRight;
  Alignment get alignment => _alignment;
 // bool get borderRight => _borderRight;
 // bool get borderIsActiveBottomRight => _borderIsActiveBottomRight;
 // bool get borderIsActiveTopRight => _borderIsActiveTopLeftRight;
 // bool get borderIsActiveLeftRight => _borderIsActiveLeftRight;
 // bool get borderIsActiveRightRight => _borderIsActiveRightRight;


  ScreenSettingsRight() {
    _loadSettings();
  }
  void _loadSettings() async {
    var box = Hive.box('settings');
    _rightColorText = box.get('rightColorText', defaultValue: colorTextTitleLeft);
    _rightColumnColor = box.get('rightColumnColor', defaultValue: colorRight);
    _rightColorTitleBox = box.get('rightColorBox', defaultValue: colorTitleRightBox);
    _rightColorBorder = box.get('rightColorBorder', defaultValue: boxBorderColor);
    _rightSizeText = box.get('rightSizeText', defaultValue: 15.0);
    _rightSizeBorder = box.get('rightSizeBorder', defaultValue: 0.0);
    _textRightTitle = box.get('textRightTitle', defaultValue: 'Pregătite:');
    _styleColumnRight = box.get('styleColumnRight', defaultValue: 'Roboto');
    _alignment = box.get('alignment', defaultValue: Alignment.bottomRight);
  //  _borderRight = box.get('borderRight', defaultValue: false);
  //  _borderIsActiveBottomRight = box.get('borderIsActiveBottomRight', defaultValue: false);
  //  _borderIsActiveTopLeftRight = box.get('borderIsActiveTopRight', defaultValue: false);
  //  _borderIsActiveLeftRight = box.get('borderIsActiveLeftRight', defaultValue: false);
  //  _borderIsActiveRightRight = box.get('borderIsActiveRightRight', defaultValue: false);

    notifyListeners();
  }
  void _saveSettings() {
    var box = Hive.box('settings');
    box.put('rightColorText', _rightColorText);
    box.put('rightColumnColor', _rightColumnColor);
    box.put('rightColorBox', _rightColorTitleBox);
    box.put('rightColorBorder', _rightColorBorder);
    box.put('rightSizeText', _rightSizeText);
    box.put('textRightTitle', _textRightTitle);
    box.put('rightSizeBorder', _rightSizeBorder);
    box.put('styleColumnRight', _styleColumnRight);
    box.put('alignment', _alignment);
  //  box.put('borderRight', _borderRight);
  //  box.put('borderIsActiveBottomRight', _borderIsActiveBottomRight);
  //  box.put('borderIsActiveTopRight', _borderIsActiveTopLeftRight);
  //  box.put('borderIsActiveLeftRight', _borderIsActiveLeftRight);
  //  box.put('borderIsActiveRightRight', _borderIsActiveRightRight);
  }

//  void saveRight(){
//    _saveSettings();
//    print( 'save succes ScreenSettingsRight ');
//  }

//  void updateBorderIsActiveRightRight(bool value) {
//    _borderIsActiveRightRight = value;
//    _saveSettings();
//    notifyListeners();
//  }
//  void updateBorderIsActiveLeftRight(bool value) {
//    _borderIsActiveLeftRight = value;
//    _saveSettings();
//    notifyListeners();
//  }
//  void updateBorderIsActiveTopRight(bool value) {
//    _borderIsActiveTopLeftRight = value;
//    _saveSettings();
//    notifyListeners();
//  }
//  void updateBorderIsActiveBottomRight(bool value) {
//    _borderIsActiveBottomRight = value;
//    _saveSettings();
//    notifyListeners();
//  }
//  void updateBorderRight(bool size) {
//    _borderRight = size;
//    _saveSettings();
//    notifyListeners();
//  }
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

  void updateRightColumnColor(String color) {
    _rightColumnColor = color;
    _saveSettings();
    notifyListeners();
  }
  void updateRightTitleBoxColor(String color) {
    _rightColorTitleBox = color;
    _saveSettings();
    notifyListeners();
  }
  void updateRightColorText(String color) {
    _rightColorText = color;
    _saveSettings();
    notifyListeners();
  }
  void updateRightColorBorder(String color) {
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
  void updateAligmant(Alignment aligmantRight){
    _alignment = aligmantRight;
    _saveSettings();
    notifyListeners();
  }


  void updateFromLeft(ScreenSettingsLeft leftSettings) {
  //  _rightColumnColor = leftSettings.leftColumnColor;
    _rightColorText = leftSettings.leftColorText;
    _rightColorBorder = leftSettings.leftColorBorder;
    _rightSizeText = leftSettings.leftSizeText;
    _rightSizeBorder = leftSettings.leftSizeBorder;
    _styleColumnRight = leftSettings.styleColumnLeft;
  //  _borderRight = leftSettings.borderLeft;
  //  _borderIsActiveBottomRight = leftSettings.borderIsActiveBottomLeft;
  //  _borderIsActiveLeftRight = leftSettings.borderIsActiveLeftLeft;
  //  _borderIsActiveRightRight = leftSettings.borderIsActiveRightLeft;
  //  _borderIsActiveTopLeftRight = leftSettings.borderIsActiveTopLeft;

    _saveSettings();
    notifyListeners();
  }

  void updateDefault(){
    _rightColumnColor = colorRight;
    _rightColorText = colorTextTitleLeft;
    _rightColorTitleBox = colorTitleRightBox;
    _textRightTitle = 'Pregătite:';
    _saveSettings();
    notifyListeners();
  }



}
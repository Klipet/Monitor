
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:monitor_for_sales/broker/color_app.dart';
import 'package:monitor_for_sales/providers/screen_setting_box_right.dart';

class ScreenSettingsBoxLeft extends ChangeNotifier {
  String _backgroundBoxColorLeft = colorLeftBox;
  String _boxBorderColorLeft = boxBorderColor;
  String _textBoxColorLeft = colorTextBoxLeft;
  String _styleBoxLeft = 'Roboto';
  double _sizeTextLeft = 15.0;
  double _radiusBoxLeft = 2.0;
  double _sizeBorderLeft = 1.0;
  double _heightBoxLeft = 15.0;
  double _widthBoxLeft = 15.0;
  bool _borderBoxLeft = false;


  String get backgroundBoxColorLeft => _backgroundBoxColorLeft;
  String get boxBorderColorLeft => _boxBorderColorLeft;
  String get textBoxColorLeft => _textBoxColorLeft;
  String get styleBoxLeft => _styleBoxLeft;
  double get sizeTextLeft => _sizeTextLeft;
  double get radiusBoxLeft => _radiusBoxLeft;
  double get sizeBorderLeft => _sizeBorderLeft;
  double get heightBoxLeft => _heightBoxLeft;
  double get widthBoxLeft => _widthBoxLeft;
  bool get borderBoxLeft => _borderBoxLeft;
  ScreenSettingsBoxLeft() {
    _loadSettings();
  }
  void _loadSettings() async {
    var box = Hive.box('settings');
    _backgroundBoxColorLeft = box.get('backgroundBoxColorLeft', defaultValue: colorLeftBox);
    _boxBorderColorLeft = box.get('boxBorderColorLeft', defaultValue: boxBorderColor);
    _textBoxColorLeft = box.get('textBoxColorLeft', defaultValue: colorTextBoxLeft);
    _styleBoxLeft = box.get('styleBoxLeft', defaultValue: 'Roboto');
    _sizeTextLeft = box.get('sizeTextLeft', defaultValue: 15.0);
    _radiusBoxLeft= box.get('radiusBoxLeft', defaultValue: 2.0);
    _sizeBorderLeft = box.get('sizeBorderLeft', defaultValue: 1.0);
    _widthBoxLeft = box.get('widthBoxLeft', defaultValue: 15.0);
    _heightBoxLeft = box.get('heightBoxLeft', defaultValue: 15.0);

    notifyListeners();
  }
  void _saveSettings() {
    var box = Hive.box('settings');
    box.put('backgroundBoxColorLeft', _backgroundBoxColorLeft);
    box.put('boxBorderColorLeft', _boxBorderColorLeft);
    box.put('textBoxColorLeft', _textBoxColorLeft);
    box.put('styleBoxLeft', _styleBoxLeft);
    box.put('sizeTextLeft', _sizeTextLeft);
    box.put('radiusBoxLeft', _radiusBoxLeft);
    box.put('sizeBorderLeft', _sizeBorderLeft);
    box.put('heightBoxLeft', _heightBoxLeft);
    box.put('widthBoxLeft', _widthBoxLeft);
    box.put('borderLeft', _borderBoxLeft);

  }

  void saveSetings(){
    _saveSettings();
    print( 'save succes ScreenSettingsBoxLeft ');
  }


  void updateBorderBoxLeft(bool value) {
    _borderBoxLeft = value;
    _saveSettings();
    notifyListeners();
  }
   void updateBackgroundBoxColor(String color) {
    _backgroundBoxColorLeft = color;
    _saveSettings();
    notifyListeners();
  }
  void updateBackgroundBoxBorderColor(String color) {
    _boxBorderColorLeft = color;
    _saveSettings();
    notifyListeners();
  }
  void updateTextBoxColor(String color) {
    _textBoxColorLeft = color;
    _saveSettings();
    notifyListeners();
  }
  void updateSizeText(double size) {
    _sizeTextLeft = size;
    _saveSettings();
    notifyListeners();
  }
  void updateSizeBorder(double size) {
    _sizeBorderLeft = size;
    _saveSettings();
    notifyListeners();
  }
  void updateHeightBox(double size) {
    _heightBoxLeft = size;
    _saveSettings();
    notifyListeners();
  }
  void updateWidthBox(double size) {
    _widthBoxLeft = size;
    _saveSettings();
    notifyListeners();
  }
  void updateRadiusBox(double size) {
    _radiusBoxLeft = size;
    _saveSettings();
    notifyListeners();
  }
  void updateStyleBoxLeft(String value) {
    _styleBoxLeft = value;
    _saveSettings();
    notifyListeners();
  }
  void updateFromRight(ScreenSettingsBoxRight leftSettings) {
    _backgroundBoxColorLeft = leftSettings.backgroundBoxColorRight;
    _boxBorderColorLeft = leftSettings.boxBorderColorRight;
    _textBoxColorLeft = leftSettings.textBoxColorRight;
    _sizeTextLeft = leftSettings.sizeTextRight;
    _radiusBoxLeft = leftSettings.radiusBoxRight;
    _sizeBorderLeft = leftSettings.sizeBorderRight;
    _heightBoxLeft = leftSettings.heightBoxRight;
    _widthBoxLeft = leftSettings.wightBoxRight;
    _styleBoxLeft = leftSettings.styleBoxRight;
    _saveSettings();
    notifyListeners();
  }

  void updateDefault(){
    _backgroundBoxColorLeft = colorLeftBox;
    _textBoxColorLeft = colorTextBoxLeft;
    _saveSettings();
    notifyListeners();
  }

}

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:monitor_for_sales/broker/color_app.dart';
import 'package:monitor_for_sales/providers/screen_setting_box_left.dart';

class ScreenSettingsBoxRight extends ChangeNotifier {
  String _backgroundBoxColorRight = colorRightBox;
  Color _boxBorderColorRight = Colors.black;
  String _textBoxColorRight = colorTextBoxRight;
  double _sizeTextRight = 15.0;
  double _radiusBoxRight = 2.0;
  double _sizeBorderRight = 1.0;
  double _wightBoxRight = 15.0;
  double _heightBoxRight = 15.0;
  String _styleBoxRight = 'Roboto';


  String get backgroundBoxColorRight => _backgroundBoxColorRight;
  Color get boxBorderColorRight => _boxBorderColorRight;
  String get textBoxColorRight => _textBoxColorRight;
  double get sizeTextRight => _sizeTextRight;
  double get radiusBoxRight => _radiusBoxRight;
  double get sizeBorderRight => _sizeBorderRight;
  double get wightBoxRight => _wightBoxRight;
  double get heightBoxRight => _heightBoxRight;
  String get styleBoxRight => _styleBoxRight;

  ScreenSettingsBoxRight() {
    _loadSettings();
  }
  void _loadSettings() async {
    var box = Hive.box('settings');
    _backgroundBoxColorRight = box.get('backgroundBoxColorRight', defaultValue: colorRightBox);
    _boxBorderColorRight = Color(box.get('boxBorderColorRight', defaultValue: Colors.black.value));
    _textBoxColorRight = box.get('textBoxColorRight', defaultValue: colorTitleRightBox);
    _sizeTextRight = box.get('sizeTextRight', defaultValue: 15.0);
    _radiusBoxRight = box.get('radiusBoxRight', defaultValue: 2.0);
    _sizeBorderRight = box.get('sizeBorderRight', defaultValue: 1.0);
    _wightBoxRight = box.get('wightBoxRight', defaultValue: 15.0);
    _heightBoxRight = box.get('heightBoxRight', defaultValue: 15.0);
    _styleBoxRight = box.get('styleBoxRight', defaultValue: 'Roboto');
    notifyListeners();
  }
  void _saveSettings() {
    var box = Hive.box('settings');
    box.put('backgroundBoxColorRight', _backgroundBoxColorRight);
    box.put('boxBorderColorRight', _boxBorderColorRight.value);
    box.put('textBoxColorRight', _textBoxColorRight);
    box.put('sizeTextRight', _sizeTextRight);
    box.put('radiusBoxRight', _radiusBoxRight);
    box.put('sizeBorderRight', _sizeBorderRight);
    box.put('wightBoxRight', _wightBoxRight);
    box.put('heightBoxRight', _heightBoxRight);
    box.put('styleBoxRight', _styleBoxRight);
  }

  void saveBoxRight(){
    _saveSettings();
    print( 'save succes ScreenSettingsBoxRight ');
  }

  void updateBackgroundBoxColor(String color) {
    _backgroundBoxColorRight = color;
    _saveSettings();
    notifyListeners();
  }
  void updateBackgroundBoxBorderColor(Color color) {
    _boxBorderColorRight = color;
    _saveSettings();
    notifyListeners();
  }
  void updateTextBoxColor(String color) {
    _textBoxColorRight = color;
    _saveSettings();
    notifyListeners();
  }
  void updateSizeText(double size) {
    _sizeTextRight = size;
    _saveSettings();
    notifyListeners();
  }
  void updateSizeBorder(double size) {
    _sizeBorderRight = size;
    _saveSettings();
    notifyListeners();
  }
  void updateWightBox(double size) {
    _wightBoxRight = size;
    _saveSettings();
    notifyListeners();
  }
  void updateHeightBox(double size) {
    _heightBoxRight = size;
    _saveSettings();
    notifyListeners();
  }
  void updateRadiusBox(double size) {
    _radiusBoxRight = size;
    _saveSettings();
    notifyListeners();
  }
  void updateStyleBoxRight(String value) {
    _styleBoxRight = value;
    _saveSettings();
    notifyListeners();
  }
  void updateFromLeft(ScreenSettingsBoxLeft leftSettings) {
  //  _backgroundBoxColorRight = leftSettings.backgroundBoxColorLeft;
    _boxBorderColorRight = leftSettings.boxBorderColorLeft;
  //  _textBoxColorRight = leftSettings.textBoxColorLeft;
    _sizeTextRight = leftSettings.sizeTextLeft;
    _radiusBoxRight = leftSettings.radiusBoxLeft;
    _sizeBorderRight = leftSettings.sizeBorderLeft;
    _heightBoxRight = leftSettings.heightBoxLeft;
    _wightBoxRight = leftSettings.widthBoxLeft;
    _styleBoxRight = leftSettings.styleBoxLeft;
    _saveSettings();
    notifyListeners();
  }
  void updateDefault(){
    _backgroundBoxColorRight = colorRightBox;
    _textBoxColorRight = colorTextBoxRight;
    _saveSettings();
    notifyListeners();
  }

}
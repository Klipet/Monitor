
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class ScreenSettingsBox extends ChangeNotifier {
  Color _backgroundBoxColor = Colors.white;
  Color _backgroundBoxBorderColor = Colors.white;
  Color _textBoxColor = Colors.black;
  double _sizeText = 15.0;
  double _radiusBox = 2.0;
  double _sizeBorder = 1.0;
  double _sizeBox = 15.0;


  Color get backgroundBoxColor => _backgroundBoxColor;
  Color get backgroundBoxBorderColor => _backgroundBoxBorderColor;
  Color get textBoxColor => _textBoxColor;
  double get sizeText => _sizeText;
  double get radiusBox => _radiusBox;
  double get sizeBorder => _sizeBorder;
  double get sizeBox => _sizeBox;

  ScreenSettingsBox() {
    _loadSettings();
  }
  void _loadSettings() async {
    var box = Hive.box('settings');
    _backgroundBoxColor = Color(box.get('backgroundBoxColor', defaultValue: Colors.white.value));
    _backgroundBoxBorderColor = Color(box.get('backgroundBoxBorderColor', defaultValue: Colors.white.value));
    _textBoxColor = Color(box.get('textBoxColor', defaultValue: Colors.black.value));
    _sizeText = box.get('sizeText', defaultValue: 15.0);
    _radiusBox = box.get('radiusBox', defaultValue: 2.0);
    _sizeBorder = box.get('sizeBorder', defaultValue: 1.0);
    _sizeBox = box.get('sizeBox', defaultValue: 15.0);
    notifyListeners();
  }
  void _saveSettings() {
    var box = Hive.box('settings');
    box.put('backgroundBoxColor', _backgroundBoxColor.value);
    box.put('backgroundBoxBorderColor', _backgroundBoxBorderColor.value);
    box.put('textBoxColor', _textBoxColor.value);
    box.put('sizeText', _sizeText);
    box.put('radiusBox', _radiusBox);
    box.put('sizeBorder', _sizeBorder);
    box.put('sizeBox', _sizeBox);
  }

  void updateBackgroundBoxColor(Color color) {
    _backgroundBoxColor = color;
    _saveSettings();
    notifyListeners();
  }
  void updateBackgroundBoxBorderColor(Color color) {
    _backgroundBoxBorderColor = color;
    _saveSettings();
    notifyListeners();
  }
  void updateTextBoxColor(Color color) {
    _textBoxColor = color;
    _saveSettings();
    notifyListeners();
  }
  void updateSizeText(double size) {
    _sizeText = size;
    _saveSettings();
    notifyListeners();
  }
  void updateSizeBorder(double size) {
    _sizeBorder = size;
    _saveSettings();
    notifyListeners();
  }
  void updateSizeBox(double size) {
    _sizeBox = size;
    _saveSettings();
    notifyListeners();
  }
  void updateRadiusBox(double size) {
    _radiusBox = size;
    _saveSettings();
    notifyListeners();
  }

}
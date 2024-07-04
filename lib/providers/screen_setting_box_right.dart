
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class ScreenSettingsBoxRight extends ChangeNotifier {
  Color _backgroundBoxColorRight = Colors.white;
  Color _boxBorderColorRight = Colors.white;
  Color _textBoxColorRight = Colors.black;
  double _sizeTextRight = 15.0;
  double _radiusBoxRight = 2.0;
  double _sizeBorderRight = 1.0;
  double _sizeBoxRight = 15.0;
  String _styleBoxRight = 'Roboto';


  Color get backgroundBoxColorRight => _backgroundBoxColorRight;
  Color get boxBorderColorRight => _boxBorderColorRight;
  Color get textBoxColorRight => _textBoxColorRight;
  double get sizeTextRight => _sizeTextRight;
  double get radiusBoxRight => _radiusBoxRight;
  double get sizeBorderRight => _sizeBorderRight;
  double get sizeBoxRight => _sizeBoxRight;
  String get styleBoxRight => _styleBoxRight;

  ScreenSettingsBoxRight() {
    _loadSettings();
  }
  void _loadSettings() async {
    var box = Hive.box('settings');
    _backgroundBoxColorRight = Color(box.get('backgroundBoxColorRight', defaultValue: Colors.white.value));
    _boxBorderColorRight = Color(box.get('boxBorderColorRight', defaultValue: Colors.white.value));
    _textBoxColorRight = Color(box.get('textBoxColorRight', defaultValue: Colors.black.value));
    _sizeTextRight = box.get('sizeTextRight', defaultValue: 15.0);
    _radiusBoxRight = box.get('radiusBoxRight', defaultValue: 2.0);
    _sizeBorderRight = box.get('sizeBorderRight', defaultValue: 1.0);
    _sizeBoxRight = box.get('sizeBoxRight', defaultValue: 15.0);
    _styleBoxRight = box.get('styleBoxRight', defaultValue: 'Roboto');
    notifyListeners();
  }
  void _saveSettings() {
    var box = Hive.box('settings');
    box.put('backgroundBoxColorRight', _backgroundBoxColorRight.value);
    box.put('backgroundBoxBorderColorRight', _boxBorderColorRight.value);
    box.put('textBoxColorRight', _textBoxColorRight.value);
    box.put('sizeTextRight', _sizeTextRight);
    box.put('radiusBoxRight', _radiusBoxRight);
    box.put('sizeBorderRight', _sizeBorderRight);
    box.put('sizeBoxRight', _sizeBoxRight);
    box.put('styleBoxRight', _styleBoxRight);
  }

  void updateBackgroundBoxColor(Color color) {
    _backgroundBoxColorRight = color;
    _saveSettings();
    notifyListeners();
  }
  void updateBackgroundBoxBorderColor(Color color) {
    _boxBorderColorRight = color;
    _saveSettings();
    notifyListeners();
  }
  void updateTextBoxColor(Color color) {
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
  void updateSizeBox(double size) {
    _sizeBoxRight = size;
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

}
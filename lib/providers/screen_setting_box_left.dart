
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class ScreenSettingsBoxLeft extends ChangeNotifier {
  Color _backgroundBoxColorLeft = Colors.white;
  Color _boxBorderColorLeft = Colors.white;
  Color _textBoxColorLeft = Colors.black;
  double _sizeTextLeft = 15.0;
  double _radiusBoxLeft = 2.0;
  double _sizeBorderLeft = 1.0;
  double _sizeBoxLeft = 15.0;


  Color get backgroundBoxColorLeft => _backgroundBoxColorLeft;
  Color get boxBorderColorLeft => _boxBorderColorLeft;
  Color get textBoxColorLeft => _textBoxColorLeft;
  double get sizeTextLeft => _sizeTextLeft;
  double get radiusBoxLeft => _radiusBoxLeft;
  double get sizeBorderLeft => _sizeBorderLeft;
  double get sizeBoxLeft => _sizeBoxLeft;

  ScreenSettingsBoxLeft() {
    _loadSettings();
  }
  void _loadSettings() async {
    var box = Hive.box('settings');
    _backgroundBoxColorLeft = Color(box.get('backgroundBoxColorLeft', defaultValue: Colors.white.value));
    _boxBorderColorLeft = Color(box.get('boxBorderColorLeft', defaultValue: Colors.white.value));
    _textBoxColorLeft = Color(box.get('textBoxColorLeft', defaultValue: Colors.black.value));
    _sizeTextLeft = box.get('sizeTextLeft', defaultValue: 15.0);
    _radiusBoxLeft= box.get('radiusBoxLeft', defaultValue: 2.0);
    _sizeBorderLeft = box.get('sizeBorderLeft', defaultValue: 1.0);
    _sizeBoxLeft = box.get('sizeBoxLeft', defaultValue: 15.0);
    notifyListeners();
  }
  void _saveSettings() {
    var box = Hive.box('settings');
    box.put('backgroundBoxColorLeft', _backgroundBoxColorLeft.value);
    box.put('boxBorderColorLeft', _boxBorderColorLeft.value);
    box.put('textBoxColorLeft', _textBoxColorLeft.value);
    box.put('sizeTextLeft', _sizeTextLeft);
    box.put('radiusBoxLeft', _radiusBoxLeft);
    box.put('sizeBorderLeft', _sizeBorderLeft);
    box.put('sizeBoxLeft', _sizeBoxLeft);
  }

  void updateBackgroundBoxColor(Color color) {
    _backgroundBoxColorLeft = color;
    _saveSettings();
    notifyListeners();
  }
  void updateBackgroundBoxBorderColor(Color color) {
    _boxBorderColorLeft = color;
    _saveSettings();
    notifyListeners();
  }
  void updateTextBoxColor(Color color) {
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
  void updateSizeBox(double size) {
    _sizeBoxLeft = size;
    _saveSettings();
    notifyListeners();
  }
  void updateRadiusBox(double size) {
    _radiusBoxLeft = size;
    _saveSettings();
    notifyListeners();
  }

}
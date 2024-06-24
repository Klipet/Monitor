
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class ScreenSettingsHeader extends ChangeNotifier {
  Color _backgroundColor = Colors.white;
  String _textTitle = '';
  String _styleTitle = 'Roboto';
  Color _textColor = Colors.black;
  double _sizeText = 15.0;
  double _sizeToolBar = 50.0;



  Color get backgroundColor => _backgroundColor;
  String get textTitle => _textTitle;
  String get styleTitle => _styleTitle;
  Color get textColor => _textColor;
  double get sizeText => _sizeText;
  double get sizeToolBar => _sizeToolBar;

  ScreenSettingsHeader() {
    _loadSettings();
  }

  void _loadSettings() async {
    var box = Hive.box('settings');
    _backgroundColor = Color(box.get('backgroundColor', defaultValue: Colors.white.value));
    _textColor = Color(box.get('textColor', defaultValue: Colors.black.value));
    _textTitle = box.get('textTitle', defaultValue: '');
    _styleTitle = box.get('styleTitle', defaultValue: 'Roboto');
    _sizeText = box.get('sizeText', defaultValue: 0.0);
    _sizeToolBar = box.get('sizeToolBar', defaultValue: 0.0);

    notifyListeners();
  }
  void _saveSettings() {
    var box = Hive.box('settings');
    box.put('backgroundColor', _backgroundColor.value);
    box.put('textColor', _textColor.value);
    box.put('textTitle', _textTitle);
    box.put('styleTitle', _styleTitle);
    box.put('sizeText', _sizeText);
    box.put('sizeToolBar', _sizeToolBar);
  }

  void updateTextColor(Color color) {
    _textColor = color;
    _saveSettings();
    notifyListeners();
  }
  void updateBackgroundColor(Color color) {
    _backgroundColor = color;
    _saveSettings();
    notifyListeners();
  }
  void updateSizeText(double value) {
    _sizeText = value;
    _saveSettings();
    notifyListeners();
  }
  void updateSizeToolBar(double value) {
    _sizeToolBar = value;
    _saveSettings();
    notifyListeners();
  }
  void updateTitle(String text) {
    _textTitle = text;
    _saveSettings();
    notifyListeners();
  }
  void updateFontTitle(String text) {
    _styleTitle = text;
    _saveSettings();
    notifyListeners();
  }

}
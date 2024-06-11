
import 'package:flutter/material.dart';

class ScreenSettingsLeft extends ChangeNotifier {
  String _textLeftTitle = 'Left title';
  Color _leftColumnColor = Colors.white;
  Color _leftColorText = Colors.black;
  double _leftSizeText = 15.0;



  Color get leftColumnColor => _leftColumnColor;
  Color get leftColorText => _leftColorText;
  String get textLeftTitle => _textLeftTitle;
  double get leftSizeText => _leftSizeText;


  void updateLeftSizeText(double size) {
    _leftSizeText = size;
    notifyListeners();
  }
  void updateLeftColumnColor(Color color) {
    _leftColumnColor = color;
    notifyListeners();
  }
  void updateLeftColorText(Color color) {
    _leftColorText = color;
    notifyListeners();
  }
  void updateLeftTitle(String text) {
    _textLeftTitle = text;
    notifyListeners();
  }

}
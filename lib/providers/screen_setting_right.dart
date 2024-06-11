
import 'package:flutter/material.dart';

class ScreenSettingsRight extends ChangeNotifier {

  String _textRightTitle = 'Right Title';
  Color _rightColumnColor = Colors.white;
  Color _rightColorText = Colors.black;
  double _rightSizeText = 15.0;



  Color get rightColumnColor => _rightColumnColor;
  Color get rightColorText => _rightColorText;
  String get textRightTitle => _textRightTitle;
  double get rightSizeText => _rightSizeText;


  void updateRightSizeText(double size) {
    _rightSizeText = size;
    notifyListeners();
  }

  void updateRightColumnColor(Color color) {
    _rightColumnColor = color;
    notifyListeners();
  }
  void updateRightColorText(Color color) {
    _rightColorText = color;
    notifyListeners();
  }

  void updateRightTitle(String text) {
    _textRightTitle = text;
    notifyListeners();
  }

}
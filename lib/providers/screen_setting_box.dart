
import 'package:flutter/material.dart';

class ScreenSettingsBox extends ChangeNotifier {
  Color _backgroundBoxColor = Colors.white;
  Color _backgroundBoxBorderColor = Colors.white;
  double _sizeText = 15.0;
  double _sizeBorder = 15.0;
  double _sizeBox = 15.0;


  Color get backgroundBoxColor => _backgroundBoxColor;
  Color get backgroundBoxBorderColor => _backgroundBoxBorderColor;
  double get sizeText => _sizeText;
  double get sizeBorder => _sizeBorder;
  double get sizeBox => _sizeBox;

  void updateBackgroundBoxColor(Color color) {
    _backgroundBoxColor = color;
    notifyListeners();
  }
  void updateBackgroundBoxBorderColor(Color color) {
    _backgroundBoxBorderColor = color;
    notifyListeners();
  }
  void updateSizeText(double size) {
    _sizeText = size;
    notifyListeners();
  }
  void updateSizeBorder(double size) {
    _sizeBorder = size;
    notifyListeners();
  }
  void updateSizeBox(double size) {
    _sizeBox = size;
    notifyListeners();
  }

}
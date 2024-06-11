

import 'package:flutter/material.dart';

class ScreenSettingsHeader extends ChangeNotifier {
  Color _backgroundColor = Colors.white;
  String _textTitle = 'Monitor p/u Cumparator';

  Color get backgroundColor => _backgroundColor;
  String get textTitle => _textTitle;

  void updateBackgroundColor(Color color) {
    _backgroundColor = color;
    notifyListeners();
  }
  void updateTitle(String text) {
    _textTitle = text;
    notifyListeners();
  }

}
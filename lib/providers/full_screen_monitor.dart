import 'dart:async';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class WindowStateMonitor with ChangeNotifier {
  bool _isFullScreen = false;
  Size? _windowSize;
  Timer? _stateMonitorTimer;

  bool get isFullScreen => _isFullScreen;
  Size? get windowSize => _windowSize;

  WindowStateMonitor() {
    _initialize();
  }

  // Инициализация
  Future<void> _initialize() async {
    await windowManager.ensureInitialized();

    // Запускаем мониторинг состояния окна
    _stateMonitorTimer = Timer.periodic(const Duration(milliseconds: 500), (_) async {
      await _checkWindowState();
    });
  }

  // Проверка состояния окна
  Future<void> _checkWindowState() async {
    // Проверяем полноэкранное состояние
    bool isFullScreen = await windowManager.isFullScreen();
  //  print(isFullScreen);
    if (isFullScreen != _isFullScreen) {
      _isFullScreen = isFullScreen;
      notifyListeners();
    }

    // Проверяем размер окна
    Rect bounds = await windowManager.getBounds();
    Size newSize = Size(bounds.width, bounds.height);
    if (newSize != _windowSize) {
      _windowSize = newSize;
      notifyListeners();
    }
  }

  // Очистка таймера
  void dispose() {
    _stateMonitorTimer?.cancel();
    super.dispose();
  }
}
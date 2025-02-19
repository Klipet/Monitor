
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sound_library/sound_library.dart';

import '../adapter/my_sounds_model.dart';

class ScreenSettingsHeader extends ChangeNotifier {
  Sounds _sounds = Sounds.success;
   bool _soundActive = false;
   bool _deleteActive = false;
   bool _videoPlayer = false;
  String  _animatie = "Default"; // Значение по умолчанию;
  Color _backgroundColor = Colors.white;
  String _textTitle = '';
  String _styleTitle = 'Roboto';
  File? _selectedImage;
  Color _textColor = Colors.black;
  double _sizeText = 0.0;
  double _paddingHeader = 0.0;
  double _sizeToolBar = 0.0;
  int _deleteHours = 24;
  int _sizeBox = 4;



  Color get backgroundColor => _backgroundColor;
  String get textTitle => _textTitle;
  String get styleTitle => _styleTitle;
  Color get textColor => _textColor;
  double get sizeText => _sizeText;
  double get paddingHeader => _paddingHeader;
  double get sizeToolBar => _sizeToolBar;
  int get deleteHours => _deleteHours;
  File? get selectedImage => _selectedImage;
  Sounds? get sounds => _sounds;
  bool get soundActive => _soundActive;
  bool get deleteActive => _deleteActive;
  bool get videoPlayer => _videoPlayer;
  String get animatie => _animatie;
  int get sizeBox => _sizeBox;



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
    _paddingHeader = box.get('paddingHeader', defaultValue: 0);
    _sizeToolBar = box.get('sizeToolBar', defaultValue: 0.0);
    _deleteHours = box.get('deleteHours', defaultValue: 0);
  //  _sounds = box.get('sounds', defaultValue: Sounds.action.toString());
    String? savedSound  = box.get('sounds');
    if (savedSound != null) {
      _sounds = Sounds.values.firstWhere(
            (sound) => sound.toString() == savedSound,
        orElse: () => Sounds.success,
      );
    }
    _soundActive = box.get('soundActive', defaultValue: false);
    _deleteActive = box.get('deleteActive', defaultValue: false);
    _videoPlayer = box.get('videoPlayer', defaultValue: false);
    _animatie = box.get('animatie', defaultValue: "Default");
    String? imagePath = box.get('selectedImage', defaultValue: null);
    if (imagePath != null) {
      _selectedImage = File(imagePath);
    }
    _sizeBox = box.get('sizeBox', defaultValue: 4);
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
    box.put('deleteHours', _deleteHours);
    if (kDebugMode) {
      print( 'save succes Box $_deleteHours, ${box.get('deleteHours')}');
    }
    box.put('sounds', _sounds.toString());
    box.put('paddingHeader', _paddingHeader);
    box.put('soundActive', _soundActive);
    box.put('deleteActive', _deleteActive);
    box.put('videoPlayer', _videoPlayer);
    box.put('animatie', _animatie);
    if (_selectedImage != null) {
      box.put('selectedImage', _selectedImage!.path);
    }
    box.put('sizeBox', _sizeBox);
  }

  void updateSizeBox(int value) {
    _sizeBox = value;
    _saveSettings();
    notifyListeners();
  }

  void saveHeader(){
    _saveSettings();
    print( 'save succes ScreenSettingsHeader');
  }
  void updateSounds(Sounds sounds) {
    _sounds = sounds;
    _saveSettings();
    notifyListeners();
  }

  void updateDeleteHours(int value) {
    _deleteHours = value;
    _saveSettings();
    notifyListeners();
  }
  void updateShowVideoPlayer(bool value) {
    _videoPlayer = value;
    _saveSettings();
    notifyListeners();
  }
  void updateDeleteActivate(bool value) {
    _deleteActive = value;
    _saveSettings();
    notifyListeners();
  }
  void updateAnimation(String value) {
    _animatie = value;
    _saveSettings();
    notifyListeners();
  }
  void updateSoundsActive(bool value) {
    _soundActive = value;
    _saveSettings();
    notifyListeners();
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
    void updatePaddingText(double value) {
      _paddingHeader = value;
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
    Future<void> updateSelectedImage(File image) async {
      try {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = '${image.path.split('/').last}';
        final newImage = await image.copy(imagePath);
        print('Image copied to: $imagePath');
        _selectedImage = newImage;
        _saveSettings();
        notifyListeners();
      } catch (e) {
        print('Error copying image: $e');
      }
    }
  }

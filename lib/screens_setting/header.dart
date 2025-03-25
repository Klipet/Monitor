import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:sound_library/sound_library.dart';
import 'package:window_manager/window_manager.dart';

import 'dart:io';

import '../providers/screen_setting_header.dart';

class SettingHeader extends StatefulWidget {
  const SettingHeader({super.key});

  @override
  State<SettingHeader> createState() => _SettingHeaderState();
}

class _SettingHeaderState extends State<SettingHeader> {
  TextEditingController _textController = TextEditingController();
  TextEditingController _sizeController = TextEditingController();
  TextEditingController _sizeToolBar = TextEditingController();
  TextEditingController _paddingHeader = TextEditingController();
  final TextEditingController _minuteHeader = TextEditingController();
  late Sounds _selectedSound;
  late int sizeBoxInsert;


  void initState() {
    super.initState();
    _selectedSound = Sounds.success;
    sizeBoxInsert = 4;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final settingsHeader =
            Provider.of<ScreenSettingsHeader>(context, listen: false);
        setState(() {
          _textController.text = settingsHeader.textTitle;
          _sizeController.text = settingsHeader.sizeText.toString();
          _paddingHeader.text = settingsHeader.paddingHeader.toString();
          _sizeToolBar.text = settingsHeader.sizeToolBar.toString();
          _minuteHeader.text = settingsHeader.deleteHours.toString();
        });
      }
    });
  }
  @override
  void dispose() {
    _sizeController.dispose();
    _sizeToolBar.dispose();
    _paddingHeader.dispose();
    _textController.dispose();
    _minuteHeader.dispose();
    super.dispose();
  }

  final List<Sounds> _availableSounds = [
    Sounds.open,
    Sounds.orderComplete,
    Sounds.woodHit,
    Sounds.welcome,
    Sounds.intro,
    Sounds.drag,
    Sounds.deleted,
    Sounds.click,
    Sounds.cashingMachine,
    Sounds.addToCart,
    Sounds.action,
    Sounds.success
  ];

   final List<String> _animation = [
     "Left Right",
     "Top Dawn",
     "Default"
  ];
   final List<int> sizeBoxInsertVariant = [
    2,
    3,
    4,
    5
  ];

  void _playSound(Sounds sound) {
    SoundPlayer.play(sound, volume: 3, position: const Duration(microseconds: 500));
  }

  String _selectedFont = '';
  final List<String> _fonts = [
    'Roboto',
    'Lobster',
    'Pacifico',
    'Oswald',
    'Lato',
    'Raleway',
    'Merriweather'
  ]; // List of fonts to choose from
  void _openColorPicker(BuildContext context, Color currentColor,
      Function(Color) onColorChanged) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: onColorChanged,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final settingsHeader = Provider.of<ScreenSettingsHeader>(context);
    Future<void> _pickImage() async {
      await WindowManager.instance.setAlwaysOnTop(false);
      final fileDialog = OpenFilePicker()
        ..filterSpecification = {'image (*.jpg)': '*.jpg', 'image (*.png)': '*.png'};
      final result = fileDialog.getFile();
      if (result != null) {
        final filePath = result.path;
        final selectedFile = File(filePath);
        await settingsHeader.updateSelectedImage(selectedFile);
      }
      await WindowManager.instance.setAlwaysOnTop(true);
    }

    return Column(
      children: [
    Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          DropdownButton<Sounds>(
                              value: settingsHeader.sounds,
                              onChanged: (Sounds? newValue) {
                                setState(() {

                                  if (newValue != null) {
                                    _selectedSound = newValue;
                                    settingsHeader.updateSounds(newValue);
                                  }
                                });
                              },
                              items: _availableSounds.map<DropdownMenuItem<Sounds>>((Sounds value) {
                                return DropdownMenuItem<Sounds>(
                                  value: value,
                                  child: Text(value.toString()), // Преобразование перечисления в строку для отображения
                                );
                              }).toList()),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: ElevatedButton(
                              onPressed: () => _playSound(_selectedSound),
                              child: Text('Play Selected Sound'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]
                )
              ),
                    Padding(padding: const EdgeInsets.only(left: 0.0),
                      child: Column(
                        children: [
                          Text(settingsHeader.soundActive? 'Enable' : 'Disable'), // Добавляем текст для чекбокса
                          Checkbox(
                            value: settingsHeader.soundActive, // Переменная, хранящая состояние чекбокса
                            onChanged: (bool? value) {
                              setState(() {
                                settingsHeader.updateSoundsActive(value!); // Обновляем состояние
                              });
                            },
                          ),
                        ],
                      ),
                ),

              Padding(padding: const EdgeInsets.only(left: 0.0),
                child: Column(
                  children: [
                    Text(settingsHeader.videoPlayer? 'Enable video' : 'Disable video'), // Добавляем текст для чекбокса
                    Checkbox(
                      value: settingsHeader.videoPlayer, // Переменная, хранящая состояние чекбокса
                      onChanged: (bool? value) {
                        setState(() {
                          settingsHeader.updateShowVideoPlayer(value!); // Обновляем состояние
                        });
                      },
                    ),
                  ],
                ),
              ),
              TextField(
                controller: _minuteHeader,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d*\.?\d*$'), // Разрешает только цифры и одну точку
                  ),
                ],
                decoration: const InputDecoration(labelText: 'Receipt visibility time (Hours)'),
                onChanged: (value) {
                  settingsHeader.updateDeleteHours(int.parse(value));
                  },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Setting Size Box'),
                    ),
                    DropdownButton<int>(
                        value: settingsHeader.sizeBox,
                        onChanged: (int? newValue) {
                          setState(() {
                            if (newValue != null) {
                              sizeBoxInsert = newValue;
                              settingsHeader.updateSizeBox(sizeBoxInsert);
                            }
                          });
                        },
                        items: sizeBoxInsertVariant.map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList()),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _pickImage();
                        },
                        child: const Text('Select Image'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10 ,top: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                           settingsHeader.updateSelectedImage(null);
                        },
                        child: const Text('Delete Image'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
    ],
    );
  }
}

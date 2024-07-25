import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:sound_library/sound_library.dart';

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
  Sounds _selectedSound = Sounds.success;
  String _defaultValue =  "Default";

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final settingsHeader =
            Provider.of<ScreenSettingsHeader>(context, listen: false);
        setState(() {
          _textController.text = settingsHeader.textTitle;
          _sizeController.text = settingsHeader.sizeText.toString();
          _sizeToolBar.text = settingsHeader.sizeToolBar.toString();
        });
      }
    });
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
      final fileDialog = OpenFilePicker()
        ..filterSpecification = {'image (*.jpg)': '*.jpg'};
      final result = fileDialog.getFile();
      if (result != null) {
        final filePath = result.path;
        final selectedFile = File(filePath);
        await settingsHeader.updateSelectedImage(selectedFile);
      }
    }

    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          TextField(
            controller: _sizeController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*\.?\d*$'), // Разрешает только цифры и одну точку
              ),
            ],
            decoration: const InputDecoration(labelText: 'Size Title'),
            onChanged: (value) {
              settingsHeader.updateSizeText(double.parse(value));
            },
          ),

          TextField(
            controller: _sizeToolBar,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*\.?\d*$'), // Разрешает только цифры и одну точку
              ),
            ],
            decoration: const InputDecoration(labelText: 'Size Tool Bar'),
            onChanged: (value) {
              settingsHeader.updateSizeToolBar(double.parse(value));
            },
          ),
          TextField(
            controller: _textController,
            decoration: const InputDecoration(labelText: 'Enter title text'),
            onChanged: (value) {
              settingsHeader.updateTitle(value);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Container(
                  child: Row(
                    children: [
                      DropdownButton<Sounds>(
                          value: _selectedSound,
                          onChanged: (Sounds? newValue) {
                            setState(() {
                              if (newValue != null) {
                                _selectedSound = newValue;
                                settingsHeader.updateSounds(newValue);
                              }
                            });
                          },
                          items: _availableSounds
                              .map<DropdownMenuItem<Sounds>>((Sounds value) {
                            return DropdownMenuItem<Sounds>(
                              value: value,
                              child: Text(value
                                  .toString()), // Преобразование перечисления в строку для отображения
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
              ],
            ),
          ),
          Row(
            children: [
              DropdownButton<String>(
                value: _defaultValue,
                onChanged: (String? newValue) {
                  setState(() {
                    _defaultValue = newValue!;
                    settingsHeader.updateAnimation(newValue);
                  });
                },
                items: _animation.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                settingsHeader.updateSoundsActive(!settingsHeader.soundActive);
              });
            },
            child: Icon(
              settingsHeader.soundActive ? Icons.check_box : Icons.check_box_outline_blank,
              size: 25.0,
              color: settingsHeader.soundActive ? Colors.green : Colors.black,
            ),
          ),
          const SizedBox(width: 10),
          Text(settingsHeader.soundActive ? 'Sound active' : 'Sound is disabled',
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Row(
            children: [
              DropdownButton<String>(
                value: settingsHeader.styleTitle,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedFont = newValue!;
                    settingsHeader.updateFontTitle(newValue);
                  });
                },
                items: _fonts.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: GoogleFonts.getFont(value)),
                  );
                }).toList(),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ElevatedButton(
              onPressed: () {
                _openColorPicker(context, settingsHeader.textColor, (color) {
                  setState(() {
                    settingsHeader.updateTextColor(color);
                  });
                });
              },
              child: const Text('Text Color'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 10),
            child: ElevatedButton(
              onPressed: () {
                _openColorPicker(context, settingsHeader.backgroundColor,
                    (color) {
                  setState(() {
                    settingsHeader.updateBackgroundColor(color);
                  });
                });
              },
              child: const Text('Background Color'),
            ),
          ),
          //    Padding(
          //      padding: const EdgeInsets.only(top: 8.0),
          //      child: ElevatedButton(
          //        onPressed: () {
          //          _pickImage();
          //        },
          //        child: const Text('Select Image'),
          //      ),
          //    ),
        ],
      ),
    );
  }
}

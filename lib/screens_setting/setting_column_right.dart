import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:monitor_for_sales/broker/color_app.dart';
import 'package:monitor_for_sales/providers/screen_setting_left.dart';
import 'package:provider/provider.dart';

import '../providers/screen_setting_right.dart';

class SettingColumnRight extends StatefulWidget {
  const SettingColumnRight({super.key});

  @override
  State<SettingColumnRight> createState() => _SettingColumnRightState();
}

class _SettingColumnRightState extends State<SettingColumnRight> {
  TextEditingController _rightTextController = TextEditingController();
  TextEditingController _rightSizeController = TextEditingController();
  TextEditingController _rightSizeBorder = TextEditingController();
  TextEditingController _colorPickerController = TextEditingController();

  void _openColorPicker(BuildContext context, String defaultColor, HexColor currentColor, Function(Color) onColorChanged) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: onColorChanged,
              hexInputBar: true,
              hexInputController: _colorPickerController,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Default color'),
              onPressed: () {
                setState(() {
                  _colorPickerController.text = defaultColor;
                });
              },
            ),
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

  String _selectedFont = '';
  final List<String> _fonts = [
    'Roboto',
    'Lobster',
    'Pacifico',
    'Oswald',
    'Lato',
    'Raleway',
    'Merriweather'
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final settingsRight =
            Provider.of<ScreenSettingsRight>(context, listen: false);
        setState(() {
          _rightTextController.text = settingsRight.textRightTitle;
          _rightSizeController.text = settingsRight.rightSizeText.toString();
          _rightSizeBorder.text = settingsRight.rightSizeBorder.toString();
        });
      }
    });
  }
  @override
  void dispose() {
    _rightTextController.dispose();
    _rightSizeController.dispose();
    _rightSizeBorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingsRight = Provider.of<ScreenSettingsRight>(context);
    final settingsLeft = Provider.of<ScreenSettingsLeft>(context);
    return Column(
      children: [
        TextField(
          controller: _rightTextController,
          decoration:
              const InputDecoration(labelText: 'Enter right column text'),
          onChanged: (value) {
            settingsRight.updateRightTitle(value);
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ElevatedButton(
            onPressed: () {
              _openColorPicker(context, colorRight ,HexColor(settingsRight.rightColumnColor),
                  (color) {
                setState(() {
                  settingsRight.updateRightColumnColor(colorToHex(color));
                });
              });
            },
            child: const Text('Change Right Column Color'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 5),
          child: ElevatedButton(
            onPressed: () {
              _openColorPicker(context, colorTitleRightBox , HexColor(settingsRight.rightColorText), (color) {
                setState(() {
                  settingsRight.updateRightTitleBoxColor(colorToHex(color));
                });
              });
            },
            child: const Text('Change Right Title Color'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 5),
          child: ElevatedButton(
            onPressed: () {
              _openColorPicker(context, colorTextTitleRight , HexColor(settingsRight.rightColorText), (color) {
                setState(() {
                  settingsRight.updateRightColorText(colorToHex(color));
                });
              });
            },
            child: const Text('Change Right Column Text Color'),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
                onPressed: () {settingsRight.updateAligmant(Alignment.topRight);},
                child: Image.asset('assets/images/up-right.png')
            ),
            OutlinedButton(
                onPressed: () {
                  settingsRight.updateAligmant(Alignment.topLeft);
                },
                child: Image.asset('assets/images/up-left.png')
            ),
            OutlinedButton(
                onPressed: () {
                  settingsRight.updateAligmant(Alignment.bottomRight);
                },
                child: Image.asset('assets/images/down-right.png')
            ),
            OutlinedButton(
                onPressed: () {
                  settingsRight.updateAligmant(Alignment.bottomLeft);
                },
                child: Image.asset('assets/images/down-left.png')
            ),

          ],
        ),
      ],
    );
  }
}

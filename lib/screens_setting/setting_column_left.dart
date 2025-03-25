import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:monitor_for_sales/broker/color_app.dart';
import 'package:monitor_for_sales/providers/screen_setting_right.dart';
import 'package:provider/provider.dart';
import '../providers/screen_setting_left.dart';

class SettingColumnLeft extends StatefulWidget {
  const SettingColumnLeft({super.key});

  @override
  State<SettingColumnLeft> createState() => _SettingColumnLeft();
}

class _SettingColumnLeft extends State<SettingColumnLeft> {
  TextEditingController _leftTextController = TextEditingController();
  TextEditingController _leftSizeController = TextEditingController();
  TextEditingController _leftSizeBorder = TextEditingController();
  TextEditingController _colorPickerController = TextEditingController();
  bool selectedIcon = false;

  void _openColorPicker(BuildContext context, String defaultColor,
      HexColor currentColor, Function(Color) onColorChanged) {
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
        final settingsLeft =
            Provider.of<ScreenSettingsLeft>(context, listen: false);
        setState(() {
          _leftTextController.text = settingsLeft.textLeftTitle;
          _leftSizeController.text = settingsLeft.leftSizeText.toString();
          _leftSizeBorder.text = settingsLeft.leftSizeBorder.toString();
        });
      }
    });
  }

  void dispose() {
    _leftTextController.dispose();
    _leftSizeBorder.dispose();
    _leftSizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingsLeft = Provider.of<ScreenSettingsLeft>(context);
    final settingsRight = Provider.of<ScreenSettingsRight>(context);

    return Column(
      children: [
        TextField(
          controller: _leftTextController,
          decoration:
              const InputDecoration(labelText: 'Enter left column text'),
          onChanged: (value) {
            settingsLeft.updateLeftTitle(value);
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ElevatedButton(
            onPressed: () {
              _openColorPicker(
                  context, colorLeft, HexColor(settingsLeft.leftColumnColor),
                  (color) {
                setState(() {
                  settingsLeft.updateLeftColumnColor(colorToHex(color));
                });
              });
            },
            child: const Text('Change Left Column Color'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ElevatedButton(
            onPressed: () {
              _openColorPicker(
                  context, colorLeftBox, HexColor(settingsLeft.titleColorBox),
                  (color) {
                setState(() {
                  settingsLeft.updateTitleColorBox(colorToHex(color));
                });
              });
            },
            child: const Text('Change Left Title Color'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 5),
          child: ElevatedButton(
            onPressed: () {
              _openColorPicker(context, colorTextTitleLeft,
                  HexColor(settingsLeft.leftColorText), (color) {
                setState(() {
                  settingsLeft.updateLeftColorText(colorToHex(color));
                });
              });
            },
            child: const Text('Change Left Column Text Color'),
          ),
        ),
      ],
    );
  }
}

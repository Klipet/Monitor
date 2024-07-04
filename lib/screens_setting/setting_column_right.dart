import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Column(
      children: [
        TextField(
          controller: _rightSizeController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'^\d*\.?\d*$'), // Разрешает только цифры и одну точку
            ),
          ],
          decoration: const InputDecoration(labelText: 'Enter size Right text'),
          onChanged: (value) {
            settingsRight.updateRightSizeText(double.parse(value));
          },
        ),
        TextField(
          controller: _rightSizeBorder,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'^\d*\.?\d*$'), // Разрешает только цифры и одну точку
            ),
          ],
          decoration: const InputDecoration(labelText: 'Enter size Right Border'),
          onChanged: (value) {
            settingsRight.updateRightSizeBorder(double.parse(value));
          },
        ),
        TextField(
          controller: _rightTextController,
          decoration:
              const InputDecoration(labelText: 'Enter right column text'),
          onChanged: (value) {
            settingsRight.updateRightTitle(value);
          },
        ),
        Row(
          children: [
            DropdownButton<String>(
              value: settingsRight.styleColumnRight,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedFont = newValue!;
                  settingsRight.updateStyleColumnRight(newValue);
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
              _openColorPicker(context, settingsRight.rightColumnColor,
                  (color) {
                setState(() {
                  settingsRight.updateRightColumnColor(color);
                });
              });
            },
            child: const Text('Change Right Column Color'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ElevatedButton(
            onPressed: () {
              _openColorPicker(context, settingsRight.rightColorText, (color) {
                setState(() {
                  settingsRight.updateRightColorText(color);
                });
              });
            },
            child: const Text('Change Right Column Text Color'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ElevatedButton(
            onPressed: () {
              _openColorPicker(context, settingsRight.rightColorBorder, (color) {
                setState(() {
                  settingsRight.updateRightColorBorder(color);
                });
              });
            },
            child: const Text('Change Right Column Border Color'),
          ),
        ),
      ],
    );
  }
}

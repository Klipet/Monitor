import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final settingsRight =
            Provider.of<ScreenSettingsRight>(context, listen: false);
        setState(() {
          _rightTextController.text = settingsRight.textRightTitle;
          _rightSizeController.text = settingsRight.rightSizeText.toString();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final settingsRight = Provider.of<ScreenSettingsRight>(context);
    return Column(
      children: [
        TextField(
          controller: _rightSizeController,
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
      ],
    );
  }
}

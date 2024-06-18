import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import '../providers/screen_setting_left.dart';
import '../providers/screen_setting_right.dart';

class SettingColumnLeft extends StatefulWidget {
  const SettingColumnLeft({super.key});

  @override
  State<SettingColumnLeft> createState() => _SettingColumnLeft();
}


class _SettingColumnLeft extends State<SettingColumnLeft> {
  TextEditingController _leftTextController = TextEditingController();
  TextEditingController _leftSizeController = TextEditingController();

  void _openColorPicker(BuildContext context, Color currentColor, Function(Color) onColorChanged) {
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
        final settingsLeft = Provider.of<ScreenSettingsLeft>(context, listen: false);
        setState(() {
          _leftTextController.text = settingsLeft.textLeftTitle;
          _leftSizeController.text = settingsLeft.leftSizeText.toString();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final settingsLeft = Provider.of<ScreenSettingsLeft>(context);
    return Column(
      children: [
            TextField(
              controller: _leftSizeController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'^\d*\.?\d*$'), // Разрешает только цифры и одну точку
                ),],
              decoration: const InputDecoration(labelText: 'Enter size Left text'),
              onChanged: (value) {
                settingsLeft.updateLeftSizeText(double.parse(value));
              },
            ),
            TextField(
              controller: _leftTextController,
              decoration: const InputDecoration(labelText: 'Enter left column text'),
              onEditingComplete: () {
                String value = _leftTextController.text;
                settingsLeft.updateLeftTitle(value);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  _openColorPicker(context, settingsLeft.leftColumnColor, (color) {
                    setState(() {
                      settingsLeft.updateLeftColumnColor(color);
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
                  _openColorPicker(context, settingsLeft.leftColorText, (color) {
                    setState(() {
                      settingsLeft.updateLeftColorText(color);
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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import '../providers/screen_setting_box.dart';

class SettingBox extends StatefulWidget {
  const SettingBox({super.key});

  @override
  State<SettingBox> createState() => _SettingBoxState();
}

class _SettingBoxState extends State<SettingBox> {
  TextEditingController _boxSize = TextEditingController();
  TextEditingController _boxBorderSize = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final settingsBox = Provider.of<ScreenSettingsBox>(
            context, listen: false);
        setState(() {
          _boxSize.text = settingsBox.sizeBox.toString();
          _boxBorderSize.text = settingsBox.sizeBorder.toString();
        });
      }
    });
  }
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
  Widget build(BuildContext context) {
    final settingsBox = Provider.of<ScreenSettingsBox>(context);
    return Material(
      child: Column(
        children: [
          TextField(
            controller: _boxBorderSize,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*\.?\d*$'), // Разрешает только цифры и одну точку
              ),],
            decoration: const InputDecoration(labelText: 'Size Border'),
            onChanged: (value) {
              settingsBox.updateSizeBorder(double.parse(value));
            },
          ),
          TextField(
            controller: _boxSize,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*\.?\d*$'), // Разрешает только цифры и одну точку
              ),],
            decoration: const InputDecoration(labelText: 'Size Box'),
            onChanged: (value) {
              settingsBox.updateSizeBox(double.parse(value));
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ElevatedButton(
              onPressed: () {
                _openColorPicker(context, settingsBox.backgroundBoxColor, (color) {
                  setState(() {
                    settingsBox.updateBackgroundBoxColor(color);
                  });
                });
              },
              child: const Text('Background Box Color'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ElevatedButton(
              onPressed: () {
                _openColorPicker(context, settingsBox.backgroundBoxBorderColor, (color) {
                  setState(() {
                    settingsBox.updateBackgroundBoxBorderColor(color);
                  });
                });
              },
              child: const Text('Background Box Border Color'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ElevatedButton(
              onPressed: () {
                _openColorPicker(context, settingsBox.textBoxColor, (color) {
                  setState(() {
                    settingsBox.updateTextBoxColor(color);
                  });
                });
              },
              child: const Text('Text Box Color'),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import '../providers/screen_setting_box_left.dart';

class SettingBoxLeft extends StatefulWidget {
  const SettingBoxLeft({super.key});

  @override
  State<SettingBoxLeft> createState() => _SettingBoxLeft();
}

class _SettingBoxLeft extends State<SettingBoxLeft> {
  TextEditingController _boxSize = TextEditingController();
  TextEditingController _boxBorderSize = TextEditingController();
  TextEditingController _boxTextSize = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final settingsBox = Provider.of<ScreenSettingsBoxLeft>(
            context, listen: false);
        setState(() {
          _boxSize.text = settingsBox.sizeBoxLeft.toString();
          _boxBorderSize.text = settingsBox.sizeBorderLeft.toString();
          _boxTextSize.text = settingsBox.sizeTextLeft.toString();
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
    final settingsBox = Provider.of<ScreenSettingsBoxLeft>(context);
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
            controller: _boxTextSize,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*\.?\d*$'), // Разрешает только цифры и одну точку
              ),],
            decoration: const InputDecoration(labelText: 'Size Text'),
            onChanged: (value) {
              settingsBox.updateSizeText(double.parse(value));
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
                _openColorPicker(context, settingsBox.backgroundBoxColorLeft, (color) {
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
                _openColorPicker(context, settingsBox.boxBorderColorLeft, (color) {
                  setState(() {
                    settingsBox.updateBackgroundBoxBorderColor(color);
                  });
                });
              },
              child: const Text('Box Border Color'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ElevatedButton(
              onPressed: () {
                _openColorPicker(context, settingsBox.textBoxColorLeft, (color) {
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

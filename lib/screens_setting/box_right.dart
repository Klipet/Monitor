import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:monitor_for_sales/providers/screen_setting_box_right.dart';
import 'package:provider/provider.dart';

import '../providers/screen_setting_box_left.dart';

class SettingBoxRight extends StatefulWidget {
  const SettingBoxRight({super.key});

  @override
  State<SettingBoxRight> createState() => _SettingBoxRight();
}

class _SettingBoxRight extends State<SettingBoxRight> {
  TextEditingController _boxSize = TextEditingController();
  TextEditingController _boxBorderSize = TextEditingController();
  TextEditingController _boxTextSize = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final settingsBox = Provider.of<ScreenSettingsBoxRight>(
            context, listen: false);
        setState(() {
          _boxSize.text = settingsBox.sizeBoxRight.toString();
          _boxBorderSize.text = settingsBox.sizeBorderRight.toString();
          _boxTextSize.text = settingsBox.sizeTextRight.toString();
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
    final settingsBox = Provider.of<ScreenSettingsBoxRight>(context);
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
                _openColorPicker(context, settingsBox.backgroundBoxColorRight, (color) {
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
                _openColorPicker(context, settingsBox.boxBorderColorRight, (color) {
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
                _openColorPicker(context, settingsBox.textBoxColorRight, (color) {
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

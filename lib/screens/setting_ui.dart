import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:monitor_for_sales/providers/screen_setting_box.dart';
import 'package:monitor_for_sales/providers/screen_setting_header.dart';
import 'package:monitor_for_sales/providers/screen_setting_right.dart';
import 'package:provider/provider.dart';
import '../providers/screen_setting_left.dart';

class SettingUIDialog extends StatefulWidget {
  const SettingUIDialog({super.key});

  @override
  State<SettingUIDialog> createState() => _SettingUIDialogState();
}

class _SettingUIDialogState extends State<SettingUIDialog> {
  TextEditingController _textController = TextEditingController();
  TextEditingController _leftTextController = TextEditingController();
  TextEditingController _rightTextController = TextEditingController();
  TextEditingController _rightSizeController = TextEditingController();
  TextEditingController _leftSizeController = TextEditingController();
  TextEditingController _boxSize = TextEditingController();
  TextEditingController _boxBorderSize = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final settingsLeft = Provider.of<ScreenSettingsLeft>(context, listen: false);
        final settingsRight = Provider.of<ScreenSettingsRight>(context, listen: false);
        final settingsHeader = Provider.of<ScreenSettingsHeader>(context, listen: false);
        final settingsBox = Provider.of<ScreenSettingsBox>(context, listen: false);
        setState(() {
          _textController.text = settingsHeader.textTitle;
          _leftTextController.text = settingsLeft.textLeftTitle;
          _rightTextController.text = settingsRight.textRightTitle;
          _rightSizeController.text = settingsRight.rightSizeText.toString();
          _leftSizeController.text = settingsLeft.leftSizeText.toString();
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
    final settingsLeft = Provider.of<ScreenSettingsLeft>(context);
    final settingsRight = Provider.of<ScreenSettingsRight>(context);
    final settingsHeader = Provider.of<ScreenSettingsHeader>(context);
    final settingsBox = Provider.of<ScreenSettingsBox>(context);
    return AlertDialog(
      alignment: Alignment.center,
      title: const Text('Settings'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
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
              controller: _textController,
              decoration: const InputDecoration(labelText: 'Enter title text'),
              onChanged: (value) {
                settingsHeader.updateTitle(value);
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
            TextField(
              controller: _rightTextController,
              decoration: const InputDecoration(labelText: 'Enter right column text'),
              onChanged: (value) {
                settingsRight.updateRightTitle(value);
              },
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
                child: const Text('Box Border Color'),
              ),
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
                child: const Text('Box Color'),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  _openColorPicker(context, settingsHeader.backgroundColor, (color) {
                    setState(() {
                      settingsHeader.updateBackgroundColor(color);
                    });
                  });
                },
                child: const Text('Change Background Color'),
              ),
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
                  _openColorPicker(context, settingsRight.rightColumnColor, (color) {
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
                  _openColorPicker(context, settingsLeft.leftColorText, (color) {
                    setState(() {
                      settingsLeft.updateLeftColorText(color);
                    });
                  });
                },
                child: const Text('Change Left Column Text Color'),
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
                  Navigator.of(context).pop();
                },
                child: const Text('Exit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
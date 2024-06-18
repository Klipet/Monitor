import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import '../providers/screen_setting_header.dart';


class SettingHeader extends StatefulWidget {
  const SettingHeader({super.key});

  @override
  State<SettingHeader> createState() => _SettingHeaderState();
}

class _SettingHeaderState extends State<SettingHeader> {
  TextEditingController _textController = TextEditingController();
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final settingsHeader = Provider.of<ScreenSettingsHeader>(context, listen: false);
        setState(() {
          _textController.text = settingsHeader.textTitle;
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
    final settingsHeader = Provider.of<ScreenSettingsHeader>(context);
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white
      ),
      child: Column(
        children: [
          TextField(
            controller: _textController,
            decoration: const InputDecoration(labelText: 'Enter title text'),
            onChanged: (value) {
              settingsHeader.updateTitle(value);
            },
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
              child: const Text('Background Color'),
            ),
          ),
        ],
      ),
    );
  }
}

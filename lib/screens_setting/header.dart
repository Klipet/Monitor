import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/screen_setting_header.dart';


class SettingHeader extends StatefulWidget {
  const SettingHeader({super.key});

  @override
  State<SettingHeader> createState() => _SettingHeaderState();
}

class _SettingHeaderState extends State<SettingHeader> {
  TextEditingController _textController = TextEditingController();
  TextEditingController _sizeController = TextEditingController();
  TextEditingController _sizeToolBar = TextEditingController();


  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final settingsHeader = Provider.of<ScreenSettingsHeader>(context, listen: false);
        setState(() {
          _textController.text = settingsHeader.textTitle;
          _sizeController.text = settingsHeader.sizeText.toString();
          _sizeToolBar.text = settingsHeader.sizeToolBar.toString();
        });
      }
    });
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
  ]; // List of fonts to choose from
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
            controller: _sizeController,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*\.?\d*$'), // Разрешает только цифры и одну точку
              ),],
            decoration: const InputDecoration(labelText: 'Size Title'),
            onChanged: (value) {
              settingsHeader.updateSizeText(double.parse(value));
            },
          ),

          TextField(
            controller: _sizeToolBar,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*\.?\d*$'), // Разрешает только цифры и одну точку
              ),],
            decoration: const InputDecoration(labelText: 'Size Tool Bar'),
            onChanged: (value) {
              settingsHeader.updateSizeToolBar(double.parse(value));
            },
          ),
          TextField(
            controller: _textController,
            decoration: const InputDecoration(labelText: 'Enter title text'),
            onChanged: (value) {
              settingsHeader.updateTitle(value);
            },
          ),
          Row(
            children: [
              DropdownButton<String>(
                value: settingsHeader.styleTitle,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedFont = newValue!;
                    settingsHeader.updateFontTitle(newValue);
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
                _openColorPicker(context, settingsHeader.textColor, (color) {
                  setState(() {
                    settingsHeader.updateTextColor(color);
                  });
                });
              },
              child: const Text('Text Color'),
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
              child: const Text('Background Color'),
            ),
          ),
        ],
      ),
    );
  }
}

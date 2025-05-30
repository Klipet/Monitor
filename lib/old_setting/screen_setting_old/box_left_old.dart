import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:monitor_for_sales/broker/color_app.dart';
import 'package:monitor_for_sales/providers/screen_setting_box_right.dart';
import 'package:provider/provider.dart';

import '../../providers/screen_setting_box_left.dart';


class SettingBoxLeftOld extends StatefulWidget {
  const SettingBoxLeftOld({super.key});

  @override
  State<SettingBoxLeftOld> createState() => _SettingBoxLeft();
}

class _SettingBoxLeft extends State<SettingBoxLeftOld> {
  TextEditingController _boxHeightSize = TextEditingController();
  TextEditingController _boxWidthSize = TextEditingController();
  TextEditingController _boxBorderSize = TextEditingController();
  TextEditingController _boxTextSize = TextEditingController();
  TextEditingController _colorPickerController = TextEditingController();


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
        final settingsBox = Provider.of<ScreenSettingsBoxLeft>(
            context, listen: false);
        setState(() {
          _boxHeightSize.text = settingsBox.heightBoxLeft.toString();
          _boxWidthSize.text = settingsBox.widthBoxLeft.toString();
          _boxBorderSize.text = settingsBox.sizeBorderLeft.toString();
          _boxTextSize.text = settingsBox.sizeTextLeft.toString();
        });
      }
    });
  }
  void _openColorPicker(BuildContext context, String defaultColor, HexColor currentColor, Function(Color) onColorChanged) {
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

    @override
  Widget build(BuildContext context) {
    final settingsBox = Provider.of<ScreenSettingsBoxLeft>(context);
    final settingsBoxRight = Provider.of<ScreenSettingsBoxRight>(context);
    return Material(
      child: Column(
        children: [
         TextField(
           controller: _boxBorderSize,
           keyboardType: TextInputType.number,
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
           keyboardType: TextInputType.number,
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
           controller: _boxHeightSize,
           keyboardType: TextInputType.number,
           inputFormatters: [
             FilteringTextInputFormatter.allow(
               RegExp(r'^\d*\.?\d*$'), // Разрешает только цифры и одну точку
             ),],
           decoration: const InputDecoration(labelText: 'Height Box Left '),
           onChanged: (value) {
             settingsBox.updateHeightBox(double.parse(value));
           },
         ),
         TextField(
           controller: _boxWidthSize,
           keyboardType: TextInputType.number,
           inputFormatters: [
             FilteringTextInputFormatter.allow(
               RegExp(r'^\d*\.?\d*$'), // Разрешает только цифры и одну точку
             ),],
           decoration: const InputDecoration(labelText: 'Width Box Left '),
           onChanged: (value) {
             settingsBox.updateWidthBox(double.parse(value));
           },
         ),
         Row(
           children: [
             DropdownButton<String>(
               value: settingsBox.styleBoxLeft,
               onChanged: (String? newValue) {
                 setState(() {
                   _selectedFont = newValue!;
                   settingsBox.updateStyleBoxLeft(newValue);
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
                _openColorPicker(context, colorLeftBox ,   HexColor(settingsBox.backgroundBoxColorLeft), (color) {
                  setState(() {
                    settingsBox.updateBackgroundBoxColor(colorToHex(color));
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
                _openColorPicker(context, boxBorderColor, HexColor(settingsBox.boxBorderColorLeft), (color) {
                  setState(() {
                    settingsBox.updateBackgroundBoxBorderColor(colorToHex(color));
                  });
                });
              },
              child: const Text('Box Border Color'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 5.0),
            child: ElevatedButton(
              onPressed: () {
                _openColorPicker(context, colorTextBoxLeft ,  HexColor(settingsBox.textBoxColorLeft), (color) {
                  setState(() {
                    settingsBox.updateTextBoxColor(colorToHex(color));
                  });
                });
              },
              child: const Text('Text Box Color'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 5.0),
            child: ElevatedButton(
              onPressed: () {
                  setState(() {
                    settingsBoxRight.updateFromLeft(settingsBox);
                  });
              },
              child: const Text('Copy to Right'),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:monitor_for_sales/broker/color_app.dart';
import 'package:monitor_for_sales/providers/screen_setting_box_right.dart';
import 'package:provider/provider.dart';

import '../providers/screen_setting_box_left.dart';

class SettingBoxRight extends StatefulWidget {
  const SettingBoxRight({super.key});

  @override
  State<SettingBoxRight> createState() => _SettingBoxRight();
}

class _SettingBoxRight extends State<SettingBoxRight> {
  TextEditingController _wightBoxRight = TextEditingController();
  TextEditingController _heightBoxRight = TextEditingController();
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
        final settingsBox = Provider.of<ScreenSettingsBoxRight>(
            context, listen: false);
        setState(() {
          _wightBoxRight.text = settingsBox.wightBoxRight.toString();
          _heightBoxRight.text = settingsBox.heightBoxRight.toString();
          _boxBorderSize.text = settingsBox.sizeBorderRight.toString();
          _boxTextSize.text = settingsBox.sizeTextRight.toString();
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
    final settingsBox = Provider.of<ScreenSettingsBoxRight>(context);
    final settingsBoxLeft = Provider.of<ScreenSettingsBoxLeft>(context);
    return Material(
      child: Column(
        children: [
      //    TextField(
      //      controller: _boxBorderSize,
      //      keyboardType: TextInputType.number,
      //      inputFormatters: [
      //        FilteringTextInputFormatter.allow(
      //          RegExp(r'^\d*\.?\d*$'), // Разрешает только цифры и одну точку
      //        ),],
      //      decoration: const InputDecoration(labelText: 'Size Border'),
      //      onChanged: (value) {
      //        settingsBox.updateSizeBorder(double.parse(value));
      //      },
      //    ),
      //    TextField(
      //      controller: _boxTextSize,
      //      keyboardType: TextInputType.number,
      //      inputFormatters: [
      //        FilteringTextInputFormatter.allow(
      //          RegExp(r'^\d*\.?\d*$'), // Разрешает только цифры и одну точку
      //        ),],
      //      decoration: const InputDecoration(labelText: 'Size Text'),
      //      onChanged: (value) {
      //        settingsBox.updateSizeText(double.parse(value));
      //      },
      //    ),
      //    TextField(
      //      controller: _heightBoxRight,
      //      keyboardType: TextInputType.number,
      //      inputFormatters: [
      //        FilteringTextInputFormatter.allow(
      //          RegExp(r'^\d*\.?\d*$'), // Разрешает только цифры и одну точку
      //        ),],
      //      decoration: const InputDecoration(labelText: ' Height Box Right'),
      //      onChanged: (value) {
      //        settingsBox.updateHeightBox(double.parse(value));
      //      },
      //    ),
      //    TextField(
      //      controller: _wightBoxRight,
      //      keyboardType: TextInputType.number,
      //      inputFormatters: [
      //        FilteringTextInputFormatter.allow(
      //          RegExp(r'^\d*\.?\d*$'), // Разрешает только цифры и одну точку
      //        ),],
      //      decoration: const InputDecoration(labelText: 'Width Box Right'),
      //      onChanged: (value) {
      //        settingsBox.updateWightBox(double.parse(value));
      //      },
      //    ),
      //
      //    Row(
      //      children: [
      //        DropdownButton<String>(
      //          value: settingsBox.styleBoxRight,
      //          onChanged: (String? newValue) {
      //            setState(() {
      //              _selectedFont = newValue!;
      //              settingsBox.updateStyleBoxRight(newValue);
      //            });
      //          },
      //          items: _fonts.map<DropdownMenuItem<String>>((String value) {
      //            return DropdownMenuItem<String>(
      //              value: value,
      //              child: Text(value, style: GoogleFonts.getFont(value)),
      //            );
      //          }).toList(),
      //        ),
      //      ],
      //    ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ElevatedButton(
              onPressed: () {
                _openColorPicker(context, colorRightBox, HexColor(settingsBox.backgroundBoxColorRight), (color) {
                  setState(() {
                    settingsBox.updateBackgroundBoxColor(colorToHex(color));
                  });
                });
              },
              child: const Text('Background Box Color'),
            ),
          ),
      //    Padding(
      //      padding: const EdgeInsets.only(top: 8.0),
      //      child: ElevatedButton(
      //        onPressed: () {
      //          _openColorPicker(context, settingsBox.boxBorderColorRight, (color) {
      //            setState(() {
      //              settingsBox.updateBackgroundBoxBorderColor(color);
      //            });
      //          });
      //        },
      //        child: const Text('Box Border Color'),
      //      ),
      //    ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 5),
            child: ElevatedButton(
              onPressed: () {
                _openColorPicker(context, colorTextBoxRight ,HexColor(settingsBox.textBoxColorRight), (color) {
                  setState(() {
                    settingsBox.updateTextBoxColor(colorToHex(color));
                  });
                });
              },
              child: const Text('Text Box Color'),
            ),
          ),
      //    Padding(
      //      padding: const EdgeInsets.only(top: 8.0, bottom: 5.0),
      //      child: ElevatedButton(
      //        onPressed: () {
      //          settingsBoxLeft.updateFromRight(settingsBox);
      //        },
      //        child: const Text('Update to left'),
      //      ),
      //    ),
        ],
      ),
    );
  }
}

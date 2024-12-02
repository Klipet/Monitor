import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:monitor_for_sales/broker/color_app.dart';
import 'package:monitor_for_sales/providers/screen_setting_left.dart';
import 'package:provider/provider.dart';

import '../../providers/screen_setting_right.dart';


class SettingColumnRightOld extends StatefulWidget {
  const SettingColumnRightOld({super.key});

  @override
  State<SettingColumnRightOld> createState() => _SettingColumnRightOldState();
}

class _SettingColumnRightOldState extends State<SettingColumnRightOld> {
  TextEditingController _rightTextController = TextEditingController();
  TextEditingController _rightSizeController = TextEditingController();
  TextEditingController _rightSizeBorder = TextEditingController();
  TextEditingController _colorPickerController = TextEditingController();

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
        final settingsRight =
            Provider.of<ScreenSettingsRight>(context, listen: false);
        setState(() {
          _rightTextController.text = settingsRight.textRightTitle;
          _rightSizeController.text = settingsRight.rightSizeText.toString();
          _rightSizeBorder.text = settingsRight.rightSizeBorder.toString();
        });
      }
    });
  }
  @override
  void dispose() {
    _rightTextController.dispose();
    _rightSizeController.dispose();
    _rightSizeBorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingsRight = Provider.of<ScreenSettingsRight>(context);
    final settingsLeft = Provider.of<ScreenSettingsLeft>(context);
    return Column(
      children: [
    //    TextField(
    //      controller: _rightSizeController,
    //      keyboardType: TextInputType.number,
    //      inputFormatters: [
    //        FilteringTextInputFormatter.allow(
    //          RegExp(r'^\d*\.?\d*$'), // Разрешает только цифры и одну точку
    //        ),
    //      ],
    //      decoration: const InputDecoration(labelText: 'Enter size Right text'),
    //      onChanged: (value) {
    //        settingsRight.updateRightSizeText(double.parse(value));
    //      },
    //    ),
    //    TextField(
    //      controller: _rightSizeBorder,
    //      keyboardType: TextInputType.number,
    //      inputFormatters: [
    //        FilteringTextInputFormatter.allow(
    //          RegExp(r'^\d*\.?\d*$'), // Разрешает только цифры и одну точку
    //        ),
    //      ],
    //      decoration: const InputDecoration(labelText: 'Enter size Right Border'),
    //      onChanged: (value) {
    //        settingsRight.updateRightSizeBorder(double.parse(value));
    //      },
    //    ),
        TextField(
          controller: _rightTextController,
          decoration:
              const InputDecoration(labelText: 'Enter right column text'),
          onChanged: (value) {
            settingsRight.updateRightTitle(value);
          },
        ),
        Row(
          children: [
           Padding(
             padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, top: 8.0),
             child: GestureDetector(
               child:  Icon(Icons.border_bottom,
                 size: 50,
                 color: settingsRight.borderIsActiveBottomRight ? Colors.black : Colors.grey ,
               ),
               onTap: (){
                 setState(() {
                   settingsRight.updateBorderIsActiveBottomRight(!settingsRight.borderIsActiveBottomRight);
                 });
               },),
           ),
           Padding(
             padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, top: 8.0),
             child: GestureDetector(child: Icon(Icons.border_top,
               size: 50,
               color:  settingsRight.borderIsActiveTopRight ? Colors.black : Colors.grey ,),
               onTap: (){
                 setState(() {
                   settingsRight.updateBorderIsActiveTopRight(!settingsRight.borderIsActiveTopRight);
                 });
               },),
           ),
           Padding(
             padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, top: 8.0),
             child: GestureDetector(child: Icon(Icons.border_left,
               size: 50,
               color:  settingsRight.borderIsActiveLeftRight ? Colors.black : Colors.grey ,),
               onTap: (){
                 setState(() {
                   settingsRight.updateBorderIsActiveLeftRight(!settingsRight.borderIsActiveLeftRight);
                 });
               },),
           ),
           Padding(
             padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, top: 8.0),
             child: GestureDetector(child: Icon(Icons.border_right,
               size: 50,
               color:  settingsRight.borderIsActiveRightRight ? Colors.black : Colors.grey ,),
               onTap: (){
                 setState(() {
                   settingsRight.updateBorderIsActiveRightRight(!settingsRight.borderIsActiveRightRight);
                 });
               },),
           ),
            GestureDetector(
              onTap: () {
                setState(() {
                  settingsRight.updateBorderRight(!settingsRight.borderRight);
                });
              },
              child: Icon(
                settingsRight.borderRight ? Icons.check_box : Icons.check_box_outline_blank,
                size: 35.0,
                color: settingsRight.borderRight ? Colors.green : Colors.black,
              ),
            ),
            const SizedBox(width: 10),
            Text(settingsRight.borderRight? 'Border is activate' : 'Border is dezactivate',
              style: const TextStyle(
                  fontSize: 20
              ),
            ),
          ],
        ),
        Row(
          children: [
            DropdownButton<String>(
              value: settingsRight.styleColumnRight,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedFont = newValue!;
                  settingsRight.updateStyleColumnRight(newValue);
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
              _openColorPicker(context, colorRight ,HexColor(settingsRight.rightColumnColor),
                  (color) {
                setState(() {
                  settingsRight.updateRightColumnColor(colorToHex(color));
                });
              });
            },
            child: const Text('Change Right Column Color'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 5),
          child: ElevatedButton(
            onPressed: () {
              _openColorPicker(context, colorTitleRightBox , HexColor(settingsRight.rightColorText), (color) {
                setState(() {
                  settingsRight.updateRightTitleBoxColor(colorToHex(color));
                });
              });
            },
            child: const Text('Change Right Title Color'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 5),
          child: ElevatedButton(
            onPressed: () {
              _openColorPicker(context, colorTextTitleRight , HexColor(settingsRight.rightColorText), (color) {
                setState(() {
                  settingsRight.updateRightColorText(colorToHex(color));
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
              _openColorPicker(context, boxBorderColor,HexColor(settingsRight.rightColorBorder), (color) {
                setState(() {
                  settingsRight.updateRightColorBorder(colorToHex(color));
                });
              });
            },
            child: const Text('Change Right Column Border Color'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 5.0),
          child: ElevatedButton(
            onPressed: () {
              settingsLeft.updateFromRight(settingsRight);
            },
            child: const Text('Update to left'),
          ),
        ),
      ],
    );
  }
}

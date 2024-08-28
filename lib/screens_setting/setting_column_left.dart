import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monitor_for_sales/providers/screen_setting_right.dart';
import 'package:provider/provider.dart';
import '../providers/screen_setting_left.dart';


class SettingColumnLeft extends StatefulWidget {
  const SettingColumnLeft({super.key});

  @override
  State<SettingColumnLeft> createState() => _SettingColumnLeft();
}


class _SettingColumnLeft extends State<SettingColumnLeft> {
  TextEditingController _leftTextController = TextEditingController();
  TextEditingController _leftSizeController = TextEditingController();
  TextEditingController _leftSizeBorder = TextEditingController();



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
        final settingsLeft = Provider.of<ScreenSettingsLeft>(context, listen: false);
        setState(() {
          _leftTextController.text = settingsLeft.textLeftTitle;
          _leftSizeController.text = settingsLeft.leftSizeText.toString();
          _leftSizeBorder.text = settingsLeft.leftSizeBorder.toString();
        });
      }
    });
  }
  void dispose() {
    _leftTextController.dispose();
    _leftSizeBorder.dispose();
    _leftSizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingsLeft = Provider.of<ScreenSettingsLeft>(context);
    final settingsRight = Provider.of<ScreenSettingsRight>(context);

    return Column(
      children: [
            TextField(
              controller: _leftSizeController,
              keyboardType: TextInputType.number,
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
          controller: _leftSizeBorder,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'^\d*\.?\d*$'), // Разрешает только цифры и одну точку
            ),],
          decoration: const InputDecoration(labelText: 'Enter size Left Border'),
          onChanged: (value) {
            settingsLeft.updateLeftSizeBorder(double.parse(value));
              },
            ),
            TextField(
              controller: _leftTextController,
              decoration: const InputDecoration(labelText: 'Enter left column text'),
              onChanged: (value) {
                settingsLeft.updateLeftTitle(value);
              },
            ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, top: 8.0),
              child: GestureDetector(
                child:  Icon(Icons.border_bottom,
                size: 50,
                color: settingsLeft.borderIsActiveBottomLeft ? Colors.black : Colors.grey ,
                  ),
              onTap: (){
                setState(() {
                  settingsLeft.updateBorderIsActiveBottomLeft(!settingsLeft.borderIsActiveBottomLeft);
                });
              },),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, top: 8.0),
              child: GestureDetector(child: Icon(Icons.border_top,
                size: 50,
                color:  settingsLeft.borderIsActiveTopLeft ? Colors.black : Colors.grey ,),
                onTap: (){
                  setState(() {
                    settingsLeft.updateBorderIsActiveTopLeft(!settingsLeft.borderIsActiveTopLeft);
                  });
                },),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, top: 8.0),
              child: GestureDetector(child: Icon(Icons.border_left,
                size: 50,
                color:  settingsLeft.borderIsActiveLeftLeft ? Colors.black : Colors.grey ,),
                onTap: (){
                  setState(() {
                    settingsLeft.updateBorderIsActiveLeftLeft(!settingsLeft.borderIsActiveLeftLeft);
                  });
                },),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, top: 8.0),
              child: GestureDetector(child: Icon(Icons.border_right,
                size: 50,
                color:  settingsLeft.borderIsActiveRightLeft ? Colors.black : Colors.grey ,),
                onTap: (){
                  setState(() {
                    settingsLeft.updateBorderIsActiveRightLeft(!settingsLeft.borderIsActiveRightLeft);
                  });
                },),
            ),
        //    Padding(
        //      padding: const EdgeInsets.all(8.0),
        //      child: GestureDetector(
        //        onTap: () {
        //          setState(() {
        //            settingsLeft.updateBorderLeft(!settingsLeft.borderLeft);
        //          });
        //        },
        //        child: Icon(
        //          settingsLeft.borderLeft ? Icons.check_box : Icons.check_box_outline_blank,
        //          size: 35.0,
        //          color: settingsLeft.borderLeft ? Colors.green : Colors.black,
        //        ),
        //      ),
        //    ),
        //    const SizedBox(width: 10),
        //    Text(settingsLeft.borderLeft? 'Border is activate' : 'Border is dezactivate',
        //      style: const TextStyle(
        //        fontSize: 20
        //      ),
        //    ),
          ],
        ),
        Row(
          children: [
            DropdownButton<String>(
              value: settingsLeft.styleColumnLeft,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedFont = newValue!;
                  settingsLeft.updateStyleColumnLeft(newValue);
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
                  _openColorPicker(context, settingsLeft.leftColumnColor,
                          (color) {
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
            ),Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  _openColorPicker(context, settingsLeft.leftColorBorder, (color) {
                    setState(() {
                      settingsLeft.updateLeftColorBorder(color);
                    });
                  });
                },
                child: const Text('Change Left Column Border Color'),
              ),
            ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 5.0),
          child: ElevatedButton(
            onPressed: () {
              settingsRight.updateFromLeft(settingsLeft);
            },
            child: const Text('Update to left'),
          ),
        ),
          ],
    );
  }
}
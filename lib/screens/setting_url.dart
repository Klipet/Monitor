import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DialogSetting extends StatefulWidget {
  const DialogSetting({super.key});

  @override
  _DialogSettingState createState() => _DialogSettingState();
}

class _DialogSettingState extends State<DialogSetting> {
  bool connectStatus = false;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
        title: const Text('Укажите линк сервера'),
        content: SizedBox(
            width: 500,
            height: 100,
            child: Column(mainAxisAlignment: MainAxisAlignment.start,
                children: [
              Row(
                children: [
                  Icon(
                    Icons.check,
                    size: 50,
                    color: !connectStatus ? Colors.red : Colors.green,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.0),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        hintText: 'http://192.168.0.0:5959',
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        String url = controller.text;
                      },
                      style: ButtonStyle(
                        alignment: Alignment.center,
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        fixedSize:
                            MaterialStateProperty.all(const Size(200, 25)),
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.green;
                            }
                            return Colors.green;
                          },
                        ),
                      ),
                      child: const Text('Check url'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        alignment: Alignment.center,
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        fixedSize:
                            MaterialStateProperty.all(const Size(200, 25)),
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.red;
                            }
                            return Colors.red;
                          },
                        ),
                      ),
                      child: const Text('Exit'),
                    ),
                  ],
                ),
              )
            ])));
  }

  Future<void> checkUrl(String url) async {
    var client = http.Client();
    try {
      var response = await client.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        setState(() {
          connectStatus = true;
        });
      } else {
        setState(() {
          connectStatus = false;
        });
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        connectStatus = false;
      });
      print('Error: $e');
    } finally {
      client.close();
    }
  }
}

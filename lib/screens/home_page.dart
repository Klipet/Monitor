import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:monitor_for_sales/factory/Order.dart';
import 'package:monitor_for_sales/providers/screen_setting_box.dart';
import 'package:monitor_for_sales/providers/screen_setting_header.dart';
import 'package:monitor_for_sales/providers/screen_setting_right.dart';
import 'package:monitor_for_sales/screens/setting_ui.dart';
import 'package:monitor_for_sales/screens/setting_url.dart';
import 'package:monitor_for_sales/screens/settings_home_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/screen_setting_left.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FocusNode _focusNode;
  late List<dynamic> commandState;
  late List<Order> ordersList;
  late List<dynamic> ordersListRight;
  late List<dynamic> ordersListLeft;
  late Timer _timer;
  bool ordersLeft = false;
  bool ordersRight = false;
  late bool _isFetching; // Добавленный флаг для отслеживания состояния выполнения

  @override
  void initState() {
    _isFetching = false;
    super.initState();
    commandState = [];
    ordersListRight = [];
    ordersListLeft = [];
    ordersList = [];
    _focusNode = FocusNode();
    // Ensure focus is set on startup
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
    _startTimer();
    getState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (!_isFetching) {
        // Проверяем, выполняется ли уже метод getState
        getState();
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var settingsLeft = Provider.of<ScreenSettingsLeft>(context);
    var settingsRight = Provider.of<ScreenSettingsRight>(context);
    var settingsHeader = Provider.of<ScreenSettingsHeader>(context);
    var settingsBox = Provider.of<ScreenSettingsBox>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: settingsHeader.backgroundColor,
        centerTitle: true,
        title:  Text(settingsHeader.textTitle),
        automaticallyImplyLeading: false, // Hide back button on AppBar
      ),
      body: KeyboardListener(
        autofocus: true,
        focusNode: _focusNode,
        onKeyEvent: (event) {
          if (event is KeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.escape) {
              print('Escape pressed');
              // Close the application
              if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
                exit(0);
              }
            }
            if (event.logicalKey == LogicalKeyboardKey.f10) {
              print('F10 pressed');
              // Open settings dialog
              _showSettingsDialog(context);
            }
          }
        },
        child:  Row(
          children: [
            //LEFT
            Expanded(
               child: Container(
                 decoration: BoxDecoration(
                   color: settingsLeft.leftColumnColor
                 ),
                 child: Column(
                    children: [
                      Text(settingsLeft.textLeftTitle.toString(),
                        style: TextStyle(
                            fontSize: settingsLeft.leftSizeText
                        ),
                      ),
                      Expanded(
                        child: ordersListLeft.isNotEmpty
                            ? SingleChildScrollView(
                          child: Wrap(
                            children: List.generate(ordersListLeft.length, (index) {
                              dynamic order = ordersListLeft[index];
                              return Container(
                                margin: EdgeInsets.all(4.0),
                                child: Container(
                                  alignment: Alignment.center,
                                    width: settingsBox.sizeBox,
                                    height: settingsBox.sizeBox,

                                    decoration: BoxDecoration(
                                      color: settingsBox.backgroundBoxColor,
                                      border: Border.all(
                                          width: settingsBox.sizeBorder
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(settingsBox.radiusBox))
                                    ),
                                    child: Text(
                                        order.toString(),
                                      style: TextStyle(
                                        color: settingsBox.textBoxColor
                                      ),
                                    )
                                ), // Вывод текущего элемента
                              );
                            }),
                          ),
                        )
                            :  Center(
                          child: Text('No orders available',
                            style: TextStyle(
                              fontSize: settingsLeft.leftSizeText,
                            ),
                          ),
                        ),
                      ),
                    ],
                 ),
               )
            ),
            //RIGHT
            Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: settingsRight.rightColumnColor
                  ),
                  child: Column(
                    children: [
                      Text(settingsRight.textRightTitle.toString(), 
                        style: TextStyle(
                            fontSize: settingsRight.rightSizeText
                        ),
                      ),
                      Expanded(
                        child: ordersListRight.isNotEmpty
                            ? SingleChildScrollView(
                          child: Wrap(
                            children: List.generate(ordersListRight.length, (index) {
                              dynamic order = ordersListRight[index];
                              return Container(
                                margin: EdgeInsets.all(4.0),
                                child: Container(
                                  width: settingsBox.sizeBox,
                                  height: settingsBox.sizeBox,
                                  decoration: BoxDecoration(
                                    color: settingsBox.backgroundBoxColor,
                                    border: Border.all(
                                        width: settingsBox.sizeBorder
                                    ),
                                  ),
                                    child: Text(order.toString())), // Вывод текущего элемента
                              );
                            }),
                          ),
                        )
                            : Center(
                          child: Text('No orders available',
                            style: TextStyle(
                              fontSize: settingsRight.rightSizeText,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Настройки'),
          content: const SettingsDialogContent(),
          actions: <Widget>[
            TextButton(
              child: Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Сохранить'),
              onPressed: () {
                // Добавьте код для сохранения настроек
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> getState() async {
    if (_isFetching) return; // Если метод уже выполняется, выходим

    _isFetching = true; // Устанавливаем флаг в true перед выполнением

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = prefs.getString('url');

    if (url == '' || url == null) {
      _stopTimer(); // Останавливаем таймер при открытии окна настройки
      await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const DialogSetting()),
      );
      _startTimer(); // Перезапускаем таймер после закрытия окна настройки
    } else {
      var client = http.Client();
      try {
        var response = await client.get(
          Uri.parse(url + '/json/GetCurrentOrderLines'),
        );
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          setState(() {
            commandState = responseData['OrdersList'];
            ordersList = commandState.map((orderData) => Order.fromJson(orderData)).toList();
            statusState();
          });
        } else {
          _stopTimer(); // Останавливаем таймер при открытии окна настройки
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const DialogSetting()),
          );
          _startTimer(); // Перезапускаем таймер после закрытия окна настройки
        }
      } catch (e) {
        _stopTimer(); // Останавливаем таймер при открытии окна настройки
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const DialogSetting()),
        );
        _startTimer(); // Перезапускаем таймер после закрытия окна настройки
      } finally {
        client.close();
      }
    }
    _isFetching = false; // Устанавливаем флаг в false после выполнения
  }
  void statusState() {

      for (var status in ordersList) {

        //print('Order: ${status.number}, State: ${status.state}'); // Вывод состояния заказа
        if (status.state == 2) {
          // Проверяем, если значение уже существует в ordersListLeft
          if (!ordersListLeft.contains(status.number)) {
            ordersListLeft.add(status.number);
            setState(() {});
          }
        } else if (status.state == 1) {
          // Проверяем, если значение уже существует в ordersListRight
          if (!ordersListRight.contains(status.number)) {
            ordersListRight.add(status.number);
            setState(() {});
          }
        }
      }
      ordersLeft = ordersListLeft.isEmpty;
      ordersRight = ordersListRight.isEmpty;
    //  print("Orders List Left: $ordersListLeft"); // Debug: print left orders list
    //  print("Orders List Right: $ordersListRight"); // Debug: print right orders list

  }

}



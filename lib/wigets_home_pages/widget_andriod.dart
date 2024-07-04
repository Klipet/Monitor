import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../factory/Order.dart';
import '../providers/screen_setting_box_left.dart';
import '../providers/screen_setting_box_right.dart';
import '../providers/screen_setting_header.dart';
import '../providers/screen_setting_left.dart';
import '../providers/screen_setting_right.dart';
import '../screens/setting_url.dart';
import '../screens/settings_home_page.dart';

class HomePagesAndroid extends StatefulWidget {
  const HomePagesAndroid({super.key});

  @override
  State<HomePagesAndroid> createState() => _HomePagesAndroidState();
}

class _HomePagesAndroidState extends State<HomePagesAndroid> {
  late FocusNode _focusNode;
  late List<dynamic> commandState;
  late List<Order> ordersList;
  late List<dynamic> ordersListRight;
  late List<dynamic> ordersListLeft;
  late Timer _timer;
  bool ordersLeft = false;
  bool ordersRight = false;
  bool _isFetching = false;
  bool _showSettings = false;
  late bool _statusConect;

  @override
  void initState() {
    _statusConect = false;
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
    getStateAndroid();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      getStateAndroid();
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
    var settingsBoxLeft = Provider.of<ScreenSettingsBoxLeft>(context);
    var settingsBoxRight = Provider.of<ScreenSettingsBoxRight>(context);
    return Scaffold(
        appBar: settingsHeader.textTitle.isEmpty
            ? null
            : AppBar(
                backgroundColor: settingsHeader.backgroundColor,
                centerTitle: true,
                toolbarHeight: settingsHeader.sizeToolBar,
                title: Text(settingsHeader.textTitle,
                    style: GoogleFonts.getFont(
                        settingsHeader.styleTitle,
                        fontSize: settingsHeader.sizeText,
                        color: settingsHeader.textColor)
                    //  TextStyle(
                    //      fontSize: settingsHeader.sizeText,
                    //      color: settingsHeader.textColor
                    //  ),
                    ),
                automaticallyImplyLeading: false, // Hide back button on AppBar
              ),
        body: GestureDetector(
            onDoubleTap: () {
              setState(() {
                _showSettings = !_showSettings;
                _showSettingsDialog(
                    context); // Переключаем состояние отображения настроек
              });
            },
            onTap: () {
              setState(() {
                _showSettings = !_showSettings;
                _stopTimer(); // Останавливаем таймер при открытии окна настройки
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const DialogSetting()),
                );
              });
            },
            child: !_isFetching
                ? Center(
                    child: Image.asset(
                      'assets/images/error_connect.jpg',
                      fit: BoxFit.fill,
                      alignment: Alignment.center,
                    ),
                  )
                : Row(
                    children: [
                      //LEFT
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            color: settingsLeft.leftColumnColor,
                            border: Border.all(
                              color: settingsLeft.leftColorBorder,
                              width: settingsLeft.leftSizeBorder,
                            )),
                        child: Column(
                          children: [
                            Text(
                              settingsLeft.textLeftTitle.toString(),
                              style: GoogleFonts.getFont(
                                fontSize: settingsLeft.leftSizeText,
                                  settingsLeft.styleColumnLeft,
                                  color: settingsLeft.leftColorText
                              ),
                            ),
                            Expanded(
                              child: ordersListLeft.isNotEmpty
                                  ? SingleChildScrollView(
                                      child: Consumer<ScreenSettingsBoxLeft>(
                                        builder: (context, settingsBox, child) {
                                          // Сортируем список перед отображением
                                          ordersListLeft
                                              .sort((a, b) => a.compareTo(b));
                                          return Wrap(
                                            children: List.generate(
                                                ordersListLeft.length, (index) {
                                              dynamic order =
                                                  ordersListLeft[index];
                                              return Container(margin: EdgeInsets.all(4.0),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width:
                                                      settingsBox.sizeBoxLeft,
                                                  height:
                                                      settingsBox.sizeBoxLeft,
                                                  decoration: BoxDecoration(
                                                    color: settingsBoxLeft
                                                        .backgroundBoxColorLeft,
                                                    border: Border.all(
                                                      width: settingsBoxLeft
                                                          .sizeBorderLeft,
                                                      color: settingsBoxLeft
                                                          .boxBorderColorLeft,
                                                    ),
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(
                                                          settingsBoxLeft
                                                              .radiusBoxLeft),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    order.toString(),
                                                    style: GoogleFonts.getFont(
                                                      settingsBoxLeft.styleBoxLeft,
                                                        color: settingsBoxLeft.textBoxColorLeft,
                                                        fontSize: settingsBoxLeft.sizeTextLeft),
                                                  ),
                                                ), // Вывод текущего элемента
                                              );
                                            }),
                                          );
                                        },
                                      ),
                                    )
                                  : const Center(
                                      child: Text("No orders available")),
                            )
                          ],
                        ),
                      )),
                      //RIGHT
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            color: settingsRight.rightColumnColor,
                            border: Border.all(
                              color: settingsRight.rightColorBorder,
                              width: settingsRight.rightSizeBorder,
                            )),
                        child: Column(
                          children: [
                            Text(
                              settingsRight.textRightTitle.toString(),
                              style: GoogleFonts.getFont(
                                  settingsRight.styleColumnRight,
                                  color: settingsRight.rightColorText,
                                  fontSize: settingsRight.rightSizeText),
                            ),
                            Expanded(
                              child: ordersListRight.isNotEmpty
                                  ? SingleChildScrollView(
                                      child: Wrap(
                                        children: List.generate(
                                            ordersListRight.length, (index) {
                                          dynamic order =
                                              ordersListRight[index];
                                          return Container(
                                              margin: const EdgeInsets.all(4.0),
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: settingsBoxRight
                                                    .sizeBoxRight,
                                                height: settingsBoxRight
                                                    .sizeBoxRight,
                                                decoration: BoxDecoration(
                                                  color: settingsBoxRight
                                                      .backgroundBoxColorRight,
                                                  border: Border.all(
                                                      width: settingsBoxRight
                                                          .sizeBorderRight,
                                                      color: settingsBoxRight
                                                          .boxBorderColorRight),
                                                ),
                                                child: Text(
                                                  order.toString(),
                                                  style: GoogleFonts.getFont(
                                                      settingsBoxRight.styleBoxRight,
                                                      color: settingsBoxRight.textBoxColorRight,
                                                      fontSize: settingsBoxRight.sizeTextRight),
                                                ),
                                              ) // Вывод текущего элемента
                                              );
                                        }),
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        'No orders available',
                                        style: TextStyle(
                                          fontSize: settingsRight.rightSizeText,
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ))
                    ],
                  )));
  }

  void _showSettingsDialog(BuildContext context) {
    if (_showSettings) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Настройки'),
            content: const SettingsDialogContent(),
            actions: <Widget>[
              TextButton(
                child: const Text('Отмена'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Сохранить'),
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
  }

  Future<void> getStateAndroid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = prefs.getString('url');

    if (url == '' || url == null) {
      _stopTimer(); // Останавливаем таймер при открытии окна настройки
      //  _startTimer(); // Перезапускаем таймер после закрытия окна настройки
    } else {
      var client = http.Client();
      try {
        var response = await client.get(
          Uri.parse(url + '/json/GetOrdersList?hours=24'),
        );
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          setState(() {
            commandState = responseData['OrdersList'];
            ordersList = commandState
                .map((orderData) => Order.fromJson(orderData))
                .toList();
            statusState();
            _isFetching = true;
          });
        } else {
          setState(() {
            _isFetching = false;
          });
        }
      } catch (e) {
        setState(() {
          _isFetching = false;
        });
      } finally {
        client.close();
      }
    }
  }

  void statusState() {
    // Создаем копии текущих списков для отслеживания изменений
    List<int> currentOrdersListLeft = List.from(ordersListLeft);
    List<int> currentOrdersListRight = List.from(ordersListRight);

    for (var status in ordersList) {
      if (status.state == 2) {
        if (!currentOrdersListLeft.contains(status.number)) {
          ordersListLeft.add(status.number);
        }
        // Удаляем из правого списка, если статус изменился
        ordersListRight.remove(status.number);
      } else if (status.state == 6) {
        if (!currentOrdersListRight.contains(status.number)) {
          //  playTransitionSound();
          ordersListRight.add(status.number);
        }
        // Удаляем из левого списка, если статус изменился
        ordersListLeft.remove(status.number);
      } else if (status.state == 4) {
        if (currentOrdersListRight.contains(status.number)) {
          ordersListRight.remove(status.number);
          print("Removed ${status.number} from ordersListRight");
        }
        // Также проверяем и удаляем из левого списка, если статус изменился
        ordersListLeft.remove(status.number);
      }
    }
    // Удаляем из списков элементы, статусы которых изменились
    ordersListLeft = ordersListLeft.where((number) {
      return ordersList
          .any((order) => order.number == number && order.state == 2);
    }).toList();

    ordersListRight = ordersListRight.where((number) {
      return ordersList
          .any((order) => order.number == number && order.state == 6);
    }).toList();

    ordersLeft = ordersListLeft.isEmpty;
    ordersRight = ordersListRight.isEmpty;

    setState(() {});
  }
}

import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:simple_animations/animation_builder/custom_animation_builder.dart';
import 'package:sound_library/sound_library.dart';
import '../animation/animated_left.dart';
import '../animation/animated_order_container .dart';
import '../animation/default_animation.dart';
import '../animation/order_screen.dart';
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
  late bool _isFetching;
  bool _showSettings = false;
  late bool _statusConect;
  Control control = Control.play;

  @override
  void initState() {
    _isFetching = false;
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
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      getStateAndroid();
    });
  }

  void _stopTimer() {
    _timer.cancel();
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
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Text(settingsHeader.textTitle,
                      style: GoogleFonts.getFont(settingsHeader.styleTitle,
                          fontSize: settingsHeader.sizeText,
                          color: settingsHeader.textColor)
                      //  TextStyle(
                      //      fontSize: settingsHeader.sizeText,
                      //      color: settingsHeader.textColor
                      //  ),
                      ),
                ),
                automaticallyImplyLeading: false, // Hide back button on AppBar
              ),
        body: Stack(children: [
          _animation(context),
          !_isFetching
              ? Stack(
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black12.withOpacity(0.2),
                      // Полупрозрачный цвет
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 50.0),
                                child: Lottie.asset(
                                  'assets/errorWifi.json',
                                  width: 200,
                                  height: 200,
                                  reverse: true,
                                  fit: BoxFit.fill,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )
              : Container(),
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
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
                    MaterialPageRoute(
                        builder: (context) => const DialogSetting()),
                  );
                });
              },
              child: Container(
                width: 150, // Укажите ширину
                height: 150, // Укажите высоту
                color: Colors.transparent,
              ),
            ),
          ),
        ]));
  }

  Widget _animation(BuildContext) {
    var settingsLeft = Provider.of<ScreenSettingsLeft>(context);
    var settingsRight = Provider.of<ScreenSettingsRight>(context);
    var settingsHeader = Provider.of<ScreenSettingsHeader>(context);
    var settingsBoxLeft = Provider.of<ScreenSettingsBoxLeft>(context);
    var settingsBoxRight = Provider.of<ScreenSettingsBoxRight>(context);
    if (settingsHeader.animatie == "Default") {
      return DefaultAnimation(
          ordersListLeft: ordersListLeft,
          ordersListRight: ordersListRight,
          settingsLeft: settingsLeft,
          settingsRight: settingsRight,
          settingsBoxLeft: settingsBoxLeft,
          settingsBoxRight: settingsBoxRight);
    } else if (settingsHeader.animatie == "Top Dawn") {
      return OrderScreen(
        ordersListLeft: ordersListLeft,
        ordersListRight: ordersListRight,
        settingsLeft: settingsLeft,
        settingsRight: settingsRight,
        settingsBoxLeft: settingsBoxLeft,
        settingsBoxRight: settingsBoxRight,
        control: AnimatedOrderContainer(
          sizeBox: settingsBoxRight.sizeBoxRight,
          sizeBorder: settingsBoxRight.sizeBorderRight,
          boxBorderColor: settingsBoxRight.boxBorderColorRight,
          backgroundColor: settingsBoxRight.textBoxColorRight,
          textColor: settingsBoxRight.textBoxColorRight,
          textSize: settingsBoxRight.sizeTextRight,
          font: settingsBoxRight.styleBoxRight,
          order: null,
        ),
      );
    } else if (settingsHeader.animatie == "Left Right") {
      return AnimatedLeft(
        ordersListLeft: ordersListLeft,
        ordersListRight: ordersListRight,
        settingsLeft: settingsLeft,
        settingsRight: settingsRight,
        settingsBoxLeft: settingsBoxLeft,
        settingsBoxRight: settingsBoxRight,
        control: control,
      );
    }
    return Container();
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
            //  Fluttertoast.showToast(
            //    msg: response.toString(),
            //    toastLength: Toast.LENGTH_SHORT,
            //    gravity: ToastGravity.BOTTOM,
            //    backgroundColor: Colors.white,
            //    textColor: Colors.black,
            //    fontSize: 16.0,
            //  );
          });
        } else {
          setState(() {
            _isFetching = false;
            //    Fluttertoast.showToast(
            //      msg: response.toString(),
            //      toastLength: Toast.LENGTH_SHORT,
            //      gravity: ToastGravity.BOTTOM,
            //      backgroundColor: Colors.white,
            //      textColor: Colors.black,
            //      fontSize: 16.0,
            //    );
          });
        }
      } catch (e) {
        setState(() {
          _isFetching = false;
          //    Fluttertoast.showToast(
          //      msg: e.toString(),
          //      toastLength: Toast.LENGTH_SHORT,
          //      gravity: ToastGravity.BOTTOM,
          //      backgroundColor: Colors.white,
          //      textColor: Colors.black,
          //      fontSize: 16.0,
          //    );
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
          _playSound();
          ordersListRight.add(status.number);
        }
        // Удаляем из левого списка, если статус изменился
        ordersListLeft.remove(status.number);
      } else if (status.state == 4) {
        if (currentOrdersListRight.contains(status.number)) {
          ordersListRight.remove(status.number);
          if (kDebugMode) {
            print("Removed ${status.number} from ordersListRight");
          }
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

  void _playSound() {
    var settingsHeader =
        Provider.of<ScreenSettingsHeader>(context, listen: false);
    if (settingsHeader.soundActive == true) {
      Sounds? sound = settingsHeader.sounds;
      SoundPlayer.play(sound!,
          volume: 3, position: const Duration(microseconds: 500));
    } else {
      null;
    }
  }
}

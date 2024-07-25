import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:monitor_for_sales/animation/animated_left.dart';
import 'package:monitor_for_sales/animation/animated_order_container%20.dart';
import 'package:monitor_for_sales/animation/default_animation.dart';
import 'package:monitor_for_sales/factory/Order.dart';
import 'package:monitor_for_sales/providers/screen_setting_box_left.dart';
import 'package:monitor_for_sales/providers/screen_setting_box_right.dart';
import 'package:monitor_for_sales/providers/screen_setting_header.dart';
import 'package:monitor_for_sales/providers/screen_setting_right.dart';
import 'package:monitor_for_sales/screens/setting_url.dart';
import 'package:monitor_for_sales/screens/settings_home_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sound_library/sound_library.dart';
import 'package:synchronized_keyboard_listener/synchronized_keyboard_listener.dart';
import '../animation/order_screen.dart';
import '../providers/screen_setting_left.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_animations/simple_animations.dart';

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
  bool _isFetching = false; // Добавленный флаг для отслеживания состояния выполнения
  File? _image;
  Control control = Control.play;
  Map<int, double> opacityMap = {};
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    commandState = [];
    ordersListRight = [];
    ordersListLeft = [];
    ordersList = [];
    _focusNode = FocusNode();
    // Ensure focus is set on startup
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
      _notification();
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

  void _notification() {
    showSimpleNotification(
      const Text(
        "F10 - Setting \n"
        "ESC - Exit \n "
        "F9 - URL",
        style: TextStyle(color: Colors.black),
      ),
      background: Colors.white10.withOpacity(0.9),
      duration: const Duration(seconds: 3),
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      getState();
      print("запрос в службу ${_timer.tick}");
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    print("Stop Tomer Windows ");
  }

  void _toggleOpacity() {
    setState(() {
      _opacity = _opacity == 1.0 ? 0.0 : 1.0;
    });
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
                  child: Text(
                      textAlign: TextAlign.start,
                      settingsHeader.textTitle,
                      style: GoogleFonts.getFont(settingsHeader.styleTitle,
                          fontSize: settingsHeader.sizeText,
                          color: settingsHeader.textColor)),
                ),
                automaticallyImplyLeading: false, // Hide back button on AppBar
              ),
        body: Stack(
          children: [
            SynchronizedKeyboardListener(
                keyEvents: <LogicalKeyboardKey, Function()>{
                  LogicalKeyboardKey.escape: () {
                    _handleEscapeKey();
                  },
                  LogicalKeyboardKey.f10: () {
                    _handleF10Key();
                  },
                  LogicalKeyboardKey.f9: () {
                    _handleF9Key();
                  },
                  //  LogicalKeyboardKey.f8:(){ _handleF8Key();},
                },
                child: Stack(
                  children: [
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
                                          padding: const EdgeInsets.only(
                                              right: 50.0),
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
                  ],
                )
            )
          ],
        ));
  }
  Widget _animation(BuildContext){
    var settingsLeft = Provider.of<ScreenSettingsLeft>(context);
    var settingsRight = Provider.of<ScreenSettingsRight>(context);
    var settingsHeader = Provider.of<ScreenSettingsHeader>(context);
    var settingsBoxLeft = Provider.of<ScreenSettingsBoxLeft>(context);
    var settingsBoxRight = Provider.of<ScreenSettingsBoxRight>(context);
    if(settingsHeader.animatie == "Default"){
    return  DefaultAnimation(
          ordersListLeft: ordersListLeft,
          ordersListRight: ordersListRight,
          settingsLeft: settingsLeft,
          settingsRight: settingsRight,
          settingsBoxLeft: settingsBoxLeft,
          settingsBoxRight: settingsBoxRight);
    }else if (settingsHeader.animatie == "Top Dawn"){
    return  OrderScreen(
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
    }else if(settingsHeader.animatie == "Left Right"){
    return  AnimatedLeft(
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

  void _handleEscapeKey() {
    print('Escape pressed');
    // Закрыть приложение
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      exit(0);
    }
  }

  void _handleF10Key() {
    print('F10 pressed');
    // Открыть диалог настроек
    _showSettingsDialog(context);
  }

  void _handleF9Key() {
    print('F9 pressed');
    _stopTimer(); // Останавливаем таймер при открытии окна настройки
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const DialogSetting()),
    );
    _startTimer();
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
        var response =
            await client.get(Uri.parse(url + '/json/GetOrdersList?hours=24'));
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          setState(() {
            commandState = responseData['OrdersList'];
            ordersList = commandState
                .map((orderData) => Order.fromJson(orderData))
                .toList();
            statusState();
            setState(() {
              _isFetching = true;
            });
          });
        } else {
          setState(() {
            _isFetching = false;
          });
          //    _stopTimer(); // Останавливаем таймер при открытии окна настройки
          //    await Navigator.of(context).push(
          //      MaterialPageRoute(builder: (context) => const DialogSetting()),
          //    );
          //    _startTimer(); // Перезапускаем таймер после закрытия окна настройки
        }
      } catch (e) {
        setState(() {
          _isFetching = false;
        });
        //  _stopTimer(); // Останавливаем таймер при открытии окна настройки
        //  await Navigator.of(context).push(
        //    MaterialPageRoute(builder: (context) => const DialogSetting()),
        //  );
        //  _startTimer(); // Перезапускаем таймер после закрытия окна настройки
      } finally {
        // client.close();
      }
    }
    // _isFetching = false; // Устанавливаем флаг в false после выполнения
  }

  void statusState() {
    // Создаем копии текущих списков для отслеживания изменений
    List<int> currentOrdersListLeft = List.from(ordersListLeft);
    List<int> currentOrdersListRight = List.from(ordersListRight);
//    var settingsHeader = Provider.of<ScreenSettingsHeader>(context);

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
          _playSound();
        }
        // Удаляем из левого списка, если статус изменился
        ordersListLeft.remove(status.number);
      } else if (status.state == 4) {
        if (currentOrdersListRight.contains(status.number)) {
          ordersListRight.remove(status.number);
          updateOpacity();
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

    setState(() {
      // Обновление непрозрачности
      updateOpacity();
    });
  }

  void updateOpacity() {
    // Обновляем непрозрачность для новых элементов
    ordersListLeft.forEach((number) {
      if (!opacityMap.containsKey(number)) {
        opacityMap[number] = 1.0;
      }
    });

    // Убираем элементы, которых больше нет
    opacityMap.keys.toList().forEach((number) {
      if (!ordersListLeft.contains(number)) {
        opacityMap[number] = 0.0;
      }
    });
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

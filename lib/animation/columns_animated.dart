import 'dart:async';

import 'package:desktop/desktop.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../factory/Order.dart';
import '../orders.dart';
import '../providers/screen_setting_box_left.dart';
import '../providers/screen_setting_box_right.dart';
import '../providers/screen_setting_left.dart';
import '../providers/screen_setting_right.dart';

class ColumnsAnimated extends StatefulWidget {
  final List<dynamic> ordersListLeft;
  final List<dynamic> ordersListRight;
  final List<Order> ordersList;
  final ScreenSettingsLeft settingsLeft;
  final ScreenSettingsRight settingsRight;
  final ScreenSettingsBoxLeft settingsBoxLeft;
  final ScreenSettingsBoxRight settingsBoxRight;

  ColumnsAnimated({
    required this.ordersListLeft,
    required this.ordersListRight,
    required this.ordersList,
    required this.settingsLeft,
    required this.settingsRight,
    required this.settingsBoxLeft,
    required this.settingsBoxRight,
  });

  @override
  State<ColumnsAnimated> createState() => _ColumnsAnimatedState();
}

class _ColumnsAnimatedState extends State<ColumnsAnimated> {
  Timer? _timer;
  Map<String, int> ordersMap = {}; // Карта для хранения номера заказа и статуса

  @override
  void initState() {
    super.initState();
    _updateOrders();
    // Запускаем таймер для обновления данных каждые 5 секунд
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      print('запрос в службу из columa ${timer.tick}');
      _updateOrders();
    });
  }

  @override
  void dispose() {
    // Отменяем таймер при уничтожении виджета
    _timer?.cancel();
    super.dispose();
  }

  void _updateOrders() {
    setState(() {
      print('Обновление данных'); // Отладочное сообщение
      ordersMap = {};
      for (var order in widget.ordersList) {
    //    print('Order ID: ${order.number}, Status: ${order.state}'); // Проверка данных
        ordersMap[order.number.toString()] = order.state;
      }
    //  print('Текущее состояние ordersMap: $ordersMap');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double columnWidth = 200; // Ширина каждой колонки
            List<Widget> columns = [];
            for (int i = 0; i < ordersMap.length; i++) {
              String orderId = ordersMap.keys.elementAt(i);
              int status = ordersMap[orderId]!;
              Widget tile = Container(
                width: columnWidth,
                padding: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text('Order ID: $orderId'),
                  subtitle: Text(_getStatusText(status)),
                ),
              );

              // Определяем колонку для текущего элемента
              if (i % (constraints.maxWidth ~/ columnWidth) == 0) {
                columns.add(Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [tile],
                ));
              } else {
                // Добавляем элемент в последнюю колонку
                (columns.last as Column).children.add(tile);
              }
            }

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: columns,
              ),
            );
          },
        ),
      ),
    );
  }


  String _getStatusText(int status) {
    switch (status) {
      case 2:
        return 'В процессе';
      case 6:
        return 'Готов';
      case 4:
        return 'Выдан в зал';
      default:
        return 'Неизвестный статус';
    }
  }
}

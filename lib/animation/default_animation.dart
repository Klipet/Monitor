import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monitor_for_sales/providers/screen_setting_header.dart';
import 'package:provider/provider.dart';

import '../providers/screen_setting_box_left.dart';
import '../providers/screen_setting_box_right.dart';
import '../providers/screen_setting_left.dart';
import '../providers/screen_setting_right.dart';

class DefaultAnimation extends StatelessWidget {
  final List<dynamic> ordersListLeft;
  final List<dynamic> ordersListRight;
  final ScreenSettingsLeft settingsLeft;
  final ScreenSettingsHeader settingsHeader;
  final ScreenSettingsRight settingsRight;
  final ScreenSettingsBoxLeft settingsBoxLeft;
  final ScreenSettingsBoxRight settingsBoxRight;

  DefaultAnimation({
    required this.ordersListLeft,
    required this.ordersListRight,
    required this.settingsLeft,
    required this.settingsHeader,
    required this.settingsRight,
    required this.settingsBoxLeft,
    required this.settingsBoxRight,
  });

  @override
  Widget build(BuildContext context) {
    var countColon = 5;
    var size = MediaQuery.of(context).size.width /2;
    var aspect = size / settingsBoxRight.wightBoxRight;
    return Scaffold(
      body: Row(
        children: [
          //LEFT
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: settingsLeft.leftColumnColor,
                border: Border(
                    top: settingsLeft.borderIsActiveTopLeft
                        ? BorderSide(
                            color: settingsLeft.leftColorBorder,
                            width: settingsLeft.leftSizeBorder,
                          )
                        : BorderSide.none,
                    left: settingsLeft.borderIsActiveLeftLeft
                        ? BorderSide(
                            color: settingsLeft.leftColorBorder,
                            width: settingsLeft.leftSizeBorder,
                          )
                        : BorderSide.none,
                    right: settingsLeft.borderIsActiveRightLeft
                        ? BorderSide(
                            color: settingsLeft.leftColorBorder,
                            width: settingsLeft.leftSizeBorder,
                          )
                        : BorderSide.none,
                    bottom: settingsLeft.borderIsActiveBottomLeft
                        ? BorderSide(
                            color: settingsLeft.leftColorBorder,
                            width: settingsLeft.leftSizeBorder,
                          )
                        : BorderSide.none)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  settingsLeft.textLeftTitle.toString(),
                  style: GoogleFonts.getFont(
                      fontSize: settingsLeft.leftSizeText,
                      settingsLeft.styleColumnLeft,
                      color: settingsLeft.leftColorText),
                ),
                Expanded(
                  child: ordersListLeft.isNotEmpty
                      ? SingleChildScrollView(
                          child: Consumer<ScreenSettingsBoxLeft>(
                            builder: (context, settingsBox, child) {
                              // Сортируем список перед отображением
                              ordersListLeft.sort((a, b) => a.compareTo(b));
                              return Wrap(
                                children: List.generate(ordersListLeft.length,
                                    (index) {
                                  dynamic order = ordersListLeft[index];
                                  return Container(
                                    margin: const EdgeInsets.all(4.0),
                                    alignment: Alignment.center,
                                    width: settingsBox.widthBoxLeft,
                                    height: settingsBox.heightBoxLeft,
                                    decoration: BoxDecoration(
                                      color: settingsBoxLeft
                                          .backgroundBoxColorLeft,
                                      border:settingsBoxLeft.sizeBorderLeft == 0 ? null : Border.all(
                                        width: settingsBoxLeft.sizeBorderLeft,
                                        color:
                                            settingsBoxLeft.boxBorderColorLeft,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            settingsBoxLeft.radiusBoxLeft),
                                      ),
                                    ),
                                    child: Text(
                                      //  maxLines: 1,
                                      textAlign: TextAlign.start,
                                      order.toString(),
                                      style: GoogleFonts.getFont(
                                          settingsBoxLeft.styleBoxLeft,
                                          color:
                                              settingsBoxLeft.textBoxColorLeft,
                                          fontSize:
                                              settingsBoxLeft.sizeTextLeft),
                                    ),
                                  );
                                })
                              );
                            },
                          ),
                        )
                      : Container()
                ),

              ],
            ),
          )),
          //RIGHT
          Expanded(
              child: Container(
                decoration: BoxDecoration(
                color: settingsRight.rightColumnColor,
                border: Border(
                    top: settingsRight.borderIsActiveTopRight
                        ? BorderSide(
                            color: settingsRight.rightColorBorder,
                            width: settingsRight.rightSizeBorder,
                          )
                        : BorderSide.none,
                    left: settingsRight.borderIsActiveLeftRight
                        ? BorderSide(
                            color: settingsRight.rightColorBorder,
                            width: settingsRight.rightSizeBorder,
                          )
                        : BorderSide.none,
                    right: settingsRight.borderIsActiveRightRight
                        ? BorderSide(
                            color: settingsRight.rightColorBorder,
                            width: settingsRight.rightSizeBorder,
                          )
                        : BorderSide.none,
                    bottom: settingsRight.borderIsActiveBottomRight
                        ? BorderSide(
                            color: settingsRight.rightColorBorder,
                            width: settingsRight.rightSizeBorder,
                          )
                        : BorderSide.none)),
            child: Column(
              children: [
                Text(
                  settingsRight.textRightTitle.toString(),
                  style: GoogleFonts.getFont(
                    settingsRight.styleColumnRight,
                    fontSize: settingsRight.rightSizeText,
                    color: settingsRight.rightColorText,
                  ),
                ),
                Expanded(
                  child: ordersListRight.isNotEmpty ?
                  SingleChildScrollView(
                          child: Wrap(
                            spacing: 1.0,
                            children:
                                List.generate(ordersListRight.length, (index) {
                              dynamic order = ordersListRight[index];
                              return Container(
                                margin: const EdgeInsets.all(4.0),
                                alignment: Alignment.center,
                                width: settingsBoxRight.wightBoxRight,
                                height: settingsBoxRight.heightBoxRight,
                                decoration: BoxDecoration(
                                  color:
                                      settingsBoxRight.backgroundBoxColorRight,
                                  border: settingsBoxRight.sizeBorderRight == 0 ? null: Border.all(
                                      width: settingsBoxRight.sizeBorderRight,
                                      color: settingsBoxRight.boxBorderColorRight),
                                ),
                                child: Text(
                                  order.toString(),
                                  style: GoogleFonts.getFont(
                                    settingsBoxRight.styleBoxRight,
                                    color: settingsBoxRight.textBoxColorRight,
                                    fontSize: settingsBoxRight.sizeTextRight,
                                  ),
                                ),
                              );
                            }),
                          ),
                        )
                      :  Container()
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }

   defaultLeft() {
    return Container(
        decoration: BoxDecoration(
            color: settingsLeft.leftColumnColor,
            border: Border(
                top: settingsLeft.borderIsActiveTopLeft
                    ? BorderSide(
                        color: settingsLeft.leftColorBorder,
                        width: settingsLeft.leftSizeBorder,
                      )
                    : BorderSide.none,
                left: settingsLeft.borderIsActiveLeftLeft
                    ? BorderSide(
                        color: settingsLeft.leftColorBorder,
                        width: settingsLeft.leftSizeBorder,
                      )
                    : BorderSide.none,
                right: settingsLeft.borderIsActiveRightLeft
                    ? BorderSide(
                        color: settingsLeft.leftColorBorder,
                        width: settingsLeft.leftSizeBorder,
                      )
                    : BorderSide.none,
                bottom: settingsLeft.borderIsActiveBottomLeft
                    ? BorderSide(
                        color: settingsLeft.leftColorBorder,
                        width: settingsLeft.leftSizeBorder,
                      )
                    : BorderSide.none
            )
        )
    );
  }

  void getFilterStatus() {
    // Создаем копии текущих списков для отслеживания изменений
    List<int> currentOrdersListLeft = List.from(ordersListLeft);
    List<int> currentOrdersListRight = List.from(ordersListRight);

    // Получаем текущее время
    DateTime currentTime = DateTime.now();
    int maxMinutes = settingsHeader.deleteHours;  // Время, после которого элементы удаляются

    // Обновляем списки на основе новых данных
    ordersListLeft.clear();  // Очищаем списки перед обновлением
    ordersListRight.clear();

    for (var status in ordersListLeft) {
      Duration difference = currentTime.difference(status.dateCreated);

      // Проверяем, не превышает ли разница во времени максимальное значение
      if (difference.inMinutes < maxMinutes) {
        switch (status.state) {
          case 2:
          // Добавляем в левый список только если его там еще нет
            if (!currentOrdersListLeft.contains(status.number)) {
              ordersListLeft.add(status.number);
            }
            break;
          case 6:
          // Добавляем в правый список только если его там еще нет
            if (!currentOrdersListRight.contains(status.number)) {
              ordersListRight.add(status.number);
            }
            break;
          case 4:
          // Удаляем из обоих списков
            ordersListLeft.remove(status.number);
            ordersListRight.remove(status.number);
            break;
          default:
          // Обработка других состояний, если необходимо
            break;
        }
      }
    }
  }
}



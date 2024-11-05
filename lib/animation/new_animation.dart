import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:monitor_for_sales/providers/screen_setting_header.dart';
import 'package:provider/provider.dart';
import 'package:sound_library/sound_library.dart';

import '../broker/color_app.dart';
import '../providers/screen_setting_box_left.dart';
import '../providers/screen_setting_box_right.dart';
import '../providers/screen_setting_left.dart';
import '../providers/screen_setting_right.dart';

class NewAnimation extends StatefulWidget {
  final List<dynamic> ordersListLeft;
  final List<int> ordersListRight;
  final ScreenSettingsLeft settingsLeft;
  final ScreenSettingsHeader settingsHeader;
  final ScreenSettingsRight settingsRight;
  final ScreenSettingsBoxLeft settingsBoxLeft;
  final ScreenSettingsBoxRight settingsBoxRight;
  final int numberRight;

  const NewAnimation(
      {super.key,
      required this.numberRight,
      required this.ordersListLeft,
      required this.ordersListRight,
      required this.settingsLeft,
      required this.settingsHeader,
      required this.settingsRight,
      required this.settingsBoxLeft,
      required this.settingsBoxRight});

  @override
  State<NewAnimation> createState() => _NewAnimationState();
}

class _NewAnimationState extends State<NewAnimation> {
  late List<int> displayedOrders;
  List<int> previousList = []; // Список для хранения предыдущего состояния mainList
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  int index = 0;
  bool isFirstRun = true;
  // Флаг для предотвращения одновременного запуска нескольких удалений
  bool _isRemoving = false;

  @override
  void initState() {
    super.initState();
    displayedOrders = [];
    Timer.periodic(const Duration(seconds: 5), (timer){
      response();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(1920, 1080),
        builder: (context, child) {
          return Scaffold(
            body: Row(
              children: [
                //Left
                Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: HexColor(widget.settingsLeft.leftColumnColor),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 40.w, top: 56.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 83.h,
                              width: 328.w,
                              color: HexColor(widget.settingsLeft.titleColorBox),
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.0.h, bottom: 8.w),
                            child: Text(
                                        widget.settingsLeft.textLeftTitle
                                            .toString(),
                                        style: GoogleFonts.getFont(
                                          'Roboto',
                                          fontSize: 56.h,
                                          fontWeight: FontWeight.w400,
                                          //  height: 67.2,
                                          color: HexColor(widget.settingsLeft.leftColorText),
                                        )),
                          ),
                            ),
                            Expanded(
                                child: widget.ordersListLeft.isNotEmpty
                                    ? SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                        child: Consumer<ScreenSettingsBoxLeft>(
                                          builder:
                                              (context, settingsBox, child) {
                                            widget.ordersListLeft.sort((a, b) => a.compareTo(b));
                                            return Padding(
                                              padding: EdgeInsets.only(top: 26.h),
                                              child: Wrap(
                                                direction: Axis.vertical,
                                                  children: List.generate(widget.ordersListLeft.length >= 20 ? 20 : widget.ordersListLeft.length, (index) {
                                                dynamic order = widget.ordersListLeft[index];
                                                return Padding(
                                                  padding: EdgeInsets.only(right: 23.h, top: 24.h),
                                                  child: Container(
                                                      alignment: Alignment.center,
                                                      width: 203.w,
                                                      height: 148.w,
                                                      decoration: BoxDecoration(
                                                        color: HexColor(widget.settingsBoxLeft.backgroundBoxColorLeft),
                                                        borderRadius:
                                                            BorderRadius.all(Radius.circular(24.r),
                                                        ),
                                                      ),
                                                      child: Text(
                                                          maxLines: 1,
                                                          textAlign: TextAlign.start,
                                                          order.toString(),
                                                          style: GoogleFonts.getFont(
                                                            'Roboto',
                                                            fontSize: 84.sp,
                                                            fontWeight: FontWeight.w400,
                                                            color: HexColor(widget.settingsBoxLeft.textBoxColorLeft),
                                                          ))),
                                                );
                                              })),
                                            );
                                          },
                                        ),
                                      )
                                    : Container())
                          ],
                        ),
                      ),
                    )),
                //Right
                Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: HexColor(widget.settingsRight.rightColumnColor),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 40.w, top: 56.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 83.w,
                              width: 271.w,
                              color: HexColor(widget.settingsRight.rightColorTitleBox),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 16.w, bottom: 8.w),
                                  child: Text(
                                      widget.settingsRight.textRightTitle
                                          .toString(),
                                      style: GoogleFonts.getFont(
                                        'Roboto',
                                        fontSize: 56.sp,
                                        fontWeight: FontWeight.w400,
                                        wordSpacing: 0,
                                        color: HexColor(widget.settingsRight.rightColorText),
                                      )),
                              ),
                            ),
                            Expanded(
                                child: widget.ordersListRight.isNotEmpty
                                    ? SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                        child: Consumer<ScreenSettingsBoxLeft>(
                                          builder: (context, settingsBox, child) {
                                            widget.ordersListRight.sort((a, b) => b.compareTo(a));
                                            return Padding(padding: EdgeInsets.only(top: 26.h),
                                                child: Stack(
                                                  children: [
                                                    Wrap(
                                                        direction: Axis.vertical,
                                                        children: List.generate(widget.ordersListRight.length >= 20 ? 20 : widget.ordersListRight.length, (index) {
                                                          dynamic order = widget.ordersListRight[index];
                                                          // Остальные строки без смещения
                                                          return Padding(
                                                                padding: EdgeInsets.only(right: 23.h, top: 24.h,
                                                                  //left: leftPadding
                                                                ),
                                                                child: Container(
                                                                    alignment: Alignment.center,
                                                                    width: 203.w,
                                                                    height: 148.h,
                                                                    decoration:
                                                                    BoxDecoration(color: HexColor(widget.settingsBoxRight.backgroundBoxColorRight),
                                                                      borderRadius: BorderRadius.all(Radius.circular(24.r),),
                                                                    ),
                                                                    child: Text(
                                                                        maxLines: 1,
                                                                        textAlign: TextAlign.start,
                                                                        order.toString(),
                                                                        style: GoogleFonts.getFont(
                                                                          'Roboto',
                                                                          fontSize: 84.sp,
                                                                          fontWeight: FontWeight.w400,
                                                                          color: HexColor(widget.settingsBoxRight.textBoxColorRight),
                                                                        )
                                                                    )
                                                                ),
                                                              );
                                                        })
                                                    ),
                                                   displayedOrders.isNotEmpty ?
                                                   Padding(
                                                     padding: EdgeInsets.only(right: 23.h, top: 24.h,),
                                                     child: Container(
                                                          alignment: Alignment.center,
                                                          width: 429.w,
                                                          height: 320.w,
                                                          decoration:
                                                          BoxDecoration(color: HexColor(widget.settingsBoxRight.backgroundBoxColorRight),
                                                            borderRadius: BorderRadius.all(Radius.circular(34.r),),
                                                          ),
                                                          child: Text(
                                                              maxLines: 1,
                                                              textAlign: TextAlign.start,
                                                              displayedOrders[0].toString(),
                                                              style: GoogleFonts.getFont(
                                                                'Roboto',
                                                                fontSize: 148.sp,
                                                                fontWeight: FontWeight.w400,
                                                                color: HexColor(widget.settingsBoxRight.textBoxColorRight),
                                                              )
                                                          )
                                                        ),
                                                   ): Container(color: Colors.transparent,)
                                                  ],
                                                ),
                                              );
                                          },
                                        ),
                                      )
                                    : Container())
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          );
        });
  }

  void response() {
    // Находим новые элементы, которых не было в предыдущем списке
    List<int> newItems = widget.ordersListRight.where((item) =>
    !previousList.contains(item)).toList();

    if (isFirstRun) {
      isFirstRun = false;
    } else {
      if (newItems.isNotEmpty) {
        displayedOrders.addAll(newItems); // Добавляем только новые элементы
        print('Added new items to displayedOrders: $displayedOrders');
        setState(() {});
        _playSound();

        // Запускаем удаление с задержкой, если его еще не было
        if (!_isRemoving) {
          _removeItemsWithDelay();
        }
      }
    }
    // Обновляем previousList для следующего цикла
    previousList = List.from(widget.ordersListRight);
  }
    // Функция для последовательного удаления элементов с задержкой
  void _removeItemsWithDelay() {
    if (displayedOrders.isNotEmpty) {
      _isRemoving = true;
      Future.delayed(const Duration(seconds: 5), () {
        setState(() {
          displayedOrders.removeAt(0); // Удаляем первый элемент
          print('Removed an item from displayedOrders: $displayedOrders');
        });
        // Рекурсивно вызываем себя для следующего элемента
        _removeItemsWithDelay();
      });
    } else {
      _isRemoving = false; // Завершаем, когда список пуст
    }
  }




  void _playSound() {
    var settingsHeader = Provider.of<ScreenSettingsHeader>(context, listen: false);
    if (settingsHeader.soundActive == true) {
      Sounds? sound = settingsHeader.sounds;
      SoundPlayer.play(sound!,
          volume: 3, position: const Duration(microseconds: 500));
    } else {
      null;
    }
  }
}

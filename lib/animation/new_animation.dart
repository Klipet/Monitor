
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:monitor_for_sales/providers/screen_setting_header.dart';
import 'package:provider/provider.dart';
import 'package:sound_library/sound_library.dart';
import 'package:window_manager/window_manager.dart';
import '../broker/log.dart';
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

class _NewAnimationState extends State<NewAnimation> with WindowListener {
  late List<int> displayedOrders;
  List<int> previousList = []; // Список для хранения предыдущего состояния mainList
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  int index = 0;
  bool isFirstRun = true;
  // Флаг для предотвращения одновременного запуска нескольких удалений
  bool _isRemoving = false;
  late int sizewidth;
  late int sizeheight;
  late int sizeheightBig;
  late int sizewidthBig;
  late int countBox;
  late double sizeText;
  late double sizeTextBig;
  double appScale = 1.0;
  String windowSize = "Не определено";
  final fileLogger = FileLogger();


  @override
  void initState() {
    super.initState();
    displayedOrders = [];
    windowManager.addListener(this);
    Timer.periodic(const Duration(seconds: 1), (timer){
      response();
    });
  }




  @override
  Widget build(BuildContext context) {
    var settingsHeader = Provider.of<ScreenSettingsHeader>(context);
    sizewidth = (203 * 4) ~/ settingsHeader.sizeBox;
    sizeheight = (148 * 4) ~/ settingsHeader.sizeBox;
    sizeheightBig = (320 * 4) ~/ settingsHeader.sizeBox;
    sizewidthBig = (429 * 4) ~/ settingsHeader.sizeBox;
    sizeText = 84 *(sizewidth / 203) ;
    sizeTextBig = 148 * (sizewidthBig / 429) ;

    if(settingsHeader.sizeBox == 3){
      countBox = 12;

    }else if(settingsHeader.sizeBox == 4){
      countBox = 20;
    }else if(settingsHeader.sizeBox == 5){
      countBox = 30;
    }else{
      countBox = 4;
    }

    return ScreenUtilInit(
        designSize: const Size(1920, 1080),
        minTextAdapt: true,
        ensureScreenSize: true,
        useInheritedMediaQuery: true,
        builder: (context, child) {
          // Получаем размеры монитора
          return Scaffold(
            body: Stack(
              children:[
                Row(
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
                                constraints: BoxConstraints(minWidth: 328.w),
                                color: HexColor(widget.settingsLeft.titleColorBox),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 16.w, bottom: 8.h, right: 16.w, top: 8.h
                              ),
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child:Text(
                                    widget.settingsLeft.textLeftTitle.toString(),
                                    style: GoogleFonts.getFont(
                                      'Roboto',
                                      fontStyle: FontStyle.normal,
                                      fontSize: 56.sp,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2,  // Высота строки,
                                      color: HexColor(widget.settingsLeft.leftColorText),
                                    )),
                              )
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
                                                child:
                                                Wrap(
                                                  direction: Axis.vertical,
                                                    children: List.generate(
                                                        widget.ordersListLeft.length >= countBox ? countBox : widget.ordersListLeft.length,
                                                            (index) {
                                                  dynamic order = widget.ordersListLeft[index];
                                                  return Padding(
                                                    padding: EdgeInsets.only(right: 23.h, top: 24.h),
                                                    child: Container(
                                                        alignment: Alignment.center,
                                                        width: sizewidth.w,
                                                        height: sizeheight.h,
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
                                                              fontSize: sizeText.sp,
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
                          image: widget.settingsHeader.selectedImage != null
                              ? DecorationImage(
                            image: FileImage(widget.settingsHeader.selectedImage!),
                            alignment: widget.settingsRight.alignment,

                          )
                              : null
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 40.w, top: 56.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 83.h,
                                constraints: BoxConstraints(minWidth: 271.w),
                              //  width: 271.w,
                                color: HexColor(widget.settingsRight.rightColorTitleBox),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 16.w, right: 16.w, bottom: 8.h,top: 8.h
                                    ),
                                    child:
                                    FittedBox(
                                      fit: BoxFit.fill,
                                      child:Text(
                                          widget.settingsRight.textRightTitle.toString(),
                                         // textAlign: TextAlign.center,
                                          style: GoogleFonts.getFont(
                                            'Roboto',
                                            fontStyle: FontStyle.normal,
                                            fontSize: 56.spMin,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2,  // Высота строки,
                                            color: HexColor(widget.settingsRight.rightColorText),
                                          )),
                                    )
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
                                                                  padding: EdgeInsets.only(right: 23.w, top: 24.h,
                                                                    //left: leftPadding
                                                                  ),
                                                                  child: Container(
                                                                      alignment: Alignment.center,
                                                                      width: sizewidth.w,
                                                                      height: sizeheight.h,
                                                                      decoration:
                                                                      BoxDecoration(color: HexColor(widget.settingsBoxRight.backgroundBoxColorRight),
                                                                        borderRadius: BorderRadius.all(Radius.circular(24.r),),
                                                                      ),
                                                                      child: FittedBox(
                                                                        fit: BoxFit.fill,
                                                                        child: Text(
                                                                            maxLines: 1,
                                                                            textAlign: TextAlign.start,
                                                                            order.toString(),
                                                                            style: GoogleFonts.getFont(
                                                                              'Roboto',
                                                                              fontSize: sizeText.sp,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: HexColor(widget.settingsBoxRight.textBoxColorRight),
                                                                            )
                                                                        ),
                                                                      )
                                                                  ),
                                                                );
                                                          })
                                                      ),
                                                      displayedOrders.isNotEmpty ?
                                                      Padding(
                                                        padding: EdgeInsets.only(right: 23.w, top: 24.h,),
                                                        child: Container(
                                                            alignment: Alignment.center,
                                                            width: sizewidthBig.w,
                                                            height: sizeheightBig.h,
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
                                                                  fontSize: sizeTextBig.sp,
                                                                  fontWeight: FontWeight.w400,
                                                                  color: HexColor(widget.settingsBoxRight.textBoxColorRight),
                                                                )
                                                            )
                                                        ),
                                                      ): Container(color: Colors.transparent,),
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
                      )),

                ],
              ),

           ] ),
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
      //  print('Added new items to displayedOrders: $displayedOrders');
      //  fileLogger.logInfo('Added new items to displayedOrders: $displayedOrders');
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
          if (kDebugMode) {
            print('Removed an item from displayedOrders: $displayedOrders');
          }
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
      Sounds? sound = settingsHeader.sounds as Sounds;
      SoundPlayer.play(sound,
          volume: 3, position: const Duration(microseconds: 500));
    } else {
      null;
    }
  }
  void size(){
    var settingsHeader = Provider.of<ScreenSettingsHeader>(context, listen: false);
    int sizeBox = settingsHeader.sizeBox;
    sizeheight = ((203 * 4) / sizeBox).toInt();
    sizewidth = ((148 * 4) / sizeBox).toInt();
  }
}


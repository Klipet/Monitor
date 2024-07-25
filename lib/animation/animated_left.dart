import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/animation_builder/custom_animation_builder.dart';
import '../providers/screen_setting_box_left.dart';
import '../providers/screen_setting_box_right.dart';
import '../providers/screen_setting_left.dart';
import '../providers/screen_setting_right.dart';
import 'animated_order_container .dart';


class AnimatedLeft extends StatelessWidget {
  final List<dynamic> ordersListLeft;
  final List<dynamic> ordersListRight;
  final ScreenSettingsLeft settingsLeft;
  final ScreenSettingsRight settingsRight;
  final ScreenSettingsBoxLeft settingsBoxLeft;
  final ScreenSettingsBoxRight settingsBoxRight;
  final Control control;

  AnimatedLeft({
    required this.ordersListLeft,
    required this.ordersListRight,
    required this.settingsLeft,
    required this.settingsRight,
    required this.settingsBoxLeft,
    required this.settingsBoxRight,
    required this.control,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
      children: [
        //LEFT
        Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: settingsLeft.leftColumnColor,
                  border: settingsLeft.borderLeft ? Border.all(
                    color: settingsLeft.leftColorBorder,
                    width: settingsLeft.leftSizeBorder,
                  ) : null
              ),
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
                          ordersListLeft.sort((a, b) => a.compareTo(b));
                          return Wrap(
                            children: List.generate(
                                ordersListLeft.length, (index) {
                              dynamic order = ordersListLeft[index];
                              return Container(
                                margin: EdgeInsets.all(4.0),
                                child:
                                CustomAnimationBuilder<double>(
                                  duration: Duration(seconds: 1),
                                  control: control,
                                  tween: Tween(begin: -50, end: 0),
                                  builder: (context, value, child){
                                    return Transform.translate(
                                      // animation that moves childs from left to right
                                      offset: Offset(value, 0),
                                      child: child,
                                    );
                                  },
                                  child: Container(
                                  alignment: Alignment.center,
                                  width: settingsBox.sizeBoxLeft,
                                  height: settingsBox.sizeBoxLeft,
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
                                      Radius.circular(settingsBoxLeft
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
                                ),
                                  )

                              );
                            }),
                          );
                        },
                      ),
                    )
                        : const Center(child: Text("No orders available")),
                  )
                ],
              ),
            )
        ),
        //RIGHT
        Expanded(
            child:
            Container(
              decoration: BoxDecoration(
                  color: settingsRight.rightColumnColor,
                  border: settingsRight.borderRight ? Border.all(
                    color: settingsRight.rightColorBorder,
                    width: settingsRight.rightSizeBorder,
                  ): null
              ),
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
                    child: ordersListRight.isNotEmpty
                        ? SingleChildScrollView(
                      child: Wrap(
                        children: List.generate(ordersListRight.length,
                                (index) {
                              dynamic order = ordersListRight[index];
                              return CustomAnimationBuilder<double>(
                                  duration: const Duration(seconds: 1),
                                  control: control,
                                  tween: Tween(begin: -50, end: 0),
                                  builder: (context, value, child){
                                    return Transform.translate(
                                      offset: Offset(value, 0),
                                      child: child,
                                    );
                                  },
                                child:  Container(
                                  margin: const EdgeInsets.all(4.0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: settingsBoxRight.sizeBoxRight,
                                    height: settingsBoxRight.sizeBoxRight,
                                    decoration: BoxDecoration(
                                      color: settingsBoxRight
                                          .backgroundBoxColorRight,
                                      border: Border.all(
                                          width: settingsBoxRight
                                              .sizeBorderRight,
                                          color: settingsBoxRight
                                              .boxBorderColorRight),
                                    ),
                                    child:  Text(
                                      order.toString(),
                                      style: GoogleFonts.getFont(
                                          settingsBoxRight.styleBoxRight,
                                          color: settingsBoxRight.textBoxColorRight,
                                          fontSize: settingsBoxRight.sizeTextRight),
                                    ),
                                  )
                                  )
                              );
                            }),
                      ),
                    )
                        : const Center(
                      child: Text(
                        'No orders available',
                        style: TextStyle(
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ))
      ],
    ),
    );
  }
}
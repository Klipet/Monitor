
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/screen_setting_box_left.dart';
import '../providers/screen_setting_box_right.dart';
import '../providers/screen_setting_left.dart';
import '../providers/screen_setting_right.dart';
import 'animated_order_container .dart';

class OrderScreen extends StatelessWidget {
  final List<dynamic> ordersListLeft;
  final List<dynamic> ordersListRight;
  final ScreenSettingsLeft settingsLeft;
  final ScreenSettingsRight settingsRight;
  final ScreenSettingsBoxLeft settingsBoxLeft;
  final ScreenSettingsBoxRight settingsBoxRight;
  final AnimatedOrderContainer control;

  OrderScreen({
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
          // LEFT COLUMN
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: settingsLeft.leftColumnColor,
                border: Border(
                        top: settingsLeft.borderIsActiveTopLeft ? BorderSide(
                          color: settingsLeft.leftColorBorder,
                          width: settingsLeft.leftSizeBorder,
                        ): BorderSide.none,
                        left: settingsLeft.borderIsActiveLeftLeft ? BorderSide(
                          color: settingsLeft.leftColorBorder,
                          width: settingsLeft.leftSizeBorder,
                        ): BorderSide.none,
                        right: settingsLeft.borderIsActiveRightLeft ? BorderSide(
                          color: settingsLeft.leftColorBorder,
                          width: settingsLeft.leftSizeBorder / 2,
                        ): BorderSide.none,
                        bottom: settingsLeft.borderIsActiveBottomLeft ? BorderSide(
                          color: settingsLeft.leftColorBorder,
                          width: settingsLeft.leftSizeBorder,
                        ): BorderSide.none
                    )
              ),
              child: Column(
                children: [
                  Text(
                    settingsLeft.textLeftTitle.toString(),
                    style: GoogleFonts.getFont(
                      settingsLeft.styleColumnLeft,
                      fontSize: settingsLeft.leftSizeText,
                      color: settingsLeft.leftColorText,
                    ),
                  ),
                  Expanded(
                    child: ordersListLeft.isNotEmpty
                        ? SingleChildScrollView(
                      child: Consumer<ScreenSettingsBoxLeft>(
                        builder: (context, settingsBox, child) {
                          ordersListLeft.sort((a, b) => a.compareTo(b));
                          return Wrap(
                            children: List.generate(ordersListLeft.length, (index) {
                              dynamic order = ordersListLeft[index];
                              return AnimatedOrderContainer(
                                order: order,
                                wightSizeBox: settingsBox.widthBoxLeft,
                                heightSizeBox: settingsBox.heightBoxLeft,
                                sizeBorder: settingsBox.sizeBorderLeft,
                                boxBorderColor: settingsBox.boxBorderColorLeft,
                                backgroundColor: settingsBox.backgroundBoxColorLeft,
                                textColor: settingsBox.textBoxColorLeft,
                                textSize: settingsBox.sizeTextLeft,
                                font: settingsBox.styleBoxLeft,
                              );
                            }),
                          );
                        },
                      ),
                    )
                        : const Center(),
                  ),
                ],
              ),
            ),
          ),
          // RIGHT COLUMN
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
                          : BorderSide.none)
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
                        children: List.generate(ordersListRight.length, (index) {
                          dynamic order = ordersListRight[index];
                          return AnimatedOrderContainer(
                            order: order,
                            heightSizeBox: settingsBoxRight.heightBoxRight,
                            wightSizeBox: settingsBoxRight.wightBoxRight,
                            sizeBorder: settingsBoxRight.sizeBorderRight,
                            boxBorderColor: settingsBoxRight.boxBorderColorRight,
                            backgroundColor: settingsBoxRight.backgroundBoxColorRight,
                            textColor: settingsBoxRight.textBoxColorRight,
                            textSize: settingsBoxRight.sizeTextRight,
                            font: settingsBoxRight.styleBoxRight,
                          );
                        }),
                      ),
                    )
                        : const Center(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
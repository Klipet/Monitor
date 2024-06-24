import 'package:flutter/material.dart';

import '../providers/screen_setting_box_left.dart';
import '../providers/screen_setting_box_right.dart';

class OrderWidget extends StatelessWidget {
  final int number;
  final bool isLeft;
  final ScreenSettingsBoxLeft settingsBox;
  final ScreenSettingsBoxRight settingsBoxRight;

  const OrderWidget({
    super.key,
    required this.number,
    required this.isLeft,
    required this.settingsBox,
    required this.settingsBoxRight,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(seconds: 20),
      left: isLeft ? 0 : MediaQuery.of(context).size.width / 2,
      right: isLeft ? MediaQuery.of(context).size.width / 2 : 0,
      child: Container(
        margin: const EdgeInsets.all(4.0),
        alignment: Alignment.center,
        width: isLeft ? settingsBox.sizeBoxLeft : settingsBoxRight.sizeBoxRight,
        height: isLeft ? settingsBox.sizeBoxLeft : settingsBoxRight.sizeBoxRight,
        decoration: BoxDecoration(
          color: isLeft
              ? settingsBox.backgroundBoxColorLeft
              : settingsBoxRight.backgroundBoxColorRight,
          border: Border.all(
            width: isLeft ? settingsBox.sizeBorderLeft : settingsBoxRight.sizeBorderRight,
            color: isLeft ? settingsBox.boxBorderColorLeft : settingsBoxRight.boxBorderColorRight,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(isLeft ? settingsBox.radiusBoxLeft : settingsBoxRight.radiusBoxRight),
          ),
        ),
        child: Text(
          number.toString(),
          style: TextStyle(
            color: isLeft ? settingsBox.textBoxColorLeft : settingsBoxRight.textBoxColorRight,
            fontSize: isLeft ? settingsBox.sizeTextLeft : settingsBoxRight.sizeTextRight,
          ),
        ),
      ),
    );
  }
}
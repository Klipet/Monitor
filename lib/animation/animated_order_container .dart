import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/animation_builder/custom_animation_builder.dart';

class AnimatedOrderContainer  extends StatelessWidget{

  late final dynamic order;
  late final double sizeBox;
  late final double sizeBorder;
  late final Color boxBorderColor;
  late final Color backgroundColor;
  late final Color textColor;
  late final double textSize;
  late final String font;
  Control control = Control.play;



  AnimatedOrderContainer({
    required this.order,
    required this.sizeBox,
    required this.sizeBorder,
    required this.boxBorderColor,
    required this.backgroundColor,
    required this.textColor,
    required this.textSize,
    required this.font,
  });


  @override
  Widget build(BuildContext context) {
    return CustomAnimationBuilder<double>(
      duration: const Duration(seconds: 2),
      control: control,
      tween: TweenSequence([
        TweenSequenceItem(tween: Tween(begin: 0.0, end: 100.0), weight: 1),  // Падение вниз
        TweenSequenceItem(tween: Tween(begin: 0.0, end: 100.0), weight: 1),  // Перекатывание вправо
        TweenSequenceItem(tween: Tween(begin: 100.0, end: 0.0), weight: 1),  // Подъем наверх
      ]),
      builder: (context, value, child) {
        double dx = value <= 100 ? 0 : value - 100;  // Смещение по X
        double dy = value <= 100 ? value : 100;  // Смещение по Y
        return Transform.translate(
          offset: Offset(dx, dy),
          child: child,
        );
      },
      child: Container(
        margin: EdgeInsets.all(4.0),
        alignment: Alignment.center,
        width: sizeBox,
        height: sizeBox,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            width: sizeBorder,
            color: boxBorderColor,
          ),
        ),
        child: Text(
          order.toString(),
          style: GoogleFonts.getFont(
            font,
            color: textColor,
            fontSize: textSize,
          ),
        ),
      ),
    );
  }
}

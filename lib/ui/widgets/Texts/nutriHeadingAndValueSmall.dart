import 'package:fitness_diet/ui/shared/fonts.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NutriHeadingAndValueSmall extends StatelessWidget {
  String passedHeading;
  String passedValue;

  NutriHeadingAndValueSmall(
      {@required this.passedHeading, @required this.passedValue});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          passedHeading,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: fontLemonMilk,
            fontSize: 14,
            color: Color(0xffCAB5A1),
          ),
        ),
        Text(
          passedValue,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: fontLemonMilk,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

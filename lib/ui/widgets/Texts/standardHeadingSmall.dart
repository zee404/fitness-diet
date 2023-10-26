import 'package:fitness_diet/ui/shared/fonts.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StandardHeadingSmall extends StatelessWidget {
  String passedText;
  StandardHeadingSmall({@required this.passedText});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        passedText,
        style: TextStyle(
          color: Color(0xff69AA6C),
          fontFamily: fontLemonMilk,
          fontSize: 14,
        ),
      ),
    );
  }
}

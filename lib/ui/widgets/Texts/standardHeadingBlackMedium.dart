import 'package:fitness_diet/ui/shared/fonts.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StandardHeadingBlackMedium extends StatelessWidget {
  String passedText;
  StandardHeadingBlackMedium({@required this.passedText});
  @override
  Widget build(BuildContext context) {
    return Text(
      passedText,
      style: TextStyle(
        fontFamily: fontMontserrat,
        fontSize: 20,
        color: Colors.black,
      ),
    );
  }
}

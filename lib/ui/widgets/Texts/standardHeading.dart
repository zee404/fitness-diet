import 'package:fitness_diet/ui/shared/fonts.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StandardHeading extends StatelessWidget {
  String passedText;
  StandardHeading({@required this.passedText});
  @override
  Widget build(BuildContext context) {
    return Text(
      passedText,
      style: TextStyle(
        fontFamily: fontMontserrat,
        color: Colors.brown,
        // fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        fontSize: 21,
      ),
    );
  }
}

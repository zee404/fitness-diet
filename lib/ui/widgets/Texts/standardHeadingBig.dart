import 'package:fitness_diet/ui/shared/fonts.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StandardHeadingBigBlack extends StatelessWidget {
  String passedText;
  StandardHeadingBigBlack({@required this.passedText});
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Flexible(
          child: Text(
            passedText,
            style: TextStyle(
              fontFamily: fontMontserrat,
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}

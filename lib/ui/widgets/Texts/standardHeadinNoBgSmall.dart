import 'package:fitness_diet/ui/shared/fonts.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StandardHeadingNoBgSmall extends StatelessWidget {
  String passedText;
  StandardHeadingNoBgSmall({@required this.passedText});
  @override
  Widget build(BuildContext context) {
    return Text(
      passedText,
      style: TextStyle(
        fontFamily: fontMontserrat,
        fontSize: 15,
        color: Color(0xff240303),
      ),
    );
  }
}

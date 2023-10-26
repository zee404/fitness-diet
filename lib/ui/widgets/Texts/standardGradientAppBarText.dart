import 'package:fitness_diet/ui/widgets/Texts/gradientText.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StandardGradientAppBarText extends StatelessWidget {
  String passedText;
  StandardGradientAppBarText({@required this.passedText});
  @override
  Widget build(BuildContext context) {
    return GradientText(
      passedText,
      gradient: LinearGradient(
        colors: [Colors.brown, Colors.black, Colors.green],
      ),
      style: TextStyle(
        // fontFamily: fontMontserrat,
        fontSize: 17,
      ),
      textAlign: TextAlign.center,
    );
  }
}

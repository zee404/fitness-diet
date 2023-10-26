import 'package:fitness_diet/ui/shared/fonts.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StandardLinkText extends StatelessWidget {
  String passedText;
  StandardLinkText({@required this.passedText});
  @override
  Widget build(BuildContext context) {
    return Text(
      passedText,
      style: TextStyle(
        fontFamily: fontUniSans,
        fontSize: 12,
        color: Color(0xff0e8fff),
        decoration: TextDecoration.underline,
      ),
    );
  }
}

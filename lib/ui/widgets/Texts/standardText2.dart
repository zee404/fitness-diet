import 'package:fitness_diet/ui/shared/fonts.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StandardText2 extends StatelessWidget {
  String passedDescText;
  FontWeight fontWeight;

  StandardText2({@required this.passedDescText, @required this.fontWeight});
  @override
  Widget build(BuildContext context) {
    return Text(
      passedDescText,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: fontUniSans,
        fontSize: 12,
        fontWeight: fontWeight,
      ),
    );
  }
}

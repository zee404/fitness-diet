import 'package:fitness_diet/ui/shared/fonts.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StandardText1 extends StatelessWidget {
  String passedDescText;
  FontWeight fontWeight;
  StandardText1({@required this.passedDescText, this.fontWeight});
  @override
  Widget build(BuildContext context) {
    return Text(
      passedDescText,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: fontBahnschrift,
        fontSize: 12,
        fontWeight: fontWeight != null ? fontWeight : FontWeight.normal,
      ),
    );
  }
}

import 'package:fitness_diet/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
// ignore: camel_case_types
class standardHeadingWithBGAndRoundCorner extends StatelessWidget {
  String passedText;
  standardHeadingWithBGAndRoundCorner({@required this.passedText});
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      height: deviceSize.height * 0.035,
      width: deviceSize.width,
      decoration: BoxDecoration(
        color: standardButtonBGColor,
        border: Border.all(
          width: 1.00,
          color: Color(0xffffffff),
        ),
        borderRadius: BorderRadius.circular(23.00),
      ),
      child: Center(
        child: Text(
          passedText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: deviceSize.height * 0.02,
            color: Color(0xff2a6427),
          ),
        ),
      ),
    );
  }
}

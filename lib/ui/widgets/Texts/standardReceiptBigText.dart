import 'package:fitness_diet/ui/shared/fonts.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StandardReceiptBigText extends StatelessWidget {
  String passedText;
  String passedPrice;
  StandardReceiptBigText(
      {@required this.passedText, @required this.passedPrice});
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          passedText,
          style: TextStyle(
            fontFamily: fontMontserrat,
            fontSize: deviceSize.height * 0.018,
          ),
        ),
        Text(
          passedPrice,
          style: TextStyle(
            fontFamily: fontMontserrat,
            fontSize: deviceSize.height * 0.018,
          ),
        ),
      ],
    );
  }
}

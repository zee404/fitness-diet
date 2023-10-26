import 'package:fitness_diet/ui/shared/fonts.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StandardReceiptSmallText extends StatelessWidget {
  String passedText;
  String passedPrice;
  StandardReceiptSmallText(
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
            color: Colors.black54,
            fontSize: deviceSize.height * 0.012,
          ),
        ),
        Text(
          passedPrice,
          style: TextStyle(
            fontFamily: fontMontserrat,
            color: Colors.black54,
            fontSize: deviceSize.height * 0.012,
          ),
        ),
      ],
    );
  }
}

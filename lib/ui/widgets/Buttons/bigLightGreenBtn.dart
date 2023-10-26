import 'package:fitness_diet/ui/shared/fonts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class BigLightGreenBtn extends StatelessWidget {
  String passedText;
  bool isDisabled;
  IconData passedIcon;
  BigLightGreenBtn(
      {@required this.passedText, @required this.isDisabled, this.passedIcon});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      // alignment: Alignment.bottomLeft,
      width: deviceSize.width - 27,
      height: 30,
      decoration: BoxDecoration(
        color: isDisabled ? Colors.grey : Color(0xff4E7A0B),
        borderRadius: BorderRadius.all(Radius.circular(80)),
        boxShadow: [
          BoxShadow(
            color: Colors.brown,
            blurRadius: 7.0, // has the effect of softening the shadow
            spreadRadius: 0.0, // has the effect of extending the shadow
            offset: Offset(
              0.0, // horizontal
              1.0, // vertical
            ),
          )
        ],
      ),
      child: Center(
        child: isDisabled
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    passedText,
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: fontMontserrat,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 15),
                  Icon(
                    FontAwesomeIcons.ban,
                    color: Colors.white70,
                    size: 18,
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    passedText,
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: fontMontserrat,
                      color: Colors.white,
                    ),
                  ),
                  passedIcon != null ? SizedBox(width: 15) : SizedBox(),
                  passedIcon != null
                      ? Icon(
                          passedIcon,
                          color: Colors.white,
                          size: 18,
                        )
                      : Container(),
                ],
              ),
      ),
    );
  }
}

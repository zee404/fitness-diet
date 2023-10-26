import 'package:flutter/material.dart';

class AuthBtnStyle extends StatelessWidget {
  final Size deviceSize;
  final String passedText;

  AuthBtnStyle({@required this.deviceSize, @required this.passedText});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      width: deviceSize.width * 0.3,
      height: deviceSize.height * 0.032,
      decoration: BoxDecoration(
        color: Colors.brown,
        borderRadius: BorderRadius.all(
          Radius.circular(
            deviceSize.height * 0.2,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.brown,
            blurRadius: 10.0, // has the effect of softening the shadow
            spreadRadius: 1.0, // has the effect of extending the shadow
            offset: Offset(
              0.0, // horizontal
              1.0, // vertical
            ),
          )
        ],
      ),
      child: Center(
        child: Text(
          passedText,
          style: TextStyle(
            fontSize: deviceSize.height * 0.015,
            fontFamily: "Montserrat",
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

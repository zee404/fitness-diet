import 'package:flutter/material.dart';

class StandardBtnWhitishRound extends StatelessWidget {
  String passedText;
  StandardBtnWhitishRound({@required this.passedText});
  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;
    return Container(
      width: passedText.length.toDouble() > 5
          ? passedText.length.toDouble() * _deviceSize.height * 0.015
          : _deviceSize.height * 0.1,
      height: _deviceSize.height * 0.032,
      decoration: BoxDecoration(
        color: Color(0xffe4d7cb),
        borderRadius: BorderRadius.all(
          Radius.circular(35),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.brown,
            blurRadius: 20.0, // has the effect of softening the shadow
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
            fontSize: _deviceSize.height * 0.016,
            fontFamily: "Uni-Sans",
            color: Color(0xff5f2424),
          ),
        ),
      ),
    );
  }
}

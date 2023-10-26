import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StandardBtnBlueRound extends StatelessWidget {
  String passedText;
  StandardBtnBlueRound({@required this.passedText});
  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      height: _deviceSize.height * 0.03,
      width: _deviceSize.width * 0.4,
      decoration: BoxDecoration(
        color: Color(0xffd6d8ff),
        boxShadow: [
          BoxShadow(
            offset: Offset(0.00, 3.00),
            color: Color(0xff000000).withOpacity(0.16),
            blurRadius: 6,
          ),
        ],
        borderRadius: BorderRadius.circular(_deviceSize.height * 0.09),
      ),
      child: Center(
        child: Text(
          passedText,
          style: TextStyle(
            fontSize: _deviceSize.height * 0.015,
            color: Colors.brown,
          ),
        ),
      ),
    );
  }
}

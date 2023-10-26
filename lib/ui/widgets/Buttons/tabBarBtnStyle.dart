import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TabBarBtnStyle extends StatelessWidget {
  Size deviceSize;

  String btnText;
  TabBarBtnStyle({@required this.deviceSize, @required this.btnText});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceSize.width,
      height: deviceSize.height * 0.04,
      decoration: BoxDecoration(
        color: Color(0xffD6D8FF),
        border: Border.all(
          width: deviceSize.width * 0.003,
          color: Color(0xff4E7A0B),
        ),
        borderRadius: BorderRadius.circular(deviceSize.height * 0.1),
      ),
      child: Center(
        child: Text(
          btnText,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

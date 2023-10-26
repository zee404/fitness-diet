import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SubNavBarContent extends StatelessWidget {
  Size deviceSize;
  String passedText;
  IconData passedIcon;
  SubNavBarContent({this.deviceSize, this.passedText, this.passedIcon});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(deviceSize.height * 0.003),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            passedIcon,
            size: deviceSize.height * 0.021,
            color: Colors.brown,
          ),
          Text(
            "  " + passedText,
            style: TextStyle(
              color: Colors.brown,
              fontSize: deviceSize.height * 0.012,
              fontFamily: "Uni-Sans",
            ),
          ),
        ],
      ),
    );
  }
}

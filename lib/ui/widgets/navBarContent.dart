import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NavBarContent extends StatelessWidget {
  Size deviceSize;
  String passedText;
  IconData passedIcon;
  NavBarContent({this.deviceSize, this.passedText, this.passedIcon});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(deviceSize.height * 0.004),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            passedIcon,
            size: deviceSize.height * 0.02,
            color: Colors.brown,
          ),
          Text(
            "  " + passedText,
            style: TextStyle(
              color: Colors.brown,
              fontSize: deviceSize.height * 0.021,
              fontFamily: "Uni-Sans",
            ),
          ),
        ],
      ),
    );
  }
}

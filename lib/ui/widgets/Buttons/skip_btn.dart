import 'package:flutter/material.dart';

class SkipBtn extends StatelessWidget {
  String passedText;
  Size deviceSize;
  SkipBtn({this.deviceSize, this.passedText});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      width: 80,
      decoration: BoxDecoration(
        color: Color(0xffe4d7cb),
        borderRadius: BorderRadius.circular(deviceSize.width * 0.07),
      ),
      child: Row(
        children: <Widget>[
          Text(
            "   " + passedText,
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 13,
              color: Color(0xff0c0101),
            ),
          ),
          Spacer(),
          Container(
            height: 20,
            width:24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Icon(
              Icons.arrow_forward_ios,
              size: deviceSize.height * 0.02,
            ),
          )
        ],
      ),
    );
  }
}

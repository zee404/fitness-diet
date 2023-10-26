import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class CircularIcon extends StatelessWidget {
  IconData passedIcon;
  Color passedColor;
  CircularIcon({@required this.passedIcon, @required this.passedColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            offset: Offset(2.00, 3.00),
            color: Colors.black45,
            blurRadius: 5,
          ),
        ],
      ),
      child: Center(
        child: FaIcon(
          passedIcon,
          size: 20,
          color: passedColor,
        ),
      ),
    );
  }
}

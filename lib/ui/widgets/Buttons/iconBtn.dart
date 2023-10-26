import 'package:flutter/material.dart';

// ignore: must_be_immutable
class IconBtn extends StatelessWidget {
  IconData passedIcon;
  IconBtn({@required this.passedIcon});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.35),
          //     spreadRadius: 0.1,
          //     blurRadius: 12,
          //     offset: Offset(1, 1), // changes position of shadow
          //   ),
          // ],
          ),
      child: Icon(
        passedIcon,
        color: Colors.grey,
        size: 30,
      ),
    );
  }
}

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TinyRightBtn extends StatelessWidget {
  String passedText;
  bool isSelected;
  TinyRightBtn({@required this.passedText, @required this.isSelected});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.brown : Colors.grey,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Center(
        child: Text(
          passedText,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

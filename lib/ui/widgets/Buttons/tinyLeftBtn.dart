import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TinyLeftBtn extends StatelessWidget {
  String passedText;
  bool isSelected;
  TinyLeftBtn({@required this.passedText, @required this.isSelected});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.brown : Colors.grey,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          topLeft: Radius.circular(10),
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

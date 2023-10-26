import 'package:flutter/material.dart';

class StandardHeadingNoBgUniSans extends StatelessWidget {
  String passedText;
  StandardHeadingNoBgUniSans({@required this.passedText});
  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: Text(
        passedText,
        style: TextStyle(
          fontFamily: "Uni-Sans",
          fontSize: _deviceSize.height * 0.023,
          color: Color(0xff2a6427),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TextFieldWithWhiteBGSmall extends StatefulWidget {
  final TextEditingController controller;
  //final Size deviceSize;
  final isTypeInt;
  final hintText;
  final isObscureText;

  TextFieldWithWhiteBGSmall({
    @required this.controller,
    // @required this.deviceSize,
    @required this.isTypeInt,
    @required this.hintText,
    @required this.isObscureText,
  });
  @override
  _TextFieldWithWhiteBGSmallState createState() =>
      _TextFieldWithWhiteBGSmallState();
}

class _TextFieldWithWhiteBGSmallState extends State<TextFieldWithWhiteBGSmall> {
  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(_deviceSize.height * 0.15),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: _deviceSize.width * 0.05),
        height: _deviceSize.height * 0.04,
        width: _deviceSize.width * 0.4,
        color: Colors.white.withOpacity(0.7),
        child: TextField(
          controller: widget.controller,
          cursorColor: Colors.brown,
          obscuringCharacter: '*',
          keyboardType: widget.isTypeInt == true
              ? TextInputType.number
              : TextInputType.text,
          obscureText: widget.isObscureText ? true : false,
          style: TextStyle(fontSize: _deviceSize.height * 0.02),
          maxLines: 1,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TextFeildBigWhiteBG extends StatefulWidget {
  final TextEditingController controller;
  final Size deviceSize;
  final isTypeInt;
  final hintText;
  final isObscureText;

  TextFeildBigWhiteBG({
    @required this.controller,
    @required this.deviceSize,
    @required this.isTypeInt,
    @required this.hintText,
    @required this.isObscureText,
  });
  @override
  _TextFeildBigWhiteBGState createState() => _TextFeildBigWhiteBGState();
}

class _TextFeildBigWhiteBGState extends State<TextFeildBigWhiteBG> {
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
        width: _deviceSize.width * 0.9,
        color: Colors.white.withOpacity(0.7),
        child: TextFormField(
          controller: widget.controller,
          cursorColor: Colors.brown,
          obscuringCharacter: '*',
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText,
          ),
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

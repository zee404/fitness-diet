import 'package:flutter/material.dart';

class TextFeildWitouthPrefix extends StatefulWidget {
  final TextEditingController controller;
  final Size deviceSize;
  final isTypeInt;
  final hintText;
  final isObscureText;

  TextFeildWitouthPrefix({
    @required this.controller,
    @required this.deviceSize,
    @required this.isTypeInt,
    @required this.hintText,
    @required this.isObscureText,
  });
  @override
  _TextFeildWitouthPrefixState createState() => _TextFeildWitouthPrefixState();
}

class _TextFeildWitouthPrefixState extends State<TextFeildWitouthPrefix> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: widget.deviceSize.width * 0.02),
      height: widget.deviceSize.height * 0.036,
      width: widget.deviceSize.width * 0.9,
    ///  color: Colors.white.withOpacity(0.7),
      child: ClipRRect(
        borderRadius:
            BorderRadius.all(Radius.circular(widget.deviceSize.height * 0.11)),
        child: Center(
          child: TextField(
            obscuringCharacter: '*',
            keyboardType: widget.isTypeInt == true
                ? TextInputType.number
                : TextInputType.text,
            style: TextStyle(fontSize: widget.deviceSize.height * 0.015),
            controller: widget.controller,
            obscureText: widget.isObscureText ? true : false,
            cursorColor: Colors.brown,
            decoration: InputDecoration(
              
              contentPadding: EdgeInsets.only(left: 20),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: Colors.brown.withOpacity(0.8),
                fontSize: widget.deviceSize.height * 0.015,
              ),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.deviceSize.height * 0.15),
                // borderSide: BorderSide(color: Colors.brown, width: 0.2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.deviceSize.height * 0.15),
                //   borderSide: BorderSide(color: Colors.brown, width: 0.3),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

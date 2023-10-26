import 'package:flutter/material.dart';

class StandardHeaderWithWhiteBG extends StatelessWidget {
  String passedText;
  StandardHeaderWithWhiteBG({@required this.passedText});
  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: _deviceSize.height * 0.017),
      height: _deviceSize.height * 0.07,
      //   width: widgetSize.width * 0.5,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0.00, 3.00),
            color: Color(0xff000000).withOpacity(0.16),
            blurRadius: 6,
          ),
        ],
      ),
      child: Center(
        child: Text(
          passedText,
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: _deviceSize.height * 0.03,
            color: Color(0xff030000),
          ),
        ),
      ),
    );
  }
}

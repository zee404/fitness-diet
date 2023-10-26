import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  String firstText;
  String secondText;
  String processText;
  Size deviceSize;

  AuthHeader(
      {@required this.firstText,
      @required this.processText,
      @required this.secondText,
      @required this.deviceSize});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          firstText.toUpperCase(),
          style: TextStyle(
            fontSize: deviceSize.height * 0.05,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Color(0xffA6714E),
          ),
        ),
        Text(
          secondText.toUpperCase(),
          style: TextStyle(
            fontSize: deviceSize.height * 0.05,
            fontFamily: 'Uni-Sans',
            color: Colors.black,
          ),
        ),
        Text(
          "Please $processText to continue.",
          style: TextStyle(
            fontSize: deviceSize.height * 0.02,
            fontFamily: 'Uni-Sans',
            color: Colors.brown,
          ),
        ),
      ],
    );
  }
}

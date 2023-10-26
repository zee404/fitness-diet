import 'package:flutter/material.dart';

class StepHeaderWithBG extends StatelessWidget {
  String stepsText;
  Size deviceSize;
  StepHeaderWithBG({@required this.stepsText, @required this.deviceSize});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown,
      height: deviceSize.height * 0.03,
      width: deviceSize.width,
      padding: EdgeInsets.all(deviceSize.width * 0.013),
      child: Text(
        stepsText,
        style: TextStyle(
          fontSize: deviceSize.height * 0.013,
          fontFamily: 'Montserrat',
          color: Colors.white,
        ),
      ),
    );
  }
}

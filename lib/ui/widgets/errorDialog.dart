import 'package:flutter/material.dart';

class ShowErrorDialog extends StatelessWidget {
  final String errorType;
  final String errorText;
  final Size deviceSize;
  final BuildContext context;

  ShowErrorDialog(
      {this.errorType,
      @required this.errorText,
      @required this.deviceSize,
      @required this.context});

  @override
  Widget build(BuildContext context) {
  //  return showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text(errorType),
  //         content: Text(errorText),
  //         actions: <Widget>[
  //           FlatButton(
  //               child: Text("OK"), onPressed: () => Navigator.pop(context)),
  //           FlatButton(
  //               child: Text("Cancel"), onPressed: () => Navigator.pop(context)),
  //         ],
  //       );
  //     },
  //   );
  }
}

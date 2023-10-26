import 'package:flutter/material.dart';

class ProfielHeaderText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Profile",
      style: TextStyle(
        color: Colors.white,
        fontSize: MediaQuery.of(context).size.height * 0.04,
        fontFamily: "Montserrat",
      ),
    );
  }
}

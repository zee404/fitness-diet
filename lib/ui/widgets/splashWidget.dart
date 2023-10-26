import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: must_be_immutable
class SplashWidget extends StatelessWidget {
  Size _deviceSize;
  SplashWidget({Size deviceSize}) : _deviceSize = deviceSize;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            overflow: Overflow.clip,
            children: [
              Text(
                "Diet",
                style: TextStyle(
                  fontFamily: "Lemon-Milk",
                  fontSize: _deviceSize.height * 0.1,
                  color: Color(0xffbc6e6e),
                  //    color: Colors.yellow),
                ),
              ),
              Text(
                "fitness",
                style: TextStyle(
                  fontFamily: "Curved-Square",
                  fontSize: _deviceSize.height * 0.03,
                  color: Color(0xffffffff),
                ),
              ),
            ],
          ),
          SpinKitFadingCube(
            size: 40,
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.grey : Colors.white,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

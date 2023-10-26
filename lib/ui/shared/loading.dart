import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;
    return Material(
      color: Colors.black12,
      child: SizedBox(
        height: _deviceSize.height,
        width: _deviceSize.width,
        child: SpinKitFadingCube(
          size: 30,
          itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: index.isEven ? Colors.grey : Colors.blueGrey,
              ),
            );
          },
        ),
      ),
    );
  }
}

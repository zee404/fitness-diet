import 'dart:async';

import 'package:fitness_diet/ui/responsive/responsiveBuilder.dart';
import 'package:fitness_diet/ui/views/homeview.dart';
import 'package:fitness_diet/ui/widgets/splashWidget.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

// TIMER FOR SPLASH SCREEN
  startTimer() async {
    var duration = Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => HomeView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Material(
          color: Colors.black,
          child: SplashWidget(
            deviceSize: sizingInformation.screenSize,
          ),
        );
      },
    );
  }
}

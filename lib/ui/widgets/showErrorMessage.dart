// import 'dart:async';

// import 'package:fitness_diet/core/constants/route_paths.dart';
// import 'package:fitness_diet/core/services/navigationService.dart';
// import 'package:fitness_diet/locator.dart';
// import 'package:flutter/material.dart';

// class ShowErrorMessage extends StatefulWidget {
//   String errorMessage;
//   String navigatorRoute;
//   ShowErrorMessage(
//       {@required this.errorMessage, @required this.navigatorRoute});
//   @override
//   _ShowErrorMessageState createState() => _ShowErrorMessageState();
// }

// class _ShowErrorMessageState extends State<ShowErrorMessage> {
  
// //   NavigationService nav = locator<NavigationService>();
// //   @override
// //   void initState() {
// //     super.initState();
// //     startTimer();
// //   }

// //   // @override
// //   // void dispose() {
// //   //   startTimer();
// //   //   super.dispose();
// //   // }

// //   Timer _timer;
// //   int _start = 10;

// //   // startTimer() {
// //   //   const oneSec = const Duration(seconds: 2);
// //   //   _timer = new Timer.periodic(
// //   //     oneSec,
// //   //     (Timer timer) => setState(
// //   //       () {
// //   //         if (_start < 1) {
// //   //           timer.cancel();
// //   //         } else {
// //   //           _start = _start - 1;
// //   //         }
// //   //       },
// //   //     ),
// //   //   );
// //   // }

// //   @override
// //   void dispose() {
// //     _timer.cancel();
// //     super.dispose();
// //   }
// // // // TIMER FOR SPLASH SCREEN
// //   startTimer() async {
// //     var duration = Duration(seconds: 2);
// //     return Timer(duration, _timer.cancel);
// // //   }

// // //   route() {
// // //     nav.navigateTo(widget.navigatorRoute);
// // //   }

//   @override
//   Widget build(BuildContext context) {
//     final _deviceSize = MediaQuery.of(context).size;
//     return Material(
//       color: Colors.transparent,
//       child: Container(
//         height: _deviceSize.height,
//         width: _deviceSize.width,
//         color: Colors.black38,
//         alignment: Alignment.bottomCenter,
//         child: Container(
//           width: _deviceSize.width,
//           height: _deviceSize.height * 0.07,
//           color: Colors.red.withOpacity(0.7),
//           alignment: Alignment.center,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.error,
//                 color: Colors.yellow,
//               ),
//               Text(
//                 widget.errorMessage,
//                 style: TextStyle(
//                   fontFamily: "Montserrat",
//                   color: Colors.white,
//                   fontSize: _deviceSize.height * 0.015,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

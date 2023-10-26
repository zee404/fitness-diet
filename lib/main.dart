import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_diet/core/constants/route_paths.dart' as routes;
import 'package:fitness_diet/core/managers/dialogManager.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/auth.dart';
import 'package:fitness_diet/core/services/navigationService.dart';
import 'package:fitness_diet/locator.dart';
import 'package:fitness_diet/ui/router.dart' as router;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// void main() {
//   setupLocator();
//   // runApp(MyApp());
//   runApp(
//     MaterialApp(
//       home: Scaffold(
//         body: DevicePreview(
//           enabled: false,
//           builder: (context) => MyApp(),
//         ),
//       ),
//     ),
//   );
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ignore: unused_local_variable
  FirebaseApp myApp = await Firebase.initializeApp();

  setupLocator();
  // runApp(MyApp());
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: DevicePreview(
          enabled: false,
          builder: (context) => MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CurrentUser>(
      initialData: CurrentUser.initial(),
      create: (BuildContext context) => locator<AuthService>().user,
      child: MaterialApp(
        // builder: (context, widget) => Navigator(
        //   onGenerateRoute: (settings) => MaterialPageRoute(
        //     builder: (context) => DialogManager(
        //       child: widget,
        //     ),
        //   ),
        // ),

        builder: (context, widget) => DialogManager(
          child: widget,
        ),

        //  builder: DevicePreview.appBuilder,

        title: 'Fitness Diet',
        theme: ThemeData(),
        initialRoute: routes.SplashRoute,
        navigatorKey: locator<NavigationService>().navigatorKey,
        onGenerateRoute: router.Router.generateRoute, // NEW CHANGE
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resources/routes_manager.dart';
import 'package:tut_app/presentation/resources/theme_manager.dart';
// class MyApp extends StatefulWidget {
//    const MyApp._internal();
//
//   static const MyApp instance = MyApp._internal();
//
//   factory MyApp() => instance;
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       onGenerateRoute: RouteGenerator.getRoute,
//       initialRoute: Routes.splashRoute,
//       theme: getApplicationTheme(),
//     );
//   }
// }
class MyApp extends StatefulWidget {
  MyApp._internal(); // private named constructor
  int appState = 0;
  static final MyApp instance =
  MyApp._internal(); // single instance -- singleton

  factory MyApp() => instance; // factory for the class instance

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}
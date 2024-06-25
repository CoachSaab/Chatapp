import 'package:demo/assignment.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'Chartapp/Screens/Auth/Splash_screen.dart';
import 'firebase_options.dart';
import 'assignment2.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp()); }

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
    )


    ),
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen()
    );
  }
}

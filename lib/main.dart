import 'package:crudmahasiswasqflite/Screens/HomeScreen.dart';
import 'package:crudmahasiswasqflite/Screens/Splash_Screen.dart';
import 'package:crudmahasiswasqflite/Screens/SignInScreen.dart';
import 'package:crudmahasiswasqflite/Screens/SignUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CRUD SQFLite',
      theme: ThemeData(primarySwatch: Colors.grey),
      routes: {
        '/': (context) => SplashScreen(),
        '/SignUpScreen': (context) => SignUpScreen(),
        '/HomeScreen': (context) => HomeScreen(),
        '/SignInScreen': (context) => SignInScreen(),
        // '/HomeScreen': (context) => HomeScreen(),
      },
    );
  }
}

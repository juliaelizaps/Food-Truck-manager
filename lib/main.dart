import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_1/loginpage.dart';
import 'package:projeto_1/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.red,
        appBarTheme: const AppBarTheme(
          color: Colors.red,
        )
      ),
      home: const LoginPage(),
      //home: const HomePage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gf/pages/loginpage.dart';

import ' widgets/ex_page.dart';



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
        ),
      ),
      home: const LoginPage(),
      //ExamplePage(),
    );
  }
}

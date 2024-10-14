import 'package:flutter/material.dart';

class PasswordVisibilityController extends StatefulWidget {
  final Widget Function(bool obscureText, VoidCallback toggleVisibility) builder;

  const PasswordVisibilityController({Key? key, required this.builder}) : super(key: key);

  @override
  _PasswordVisibilityControllerState createState() => _PasswordVisibilityControllerState();
}

class _PasswordVisibilityControllerState extends State<PasswordVisibilityController> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_obscureText, _toggleVisibility);
  }
}

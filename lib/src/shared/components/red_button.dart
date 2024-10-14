import 'package:flutter/material.dart';
import '../colors/colors.dart';

class RedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const RedButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: 50,
      color: AppColors.buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.initialPageTextColor,
            fontWeight: FontWeight.normal,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

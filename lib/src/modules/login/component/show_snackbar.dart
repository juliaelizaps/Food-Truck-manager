import 'package:flutter/material.dart';
import 'package:gf/src/shared/colors/colors.dart';

showSnackBar({required BuildContext context, required String message, bool isError = true}){
  SnackBar snackBar = SnackBar(
    content: Text(message),
    backgroundColor: (isError)? AppColors.snackBarError: AppColors.snackBarSuccess,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
import 'package:flutter/material.dart';

class snackbarUsabel{
  static showSnackbar(BuildContext context,String message){
    final sncakBar=SnackBar(
      content:Text(message),
      duration: Duration(seconds: 5),
      behavior: SnackBarBehavior.fixed, );
  ScaffoldMessenger.of(context).showSnackBar(sncakBar);
  }
}
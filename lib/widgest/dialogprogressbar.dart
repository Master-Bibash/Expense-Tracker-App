import 'package:flutter/material.dart';

class DialogProgressBar{
  static showDialogProgressbar(BuildContext context){
    showDialog(context: context,
    barrierDismissible: false,
     builder: (context) {
      return AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text("Requesting")
          ],
        ),
      );

     },);
  }
  static hideLoadingDailog(BuildContext context){
    Navigator.of(context).pop();
  }
}
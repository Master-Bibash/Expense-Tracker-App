import 'package:flutter/material.dart';

class ChangeSelectedCategory with ChangeNotifier{
  String selectedvalue="Food";
  void changeCategory(String value){
    selectedvalue=value;
    notifyListeners();
  }
}
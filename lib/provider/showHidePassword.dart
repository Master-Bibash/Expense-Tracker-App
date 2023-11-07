import 'package:flutter/material.dart';

class ShowHidePassword with ChangeNotifier{
  bool isHidden=true;
  void changeStatus(){
    isHidden = !isHidden;
    notifyListeners();
  }
}
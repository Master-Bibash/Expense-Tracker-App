import 'package:flutter/material.dart';

class DateSelectorProvider with ChangeNotifier{
  final String currentDate=DateTime.now().year.toString();
}
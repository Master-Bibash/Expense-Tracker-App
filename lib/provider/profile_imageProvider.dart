import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImageProvider with ChangeNotifier{
  XFile? filePath;
  void selectedImage(XFile file){
    filePath=file;
    notifyListeners();
  }

}
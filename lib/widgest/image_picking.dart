import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/provider/profile_imageProvider.dart';
import 'package:project/widgest/snakbar.dart';
import 'package:provider/provider.dart';

class ImagepickerProfile{
  static ImagePicker picker=ImagePicker();
  static XFile? imagepath;
  static BottomSheet(BuildContext context){
    ProfileImageProvider profileImageProvider=Provider.of<ProfileImageProvider>(context,listen: false);
    showModalBottomSheet(context: context, builder:(context) {
      return Column(
        children: [
          ListTile(
            leading: Icon(Icons.image),
            onTap: () async{
              imagepath=await picker.pickImage(source: ImageSource.gallery);
              if (imagepath.runtimeType!=Null) {
                profileImageProvider.selectedImage(imagepath!);
                if (context.mounted) {
                  Navigator.of(context).pop();
                  
                }
                
              }else{
                if (context.mounted) {
                  snackbarUsabel.showSnackbar(context,"Task failed");
                  Navigator.of(context);                  
                }
              }
            },
            title: Text("Select image"),
          )

        ],
      );
    },);
  }
}
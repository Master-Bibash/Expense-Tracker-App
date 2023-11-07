import 'package:flutter/material.dart';

class UserLogout{
  static askLOgout(BuildContext context){
    showDialog(context: context,
     builder: (context) {
      return Container(
        padding: EdgeInsets.all(10),
        child: AlertDialog(
          title: Text("You sure you wanna logout?",
          style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context); //close the dialog box
            },
             child: Text("Nah!",style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color: Colors.black))),
             TextButton(onPressed: ()async{
              Navigator.pushNamedAndRemoveUntil(context, "/splashscreen", (route) => false);
      
             },
              child: Text("yeah!",style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color: Colors.black),)),
              SizedBox(height: 5,),
          ],
        ),
      );
     },);
  }
}
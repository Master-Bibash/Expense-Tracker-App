import 'package:flutter/material.dart';
import 'package:project/constants/text_style.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
        body: ListView(
      children: [
        Container(
            height: size.height * 0.60,
            width: size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.fitHeight),
            )),
        SizedBox(
          height: 30,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              "Make Your Every penny count",
              style: splashScreenTextStyleMain,
              textAlign: TextAlign.center,
            ),
             SizedBox(
              height: 30,
            ),
            Text("Your Every money matters \nso make sure it is spent right",
            style: splashScreenTextStyleSubtitle,
            ),
               SizedBox(
              height: size.height*0.04,
            ),
         
             SizedBox(
              width: size.width*0.70,
              height: size.height*0.07,
              child: ElevatedButton(onPressed: (){
                
                Navigator.pushReplacementNamed(context,'/loginPage');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: StadiumBorder()
              ),
               child: Text("Login",
               style: TextStyle(fontSize: 17,fontWeight: FontWeight.normal, ),
               
               )),
            ),
            SizedBox(height: 10,)

          ],
        )
      ],
    ));
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/provider/changeindexProvider.dart';
import 'package:project/provider/changeselectedcategory.dart';
import 'package:project/provider/dateSelector.dart';
import 'package:project/provider/profile_imageProvider.dart';
import 'package:project/provider/showHidePassword.dart';
import 'package:project/screens/forgotpasswordScreen.dart';
import 'package:project/screens/loginPage.dart';
import 'package:project/screens/myhomePage.dart';
import 'package:project/screens/signUpPage.dart';
import 'package:project/screens/splashscreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: "AIzaSyBIMzHhEWIqltwgrJJJvfgnC-0U1CrejAo",
   appId: "1:285723870124:android:f0f2154fb1f3543847b009",
    messagingSenderId: "285723870124",
     projectId: "projecttracker-1a35b"),

  
);

  print("Firebase initialized"); // Add this line to print the message

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ChangeIndexProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileImageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChangeSelectedCategory(),
        ),
        ChangeNotifierProvider(
          create: (context) => DateSelectorProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ShowHidePassword(),
        ),
      ],
      child: MaterialApp(
        
        debugShowCheckedModeBanner: false,
        title: "Expense Tracker",
        routes: {
          "/splashscreen": (context) => const SplashScreen(),
          "/loginPage": (context) => const LoginPage(),
          "/signUpPage": (context) => const SignUpPage(),
          "/forgotPasswordPage": (context) => const ForgotPasswordScreen(),
          "/myhomepage": (context) => const MyHomePage(),
          
        },
        initialRoute: "/splashscreen",
        theme: ThemeData(
          
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.blue[200],
            centerTitle: true,
          ),
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}

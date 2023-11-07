import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;


class AuthController extends GetxController {
  static void loginUser(String email, String password, BuildContext context) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Login successful"),
      ));
      Navigator.pushReplacementNamed(context, "/myhomepage");
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Error: ${e.code}, ${e.message}");
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showLoginFailureDialog(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.message.toString()),
        ));
      }
  } catch (e) {
      print("An error occurred: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("An error occurred: $e"),
      ));
    }
  } 
   static void showLoginFailureDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Login Failed"),
          content: Text("Invalid email or password. Please try again."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
  

  static void createUser(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Account created"),
      ));
      Navigator.pushReplacementNamed(context, "/loginPage");
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Error: ${e.code}, ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message.toString()),
      ));
    } catch (e) {
      print("An error occurred: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("An error occurred: $e"),
      ));
    }
  }

  static void sendResetLink(String email, BuildContext context) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Reset link sent successfully. Check your email."),
      ));
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Error: ${e.code}, ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message.toString()),
      ));
    } catch (e) {
      print("An error occurred: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to send reset link email: $e"),
      ));
    }
  }
}

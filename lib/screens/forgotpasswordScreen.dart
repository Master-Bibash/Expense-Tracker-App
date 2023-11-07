import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project/controller/auth_controller.dart';
import 'package:project/validations/emailValidation.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController resetEmailController = TextEditingController();

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    resetEmailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            width: size.width,
            height: size.height * 0.55,
            child: Lottie.asset("assets/animation/forgot.json"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: globalKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: resetEmailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email is required";
                      } else if (!EmailValidation.validateRmail(value)) {
                        return "Invalid email format";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Enter Your Email",
                      prefixIcon: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(
                          Icons.mail_outline,
                          color: Colors.grey,
                        ),
                      ),
                      labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 39, 41, 43),
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 4,
                          color: Colors.orange,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(onPressed: (){
                    Navigator.pushNamed(context, "/loginPage");
                  }, 
                  child: const Text("Back to Login")),

              
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: size.width * 0.80,
                    height: size.height * 0.07,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (globalKey.currentState!.validate()) {
 AuthController.sendResetLink(resetEmailController.text, context);
                        resetEmailController.clear();
                          
                        }
                     
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        shape: const StadiumBorder(),
                      ),
                      child: const Text(
                        "Send reset link",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

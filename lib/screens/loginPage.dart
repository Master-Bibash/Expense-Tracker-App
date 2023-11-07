import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project/controller/auth_controller.dart';
import 'package:project/provider/showHidePassword.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
        body: ListView(
      children: [
        SizedBox(
          width: size.width,
          height: size.height * 0.55,
          child: Lottie.asset("assets/animation/loginanimation.json"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Form(
            key: globalKey,
            child: Column(
              children: [
                TextFormField(
                  textInputAction: TextInputAction.next,

                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter fill email";
                      } else {
                        return null;
                      }
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
                          fontSize: 14),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2, color: Colors.greenAccent),
                          borderRadius: BorderRadius.circular(50)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 4, color: Colors.orange),
                          borderRadius: BorderRadius.circular(50)),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Consumer<ShowHidePassword>(builder: (context, value, child) {
                  return TextFormField(
                    textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter fill password";
                        } else {
                          return null;
                        }
                      },
                      controller: passwordController,
                      obscureText: value.isHidden,
                      decoration: InputDecoration(
                        
                        labelText: "Enter Your password",
                        prefixIcon: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            value.changeStatus();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: value.isHidden
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: Colors.grey,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: Colors.grey,
                                  ),
                          ),
                        ),
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 39, 41, 43),
                            fontStyle: FontStyle.normal,
                            fontSize: 14),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 2, color: Colors.greenAccent),
                            borderRadius: BorderRadius.circular(50)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 4, color: Colors.orange),
                            borderRadius: BorderRadius.circular(50)),
                      ));
                }),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/forgotPasswordPage");
                        },
                        child: const Text(
                          "Forgot Password",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.underline),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/signUpPage");
                        },
                        child: const Text(
                          "New Account !",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: size.width * 0.70,
                  height: size.height * 0.07,
                  child: ElevatedButton(
                      onPressed: () {
                        if (globalKey.currentState!.validate()) {
                          // ignore: non_constant_identifier_names
                          AuthController.loginUser(emailController.text.trim(),
                              passwordController.text, context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: const StadiumBorder()),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                        ),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}

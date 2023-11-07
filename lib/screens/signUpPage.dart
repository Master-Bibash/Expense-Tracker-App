import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project/controller/auth_controller.dart';
import 'package:project/provider/showHidePassword.dart';
import 'package:project/validations/emailValidation.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  void dispose() {
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
            child: Lottie.asset("assets/animation/signup.json"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
                key: globalKey,
                child: Column(
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.next,
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            final message =
                                EmailValidation.validateRmail(value);
                            return message;
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
                                  width: 2, color: Colors.blue),
                              borderRadius: BorderRadius.circular(50)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 4, color: Colors.orange),
                              borderRadius: BorderRadius.circular(50)),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<ShowHidePassword>(
                        builder: (context, value, child) {
                      return TextFormField(
                        textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter password';
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
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
                                    width: 2, color: Colors.blue),
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
                    Consumer<ShowHidePassword>(
                        builder: (context, value, child) {
                      return TextFormField(
                                                textInputAction: TextInputAction.done,

                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter fill password";
                            } else {
                              return null;
                            }
                          },
                          controller: confirmpassword,
                          obscureText: value.isHidden,
                          decoration: InputDecoration(
                            labelText: "Confirm Your password",
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
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
                                    width: 2, color: Colors.blue),
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
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Already have an account",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.underline),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: size.width * 0.80,
                      height: size.height * 0.07,
                      child: ElevatedButton(
                          onPressed: () {
                            if (globalKey.currentState!.validate()) {
                              if (globalKey.currentState!.validate()) {
                                if (passwordController.text
                                        .compareTo(confirmpassword.text) ==
                                    0) {
                                  AuthController.createUser(
                                      emailController.text.trim(),
                                      passwordController.text,
                                      context);
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          title: Text("Alert!"),
                                          content:
                                              Text("Please Match the password"),
                                        );
                                      });
                                }
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: const StadiumBorder()),
                          child: const Text(
                            "SignUp",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                          )),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:project/controller/auth_controller.dart';
import 'package:project/provider/profile_imageProvider.dart';
import 'package:provider/provider.dart';

class FirstHomePage extends StatefulWidget {
  const FirstHomePage({Key? key}) : super(key: key);

  @override
  _FirstHomePageState createState() => _FirstHomePageState();
}

class _FirstHomePageState extends State<FirstHomePage> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot>? stream;
    if (auth.currentUser != null) {
      stream = FirebaseFirestore.instance
          .collection(auth.currentUser!.uid)
          .snapshots();
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Icon(
            Icons.home,
            color: Colors.grey[700],
          ),
        ),
        title: Text(
          "Home Screen",
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 10),
            child: Consumer<ProfileImageProvider>(
              builder: (context, value, child) {
                return value.filePath == null
                    ? const CircleAvatar(
                        backgroundColor: Colors.pink,
                      )
                    : CircleAvatar(
                        backgroundImage: FileImage(
                          File(value.filePath!.path),
                        ),
                      );
              },
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          var size = MediaQuery.of(context).size;

          return Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    "Hello, ${extractNameFromEmail(auth.currentUser?.email!.toUpperCase()) ?? "GUEST"}",
                    style: GoogleFonts.notoSerif(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    "Your every expense is under your control",
                    style: GoogleFonts.notoSerif(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Text(
                    "Your Spendings",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSerif(
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  // Adjust the height as needed
                  child: Center(
                    child: StreamBuilder(
                      stream: stream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.data == null) {
                          return SizedBox(
                         height: constraints.maxHeight * 0.3,
                            child: LottieBuilder.asset("assets/animation/errorShow.json"),
                          );
                        } else if (!snapshot.hasData) {
                          return SizedBox(
                          height: constraints.maxHeight * 0.3,
                            child: LottieBuilder.asset("assets/animation/errorShow.json"),
                          );
                        } else {
                          if (snapshot.data!.docs.isEmpty) {
                            return ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: [
                                SizedBox(
                                  height: constraints.maxHeight * 0.3,
                                  child: LottieBuilder.asset("assets/animation/errorShow.json"),
                                ),
                                Center(
                                  child: Text(
                                    "No data to show",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            );
                          } else {
                            final data = snapshot.requireData;
                            return SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: data.size,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.all(10),
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      color: Colors.white60,
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: ListTile(
                                      
                                      contentPadding: const EdgeInsets.only(left: 20),
                                      title: Text(
                                        data.docs[index]["expenseTitle"],
                                        style: GoogleFonts.notoSerif(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        data.docs[index]["expensedate"],
                                        style: GoogleFonts.notoSerif(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      trailing: Padding(
                                        padding: const EdgeInsets.only(right: 5),
                                        child: Text(
                                          data.docs[index]["expenseAmount"],
                                          style: GoogleFonts.notoSerif(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                ),
           SizedBox(
             height: constraints.maxHeight * 0.3,
           ),
              
              ],
            ),
          );
        },
      ),
    );
  }

  String? extractNameFromEmail(String? email) {
    if (email == null) return null;
    final part = email.split("@");
    if (part.length >= 1) {
      return part[0];
    }
    return email;
  }
}

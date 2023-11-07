import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:project/controller/auth_controller.dart';

class FourthPage extends StatefulWidget {
  const FourthPage({Key? key});

  @override
  State<FourthPage> createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  final datastream = FirebaseFirestore.instance.collection(auth.currentUser!.uid).snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Icon(
            Icons.monetization_on_sharp,
            color: Colors.grey[700],
          ),
        ),
        title: Text(
          "Add Transactions",
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Your Expenses Data",
              style: GoogleFonts.lateef(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            StreamBuilder(
              stream: datastream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text("An error occurred"));
                } else {
                  var expenses = snapshot.data!.docs;
                  Map<String, double> titleTotal = {};
                  for (var expense in expenses) {
                    var data = expense.data();
                    var title = data["expensecategory"];
                    var amount = data["expenseAmount"];
                    if (titleTotal[title] != null) {
                      titleTotal[title] = (titleTotal[title] ?? 0) + double.parse(amount);
                    } else {
                      titleTotal[title] = double.parse(amount);
                    }
                  }

                  if (titleTotal.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          Lottie.asset("assets/animation/chart.json"), // Show the Lottie animation
                          Text(
                            "The expenses are empty",
                            style: GoogleFonts.lateef(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.63,
                      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                      child: PieChart(
                        dataMap: titleTotal,
                        animationDuration: const Duration(seconds: 2),
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

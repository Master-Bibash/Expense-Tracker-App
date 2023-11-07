import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:project/controller/addexpensecontroller.dart';
import 'package:project/controller/auth_controller.dart';
import 'package:project/screens/editscreen.dart';

class SecondHomePage extends StatefulWidget {
  const SecondHomePage({super.key});

  @override
  State<SecondHomePage> createState() => _SecondHomePageState();
}

class _SecondHomePageState extends State<SecondHomePage> {
  Stream<QuerySnapshot> dataStream =
      FirebaseFirestore.instance.collection(auth.currentUser!.uid).snapshots();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
         backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 24),
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
      body: StreamBuilder(
        stream: dataStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text("No data found !"),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.requireData;
            if (data.size == 0) {
              return Center(
                child: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Lottie.asset("assets/animation/noitem.json"),
                ),
              );
            } else {
              return Padding(
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 8,
                      shadowColor: Colors.black,
                      child: Container(
                        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                        height: size.height * 0.30,
                        width: size.width,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.credit_card_rounded),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Align(
                                  child: Text(
                                      "Your made a purchase of ${data.docs[index]["expenseTitle"]}",
                                       style: GoogleFonts.notoSerif(fontSize: 14,fontWeight: FontWeight.bold),
                                      ),
                                  alignment: Alignment.topLeft,
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(Icons.attach_money_outlined),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Align(
                                  child: Text( data.docs[index]["expenseAmount"],  style: GoogleFonts.notoSerif(fontSize: 14,fontWeight: FontWeight.bold),),
                                  alignment: Alignment.topLeft,
                                )),
                              ],
                            ),
                             SizedBox(
                              height: 10,
                            ),
                             Row(
                              children: [
                                Icon(Icons.calendar_month_rounded),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Align(
                                  child: Text(
                                      "Date is ${data.docs[index]["expensedate"]}",  style: GoogleFonts.notoSerif(fontSize: 14,fontWeight: FontWeight.bold),),
                                  alignment: Alignment.topLeft,
                                )),
                              ],
                            ),
                               SizedBox(
                              height: 10,
                            ),
                             Row(
                              children: [
                                Icon(Icons.arrow_forward_ios),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Align(
                                  child: Text(
                                      "Category ${data.docs[index]["expensecategory"]}",  style: GoogleFonts.notoSerif(fontSize: 14,fontWeight: FontWeight.bold),),
                                  alignment: Alignment.topLeft,
                                )),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    showDialog(context: context, builder: (context) {
                                      return AlertDialog(
                                        title: Text("You sure you want to delete this?",
                                        style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                                        actions: [
                                          TextButton(onPressed: ()async{
                                            await AddExpense().deleteExpense(snapshot.data!.docs[index].id, context);
                                            
                                          },
                                          
                                           child: Text("Yeah !")),
                                           TextButton(onPressed: (){
                                            Navigator.of(context).pop();
                                           },
                                            child: Text("Nah !"))
              
                                        ],
                                      );
                                    },);
                                  },
                                  child: Icon(Icons.delete_outline),
                               
                                ),
                                IconButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditScreen(
                                    title: data.docs[index]["expenseTitle"],
                                   date: data.docs[index]["expensedate"],
                                    amount: data.docs[index]["expenseAmount"],
                                     id: snapshot.data!.docs[index].id) ,));
                                },
                                 icon: Icon(Icons.edit))
              
                              ],
                            )
              
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

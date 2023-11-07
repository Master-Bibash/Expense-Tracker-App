import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/controller/auth_controller.dart';
import 'package:project/widgest/dialogprogressbar.dart';
import 'package:project/widgest/snakbar.dart';

class AddExpense{

  FirebaseFirestore firestore=FirebaseFirestore.instance;
  addExpenseDetails(
    String title,
    String amount,
      String category,
    String date,
      BuildContext context,
    TextEditingController titleController,
    TextEditingController amountController

  )async{
    try {
      DialogProgressBar.showDialogProgressbar(context);
      await firestore.collection(auth.currentUser!.uid).doc().set(
        {
          "expenseTitle":title,
          "expenseAmount":amount,
          "expensecategory":category,
          "expensedate":date,

        }
      ).then((value) {
        DialogProgressBar.hideLoadingDailog(context);
        snackbarUsabel.showSnackbar(context,"Expenses Added");
        titleController.clear();
        amountController.clear();
      });
      
    } catch (e) {
      if (context.mounted) {
        DialogProgressBar.hideLoadingDailog(context);
        
      }
      
    }
  }
  deleteExpense(String id,BuildContext context){
    firestore.collection(auth.currentUser!.uid).doc(id).delete().then((value) {
      Navigator.of(context).pop();
      snackbarUsabel.showSnackbar(context, "Deleted Data");

    }).onError((error, stackTrace) {
      snackbarUsabel.showSnackbar(context,"Failed to delete the entry");
    });
  }
  updateEntry(
    String title,
    String amount,
    String category,
    String date,
    String id,
    BuildContext context,
  ){
    firestore.collection(auth.currentUser!.uid).doc(id).update({
      "expenseTitle":title,
      "expenseAmount":amount,
      "expensecategory":category,
      "expensedate":date,
    }).then((value) {
      snackbarUsabel.showSnackbar(context,"Expense Deleted");
      Navigator.of(context).pop();

    }).onError((error, stackTrace) {
      snackbarUsabel.showSnackbar(context, "Error on updaing");
    });
  }
}
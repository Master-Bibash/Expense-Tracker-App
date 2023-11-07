import 'package:flutter/material.dart';
import 'package:project/controller/addexpensecontroller.dart';
import 'package:project/provider/dateSelector.dart';
import 'package:project/validations/normaltextvalidate.dart';
import 'package:project/widgest/snakbar.dart';
import 'package:provider/provider.dart';

import '../provider/changeselectedcategory.dart';

class ThirdHomepage extends StatefulWidget {
  const ThirdHomepage({Key? key}) : super(key: key);

  @override
  State<ThirdHomepage> createState() => _ThirdHomepageState();
}

class _ThirdHomepageState extends State<ThirdHomepage> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  List<String> category = [
    "Food",
    "Transportation",
    "Education",
    "Entertainment",
    "Others"
  ];
  String? first;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    first = category.first;
  }

  @override
  Widget build(BuildContext context) {
    ChangeSelectedCategory selectedCategory =
        Provider.of<ChangeSelectedCategory>(context, listen: false);

    var size = MediaQuery.sizeOf(context);
    DateSelectorProvider dateSelectorProvider =
        Provider.of<DateSelectorProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 24),
          child: Icon(
            Icons.add_circle_outlined,
            color: Colors.grey[700],
          ),
        ),
        title: Text(
          "Make a Transactions",
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
            key: globalKey,
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                                          textInputAction: TextInputAction.next,

                  maxLength: 20,
                  validator: (value) {
                    final message =
                        normaTextvalidate().valdiateNOrmalText(value!);
                    return message;
                  },
                  controller: titleController,
                  // textCapitalization: t,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.description_outlined),
                      labelText: 'Enter title of your expense',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                TextFormField(
                                          textInputAction: TextInputAction.next,

                  maxLength: 20,
                  validator: (value) {
                    final message =
                        normaTextvalidate().valdiateNOrmalText(value!);
                    return message;
                  },
                  controller: amountController,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.attach_money_rounded),
                      labelText: 'Enter amount',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Consumer<ChangeSelectedCategory>(
                    builder: (context, value, child) {
                      return DropdownButton(
                        iconSize: 20,
                        icon: Icon(Icons.arrow_drop_down),
                        padding: EdgeInsets.only(left: 10),
                        value: value.selectedvalue,
                        isExpanded: true,
                        items: category.map((e) {
                          return DropdownMenuItem(value: e, child: Text(e));
                        }).toList(),
                        onChanged: (selectedItem) {
                          value.changeCategory(selectedItem!);
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Consumer<DateSelectorProvider>(
                  builder: (context, value, child) {
                    return Card(
                      elevation: 1,
                      child: ListTile(
                        leading: Icon(Icons.date_range_rounded),
                        title: Text(dateSelectorProvider.currentDate),
                        onTap: () async {
                          showDatePicker(
                              context: context,
                              initialDate: DateTime(DateTime.now().year,
                                  DateTime.now().month, DateTime.now().day),
                              firstDate: DateTime(DateTime.now().year),
                              lastDate: DateTime(
                                DateTime.now().year + 1,
                              )).then((value) {
                            dateSelectorProvider.changeCurrentDate(
                                value.toString().substring(0, 10));
                          }).onError((error, stackTrace) {
                            snackbarUsabel.showSnackbar(
                                context, "Please select date");
                          });
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: size.height * 0.06,
                ),
                SizedBox(
                  width: size.width * 0.80,
                  height: size.height * 0.07,
                  child: ElevatedButton(
                      onPressed: () {
                        if (globalKey.currentState!.validate()) {
                          try {
                            AddExpense().addExpenseDetails(
                                titleController.text.trim(),
                                amountController.text.trim(),
                                selectedCategory.selectedvalue,
                                dateSelectorProvider.currentDate,
                                context,
                                titleController,
                                amountController);
                          } catch (e) {
                            snackbarUsabel.showSnackbar(
                                context, "An error occured");
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: const StadiumBorder()),
                      child: const Text(
                        "Add expense",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                        ),
                      )),
                ),
              ],
            )),
      )),
    );
  }
}

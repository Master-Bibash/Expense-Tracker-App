import 'package:flutter/material.dart';
import 'package:project/controller/addexpensecontroller.dart';
import 'package:project/provider/changeselectedcategory.dart';
import 'package:project/provider/dateSelector.dart';
import 'package:project/validations/normaltextvalidate.dart';
import 'package:project/widgest/snakbar.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key, required this.title, required this.date, required this.amount, required this.id});
  final String title;
  final String date;
  final String amount;
  final String id;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController newTitleControl=TextEditingController();
  TextEditingController newAmountControl=TextEditingController();
GlobalKey<FormState> globalKey=GlobalKey<FormState>();

List<String> category=[
   "Food",
    "Transportation",
    "Education",
    "Entertainment",
    "Others",
];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    newAmountControl.text=widget.title;
    newAmountControl.text=widget.amount;
  }

  @override
  Widget build(BuildContext context) {
    ChangeSelectedCategory selectedCategory=Provider.of<ChangeSelectedCategory>(context,listen: false);
    DateSelectorProvider dateSelectorProvider=Provider.of<DateSelectorProvider>(context,listen: false);
    var size=MediaQuery.sizeOf(context);
  

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 24),
          child: IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
          icon: Icon(  Icons.arrow_back_ios_outlined,
            color: Colors.grey[700],),
          ),
        ),
        title: Text(
          "Edit Screen",
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
        centerTitle: false,
       
      ),
      body:SafeArea(
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Form(
          key: globalKey,
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              TextFormField(
                maxLength: 20,
                validator: (value) {
                  final message=normaTextvalidate().valdiateNOrmalText(value!);
                  return message;
                },
                controller: newTitleControl,
                // textCapitalization: t,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.description_outlined),
                  labelText: 'Enter title of your expense',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),
            SizedBox(
                  height: size.height * 0.03,
                ),
               TextFormField(
                maxLength: 20,
                validator: (value) {
                  final message=normaTextvalidate().valdiateNOrmalText(value!);
                  return message;
                },
                controller: newAmountControl,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.attach_money_rounded),
                  labelText: 'Enter amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),
              SizedBox(
                  height: size.height * 0.03,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Consumer<ChangeSelectedCategory>(builder:(context, value, child){
                    return DropdownButton(
                      iconSize: 20,
                      icon: Icon(Icons.arrow_drop_down),
                      padding: EdgeInsets.only(left: 10),
                      value: value.selectedvalue,
                      isExpanded: true,

                      items: category.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e)
                          );
                      }).toList(),
                     onChanged: (selectedItem) {
                      value.changeCategory(selectedItem!);

                     },);

                  },),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Consumer<DateSelectorProvider>(builder: (context, value, child) {
                  return Card(
                    elevation: 1,
                    child: ListTile(
                      leading: Icon(Icons.date_range_rounded),
                      title: Text(dateSelectorProvider.currentDate),
                      onTap: ()async{
                        showDatePicker(context: context,
                         initialDate: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day),
                          firstDate: DateTime(DateTime.now().year),
                           lastDate: DateTime(DateTime.now().year+1,)).then((value) {
                            dateSelectorProvider.changeCurrentDate(value.toString().substring(0,10));
                           }).onError((error, stackTrace) {
                            snackbarUsabel.showSnackbar(context,"Please select date");
                           });
                      },
                    ),
                  );
                },), SizedBox(
                  height: size.height * 0.03,
                ),
                  SizedBox(
                      width: size.width * 0.80,
                      height: size.height * 0.07,
                      child: ElevatedButton(
                          onPressed: () {
                            if (globalKey.currentState!.validate()) {
                              try {
                              AddExpense().updateEntry(
                                newTitleControl.text.trim(),
                               newAmountControl.text.trim(),
                                selectedCategory.selectedvalue,
                                 dateSelectorProvider.currentDate
                                  ,widget.id,context);
                                

                              } catch (e) {
                                snackbarUsabel.showSnackbar(context,"An error occured");
                                
                              }
                            
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: const StadiumBorder()),
                          child: const Text(
                            "Update",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                          )),
                    ),

            ],
          )),)
      ),
    );
  }
}
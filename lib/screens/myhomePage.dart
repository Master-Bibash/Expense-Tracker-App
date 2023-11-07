import 'package:flutter/material.dart';
import 'package:project/homescreen screen/FourthPage.dart';
import 'package:project/homescreen screen/ThirdHomePage.dart';
import 'package:project/homescreen screen/SecondPage.dart';
import 'package:project/homescreen screen/Profile.dart';
import 'package:project/homescreen%20screen/first.dart';
import 'package:project/provider/changeindexProvider.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: const [
          FirstHomePage(),
          SecondHomePage(),
          ThirdHomepage(),
          FourthPage(),
          Profile(),
        ],
      ),
      bottomNavigationBar: Consumer<ChangeIndexProvider>(
        builder: (context, value, child) {
          return Container(
            
            height: size.height*0.10,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: BottomNavigationBar(
              
              fixedColor: Colors.white,
              iconSize: 22,
              selectedFontSize: 10,
              elevation: 0,
              currentIndex: value.currentIndex,
              onTap: (index) {
                value.changeIndex(index);
                pageController.jumpToPage(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: 'Home',
                  backgroundColor: Colors.black,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.monetization_on_sharp),
                  label: 'Transactions',
                  backgroundColor: Colors.black,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle_outlined),
                  label: 'Add Transaction',
                  backgroundColor: Colors.black,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.start_sharp),
                  label: 'Statistics',
                  backgroundColor: Colors.black,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                  backgroundColor: Colors.black,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

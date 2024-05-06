import 'package:expense_tracker_app/resources/theme.dart';
import 'package:expense_tracker_app/views/add_expense.dart';
import 'package:expense_tracker_app/views/add_income.dart';
import 'package:expense_tracker_app/views/budget_screen.dart';
import 'package:expense_tracker_app/views/home_screen.dart';
import 'package:expense_tracker_app/views/profile_screen.dart';
import 'package:expense_tracker_app/views/report_screen.dart';
import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;

  @override
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      // floatingActionButton: FabCircularMenuPlus(
      //     fabSize: 50,
      //     fabColor: Color(0xff95AEEE),
      //     fabOpenIcon: Icon(
      //       Icons.add,
      //       color: Colors.white,
      //     ),
      //     fabCloseIcon: Icon(
      //       Icons.close,
      //       color: Colors.white,
      //     ),
      //     ringColor: Color(0xff95AEEE),
      //     ringDiameter: 170,
      //     ringWidth: 40,
      //     children: <Widget>[
      //       GestureDetector(
      //           onTap: () {
      //             Get.to(AddIncome());
      //           },
      //           child: Image(image: AssetImage('assets/expense-white.png'))),
      //       GestureDetector(
      //           onTap: () {
      //             Get.to(AddExpense());
      //           },
      //           child: Image(image: AssetImage('assets/income-white.png'))),
      //     ]),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
        notchMargin: 10,
        child: Container(
          height: 40,
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround, // Adjust alignment
            children: <Widget>[
              Expanded(
                // Use Expanded for each button
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      currentScreen = HomeScreen();
                      currentTab = 0;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color: currentTab == 0
                            ? myblue
                            : Theme.of(context).brightness == Brightness.light
                                ? Colors.grey
                                : Colors.white,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                          color: currentTab == 0
                              ? myblue
                              : Theme.of(context).brightness == Brightness.light
                                  ? Colors.grey
                                  : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      currentScreen = BudgetScreen();
                      currentTab = 1;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calculate,
                        color: currentTab == 1
                            ? myblue
                            : Theme.of(context).brightness == Brightness.light
                                ? Colors.grey
                                : Colors.white,
                      ),
                      Text(
                        "Budget",
                        style: TextStyle(
                          color: currentTab == 1
                              ? myblue
                              : Theme.of(context).brightness == Brightness.light
                                  ? Colors.grey
                                  : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      currentScreen = ReportScreen();
                      currentTab = 2;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.pie_chart,
                        color: currentTab == 2
                            ? myblue
                            : Theme.of(context).brightness == Brightness.light
                                ? Colors.grey
                                : Colors.white,
                      ),
                      Text(
                        "Report",
                        style: TextStyle(
                          color: currentTab == 2
                              ? myblue
                              : Theme.of(context).brightness == Brightness.light
                                  ? Colors.grey
                                  : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      currentScreen = ProfileScreen();
                      currentTab = 3;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color: currentTab == 3
                            ? myblue
                            : Theme.of(context).brightness == Brightness.light
                                ? Colors.grey
                                : Colors.white,
                      ),
                      Text(
                        "Profile",
                        style: TextStyle(
                          color: currentTab == 3
                              ? myblue
                              : Theme.of(context).brightness == Brightness.light
                                  ? Colors.grey
                                  : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

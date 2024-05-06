import 'package:expense_tracker_app/resources/custom_transactions.dart';
import 'package:expense_tracker_app/resources/home_credit_card.dart';
import 'package:expense_tracker_app/services/db_helper.dart';
import 'package:expense_tracker_app/services/getx_controllers.dart';
import 'package:expense_tracker_app/views/add_bank_screen.dart';
import 'package:expense_tracker_app/views/add_expense.dart';
import 'package:expense_tracker_app/views/report_screen.dart';
import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spincircle_bottom_bar/modals.dart';
import 'package:spincircle_bottom_bar/spincircle_bottom_bar.dart';
import 'package:expense_tracker_app/views/add_income.dart';
import 'package:expense_tracker_app/views/transaction_details_screen.dart';

import 'package:flutter/material.dart';
import 'package:expense_tracker_app/resources/theme.dart';

import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:expense_tracker_app/resources/custom_home_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  HomeController homeController = Get.put(HomeController());
  final _storage = GetStorage();
  late String name;
  late String user_img_path;

  late Future<List<Map<String, dynamic>>> _transactionsFuture;
  late Future<List<Map<String, dynamic>>> _credit_cardsFuture;
  List<String> wallets = [];
  List<int> wallets_money = [];
  int totalBalace = 0;
  late List<Map<String, dynamic>> banks;

  DBHelper dbHelper = DBHelper();

  Future<List<Map<String, dynamic>>> fetchTransactionsIntoList() async {
    final db = await dbHelper.database;

    // Left join with categories table when income_id is -1
    // Left join with income_categories table when category_id is -1
    return db.rawQuery('''
    SELECT t.*, 
           CASE 
             WHEN t.income_id = -1 THEN c.category_name 
             ELSE i.income_name 
           END AS name,
           CASE 
             WHEN t.income_id = -1 THEN c.img_path 
             ELSE i.img_path 
           END AS img_path
    FROM transactions t
    LEFT JOIN categories c ON t.category_id = c.category_id AND t.income_id = -1
    LEFT JOIN income_categories i ON t.income_id = i.income_id AND t.category_id = -1
  ''');
  }

  void fetchTransactions() async {
    setState(() {
      _transactionsFuture = fetchTransactionsIntoList();
    });
  }

  Future<List<Map<String, dynamic>>> fetchBanks() async {
    final db = await dbHelper.database;
    banks = await db.query('banks');
    wallets = banks.map((e) => e['bank_name'] as String).toList();
    wallets_money = banks.map((e) => e['balance'] as int).toList();

    return banks;
  }

  // void getTotalBalance() {
  //   fetchBanks();

  //   print(wallets_money);
  //   print(totalBalace);
  //   setState(() {
  //     for (int num in wallets_money) {
  //       totalBalace += num;
  //     }
  //   });
  // }
  Future<int> getTotalBalance() async {
    final db = await dbHelper.database;
    banks = await db.query('banks');

    wallets = banks.map((e) => e['bank_name'] as String).toList();
    wallets_money = banks.map((e) => e['balance'] as int).toList();
    totalBalace = 0;
    for (int num in wallets_money) {
      totalBalace += num;
    }
    return totalBalace;
  }

  @override
  void initState() {
    name = _storage.read('name');
    user_img_path = _storage.read('user_img_path');
    setState(() {
      fetchTransactions();
      _credit_cardsFuture = fetchBanks();
      getTotalBalance();
    });

    super.initState();
  }

  // void fetchCategories() async {
  //   final db = await dbHelper.database;
  //   final List<Map<String, dynamic>> categories = await db.query('categories');
  // }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    setState(() {
      fetchTransactions();
      _credit_cardsFuture = fetchBanks();
      getTotalBalance();
    });

    String? selectedMonth;
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage(user_img_path),
                          ),
                          SizedBox(width: 10), // Adjust as needed
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello Welcome!",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Icon(Icons.notifications),
                  ],
                ),
                // const SizedBox(
                //   height: 4,
                // ),
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(40),
                //     color: Theme.of(context).brightness == Brightness.light
                //         ? Colors.white
                //         : const Color(0xff1F1F1F),
                //   ),
                //   child: DropdownButton<String>(
                //     value: homeController.dropDownValue.toString(),
                //     icon: const Image(
                //         image: AssetImage('assets/images/arrow-down-2.png')),
                //     underline: Container(
                //       height: 0,
                //     ),
                //     items: months.map<DropdownMenuItem<String>>((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(value),
                //       );
                //     }).toList(),
                //     onChanged: (String? newValue) {
                //       setState(() {
                //         homeController.dropDownValue.value = newValue!;
                //       });
                //     },
                //   ),
                // ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: screenWidth,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).brightness == Brightness.light
                        ? myblue
                        : const Color(0xff1F1F1F),
                  ),
                  child: Column(children: [
                    const SizedBox(
                      height: 18,
                    ),
                    const Text(
                      'Total Balance',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    FutureBuilder(
                        future: getTotalBalance(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            totalBalace = snapshot.data!;
                            return Text(
                              "\$${totalBalace}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800),
                            );
                          }
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    // Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: 35),
                    //     child: Column(
                    //       children: [
                    //         LinearPercentIndicator(
                    //           lineHeight: 5,
                    //           percent: 0.3,
                    //           progressColor: const Color(0xffFFB800),
                    //           backgroundColor: Colors.white,
                    //         ),
                    //         const SizedBox(
                    //           height: 5,
                    //         ),
                    //         const Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Text(
                    //               '\$301 spent',
                    //               style: TextStyle(
                    //                   color: Colors.white,
                    //                   fontSize: 12,
                    //                   fontWeight: FontWeight.w400),
                    //             ),
                    //             Text(
                    //               'out of \$500',
                    //               style: TextStyle(
                    //                   color: Colors.white,
                    //                   fontSize: 12,
                    //                   fontWeight: FontWeight.w400),
                    //             ),
                    //           ],
                    //         ),
                    //       ],
                    //     )),
                  ]),
                ),
                const SizedBox(
                  height: 23,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Container(
                //       width: screenWidth / 2.3,
                //       height: 89.27,
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(28),
                //           color: myGreen),
                //       child: Padding(
                //         padding: const EdgeInsets.only(left: 12.85),
                //         child: Row(
                //           children: [
                //             Container(
                //               padding: const EdgeInsets.all(10),
                //               width: 53.56,
                //               height: 53.56,
                //               decoration: BoxDecoration(
                //                 color: const Color(0xffFCFCFC),
                //                 borderRadius: BorderRadius.circular(16),
                //               ),
                //               child: const Image(
                //                   image:
                //                       AssetImage('assets/images/income.png')),
                //             ),
                //             const SizedBox(
                //               width: 10,
                //             ),
                //             const Column(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text(
                //                   "Income",
                //                   style: TextStyle(
                //                       color: Colors.white,
                //                       fontSize: 15,
                //                       fontWeight: FontWeight.w600),
                //                 ),
                //                 SizedBox(
                //                   height: 5,
                //                 ),
                //                 Text(
                //                   "\$10000",
                //                   style: TextStyle(
                //                       color: Colors.white,
                //                       fontSize: 13,
                //                       fontWeight: FontWeight.w600),
                //                 )
                //               ],
                //             )
                //           ],
                //         ),
                //       ),
                //     ),
                //     Container(
                //       width: screenWidth / 2.3,
                //       height: 89.27,
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(28),
                //           color: myRed),
                //       child: Padding(
                //         padding: const EdgeInsets.only(left: 12.85),
                //         child: Row(
                //           children: [
                //             Container(
                //               padding: const EdgeInsets.all(10),
                //               width: 53.56,
                //               height: 53.56,
                //               decoration: BoxDecoration(
                //                 color: const Color(0xffFCFCFC),
                //                 borderRadius: BorderRadius.circular(16),
                //               ),
                //               child: const Image(
                //                   image:
                //                       AssetImage('assets/images/expense.png')),
                //             ),
                //             const SizedBox(
                //               width: 10,
                //             ),
                //             const Column(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text(
                //                   "Expense",
                //                   style: TextStyle(
                //                       color: Colors.white,
                //                       fontSize: 15,
                //                       fontWeight: FontWeight.w600),
                //                 ),
                //                 SizedBox(
                //                   height: 5,
                //                 ),
                //                 Text(
                //                   "\$10000",
                //                   style: TextStyle(
                //                       color: Colors.white,
                //                       fontSize: 13,
                //                       fontWeight: FontWeight.w600),
                //                 )
                //               ],
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 30,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddIncome()))
                            .then((value) {
                          setState(() {
                            _credit_cardsFuture = fetchBanks();
                            getTotalBalance();
                            fetchTransactions();
                          });
                        });
                      },
                      child: const CustomHomeButton(
                        imgPath: 'assets/wallet.png',
                        text: 'Add Income',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddExpense()))
                            .then((value) {
                          setState(() {
                            _credit_cardsFuture = fetchBanks();
                            getTotalBalance();
                            fetchTransactions();
                          });
                        });
                      },
                      child: const CustomHomeButton(
                        imgPath: 'assets/wallet.png',
                        text: 'Add Expense',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddBankScreen()))
                            .then((value) {
                          setState(() {
                            fetchTransactions();
                            getTotalBalance();
                            _credit_cardsFuture = fetchBanks();
                          });
                        });
                      },
                      child: const CustomHomeButton(
                        imgPath: 'assets/bank.png',
                        text: 'Add Bank',
                      ),
                    ),
                    // const CustomHomeButton(
                    //   imgPath: 'assets/profit.png',
                    //   text: 'Bank Details',
                    // ),
                  ],
                ),
                // const SizedBox(
                //   height: 29,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     GestureDetector(
                //       onTap: () {
                //         Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) => AddExpense()))
                //             .then((value) {
                //           setState(() {
                //             _credit_cardsFuture = fetchBanks();
                //             getTotalBalance();
                //             fetchTransactions();
                //           });
                //         });
                //       },
                //       child: const CustomHomeButton(
                //         imgPath: 'assets/wallet.png',
                //         text: 'Add Expense',
                //       ),
                //     ),
                //     const CustomHomeButton(
                //       imgPath: 'assets/personal.png',
                //       text: 'Add Loan',
                //     ),
                //     const CustomHomeButton(
                //       imgPath: 'assets/budget.png',
                //       text: 'Add Budget',
                //     ),
                //   ],
                // ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recent Transection',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReportScreen()));
                      },
                      child: Container(
                          width: 78,
                          height: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.white
                                    : const Color(0xff1F1F1F),
                          ),
                          child: const Center(
                              child: Text(
                            'See all',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ))),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 29,
                ),
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: _transactionsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.data!.isEmpty == true) {
                      return const Center(child: Text("No record available"));
                    } else {
                      List<Map<String, dynamic>> transactions =
                          snapshot.data ?? [];

                      // Inside the FutureBuilder builder method where you handle transactions
                      return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            transactions.length >= 3 ? 3 : transactions.length,
                        itemBuilder: (context, index) {
                          final transaction =
                              transactions.reversed.toList()[index];

                          String title;
                          String imgPath;

                          if (transaction['income_id'] == -1) {
                            title = transaction[
                                'name']; // Use 'name' field for income
                            imgPath = transaction[
                                'img_path']; // Use 'img_path' field for income
                          } else {
                            title = transaction[
                                'name']; // Use 'category_name' field for expense
                            imgPath = transaction[
                                'img_path']; // Use 'category_img_path' field for expense
                          }

                          int amount = transaction['amount'];

                          int bankid = transaction['bank_id'];
                          bankid--;
                          return InkWell(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TransactionDetailsScreen(
                                            amount: amount,
                                            category: title,
                                            note: transaction['note'],
                                            type: transaction['type'],
                                            date: transaction['date'],
                                            transactionId: transaction['id'],
                                            bankId: transaction['bank_id'],
                                            bankName:
                                                wallets[bankid].toString(),
                                          ))).then((value) {
                                setState(() {
                                  _credit_cardsFuture = fetchBanks();
                                  fetchTransactions();
                                });
                              });
                            },
                            child: CustomTransaction(
                              imgPath: imgPath,
                              subtitle: transaction['note'],
                              title: title,
                              amount: amount,
                              type: transaction['type'],
                              date: transaction['date'],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(height: 10),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 29,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'My Banks',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    // GestureDetector(
                    //   onTap: () {},
                    //   child: Container(
                    //       width: 78,
                    //       height: 32,
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(14),
                    //         color:
                    //             Theme.of(context).brightness == Brightness.light
                    //                 ? Colors.white
                    //                 : const Color(0xff1F1F1F),
                    //       ),
                    //       child: const Center(
                    //           child: Text(
                    //         'See all',
                    //         style: TextStyle(
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //       ))),
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 29,
                ),
                SizedBox(
                  height: 200,
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: _credit_cardsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.data!.isEmpty == true) {
                        return const Center(child: Text("No record available"));
                      } else {
                        List<Map<String, dynamic>> banks = snapshot.data ?? [];

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: banks.length,
                          itemBuilder: (context, index) {
                            final bank = banks.toList()[index];
                            int openBalance = bank['balance'];
                            String bankName = bank['bank_name'];
                            String accountNumber = bank['account_no'];
                            String cardColor = bank['color'];
                            return HomeCreditCard(
                                openBalance: openBalance,
                                bankName: bankName,
                                cardColor: cardColor,
                                accountNumber: accountNumber);
                          },
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
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
      //             Get.to(AddExpense());
      //           },
      //           child: Image(
      //               width: 40, image: AssetImage('assets/images/expense.png'))),
      //       GestureDetector(
      //           onTap: () {
      //             Get.to(AddIncome());
      //           },
      //           child: Image(
      //               width: 30, image: AssetImage('assets/images/income.png'))),
      //     ]),
    );
  }
}

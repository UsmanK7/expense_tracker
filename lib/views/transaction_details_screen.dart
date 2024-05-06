import 'package:expense_tracker_app/resources/theme.dart';
import 'package:expense_tracker_app/services/db_helper.dart';
import 'package:expense_tracker_app/views/home_screen.dart';
import 'package:expense_tracker_app/views/update_transactions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TransactionDetailsScreen extends StatefulWidget {
  int amount;
  String category;
  final type;
  String date;
  String note;
  String bankName;
  final bankId;
  final transactionId;
  TransactionDetailsScreen(
      {Key? key,
      required this.amount,
      required this.category,
      required this.note,
      required this.type,
      required this.date,
      required this.bankId,
      required this.transactionId,
      required this.bankName});

  @override
  State<TransactionDetailsScreen> createState() =>
      _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen> {
  DBHelper dbHelper = DBHelper();
  late List<Map<String, dynamic>> banks;
  void fetchBanks() async {
    final db = await dbHelper.database;
  }

  void subtractFromBank(int bank_id, amount) async {
    // print(bank_id);
    // print(amount);
    // bank_id--;
    // print(bank_id);
    final db = await dbHelper.database;
    banks = await db.query('banks');
    bank_id--;
    print(bank_id);
    Map<String, dynamic> selectedBank = banks[bank_id];
    print("old balance was ${selectedBank['balance']}");
    int finalBalance = selectedBank['balance'] - amount;
    print("new balance is ${finalBalance}");

    // print("where bank id is ${bank_id}");
    bank_id++;
    await db.update('banks', {'balance': finalBalance},
        where: 'bank_id = ?', whereArgs: [bank_id]);
  }

  void addToBank(int bank_id, amount) async {
    // print(bank_id);
    // print(amount);
    // bank_id--;
    // print(bank_id);
    final db = await dbHelper.database;
    banks = await db.query('banks');
    bank_id--;
    print(bank_id);
    Map<String, dynamic> selectedBank = banks[bank_id];
    print("old balance was ${selectedBank['balance']}");
    int finalBalance = selectedBank['balance'] + amount;
    print("new balance is ${finalBalance}");

    // print("where bank id is ${bank_id}");
    bank_id++;
    await db.update('banks', {'balance': finalBalance},
        where: 'bank_id = ?', whereArgs: [bank_id]);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Color(0xff121212),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 16.0),
        child: AppBar(
          centerTitle: true,
          backgroundColor: widget.type == 0 ? myRed : myGreen,
          title: Text(
            'Transaction Details',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 16),
                child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // Return the AlertDialog widget
                          return AlertDialog(
                            title: Text('Confirmation'),
                            content: Text('Are you sure you want to delete?'),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  widget.type == 0
                                      ? addToBank(widget.bankId, widget.amount)
                                      : subtractFromBank(
                                          widget.bankId, widget.amount);
                                  final db = await dbHelper.database;

                                  await db.delete('transactions',
                                      where: 'id = ?',
                                      whereArgs: [widget.transactionId]);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Text('Yes'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // User cancelled deletion
                                  Get.back(
                                      result:
                                          false); // Return false if user cancels
                                },
                                child: Text('No'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Image(image: AssetImage('assets/trash.png'))))
          ],
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Image(
              image: AssetImage('assets/arrow-left.png'),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 222,
                    child: Stack(
                      children: [
                        Container(
                          height: 182,
                          width: screenWidth,
                          decoration: BoxDecoration(
                              color: widget.type == 0 ? myRed : myGreen,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              )),
                          child: Column(
                            children: [
                              Text("\$${widget.amount}",
                                  style: TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffFCFCFC))),
                              SizedBox(
                                height: 10,
                              ),
                              Text(widget.category,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xffFCFCFC))),
                              SizedBox(
                                height: 8,
                              ),
                              Text(widget.date,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xffFCFCFC))),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding:
                                EdgeInsets.only(bottom: 5, right: 16, left: 16),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 26),
                              width: screenWidth,
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                                border: Border.all(
                                  width: 2.0,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Color(0xffF1F1FA)
                                      : Colors.black,
                                ),
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.white
                                    : Color(0xff1F1F1F),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Type",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff91919F)),
                                      ),
                                      SizedBox(
                                        height: 9,
                                      ),
                                      Text(
                                        widget.type == 0 ? "Expense" : "Income",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Color(0xff0D0E0F)
                                              : Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Category",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff91919F)),
                                      ),
                                      SizedBox(
                                        height: 9,
                                      ),
                                      Text(widget.category,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? Color(0xff0D0E0F)
                                                    : Colors.white,
                                          )),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Wallet",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff91919F)),
                                      ),
                                      SizedBox(
                                        height: 9,
                                      ),
                                      Text(
                                        widget.bankName,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Color(0xff0D0E0F)
                                              : Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  Image(image: AssetImage('assets/dotted-line.png')),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26, vertical: 14),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Note",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff91919F),
                                  fontWeight: FontWeight.w600),
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              widget.note,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Color(0xff0D0E0F)
                                      : Colors.white,
                                  fontWeight: FontWeight.w500),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              final updatedValue = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateTransactions(
                            type: widget.type,
                            category: widget.category,
                            bankName: widget.bankName,
                            date: widget.date,
                            amount: widget.amount,
                            notes: widget.note,
                            transactionId: widget.transactionId,
                          )));

              if (updatedValue != null) {
                setState(() {
                  widget.amount = updatedValue['amount'];
                  widget.category = updatedValue['category'];
                  widget.date = updatedValue['date'];
                  widget.bankName = updatedValue['bankName'];
                  widget.note = updatedValue['note'];
                  print("AMOUNT UPDATED");
                });
              }
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: 70, right: 16, left: 16),
              child: Container(
                height: 56,
                width: screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).brightness == Brightness.light
                      ? Color(0xff95AEEE)
                      : Color(0xff7F3DFF),
                ),
                child: Center(
                    child: Text("Edit",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

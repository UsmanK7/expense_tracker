import 'package:expense_tracker_app/main.dart';
import 'package:expense_tracker_app/resources/credit_card.dart';
import 'package:expense_tracker_app/resources/theme.dart';
import 'package:expense_tracker_app/services/db_helper.dart';
import 'package:expense_tracker_app/views/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:expense_tracker_app/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ionicons/ionicons.dart';

class OnAddBankScreen extends StatefulWidget {
  OnAddBankScreen({Key? key});

  @override
  State<OnAddBankScreen> createState() => _OnAddBankScreenState();
}

class _OnAddBankScreenState extends State<OnAddBankScreen> {
  int openBalance = 0;
  String bankName = "Bank Name";
  Color cardColor = Colors.black;
  String accountNumber = "XXXXXXXXXXXXXXXX";
  DBHelper dbHelper = DBHelper();
  final _storage = GetStorage();

  Future<void> pushtoBank(
      int balance, String account_no, String color, String bank_name) async {
    final db = await dbHelper.database;
    await db.insert('banks', {
      'balance': balance,
      'bank_name': bank_name,
      'color': color,
      'account_no': account_no,
    });
  }

  List<bool> isSelected = List.generate(10, (index) => index == 0);
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xff9B59B6),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            kToolbarHeight + 16.0), // Adjust the height here as needed
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: AppBar(
            centerTitle: true,
            backgroundColor: Color(0xff9B59B6),
            title: Text(
              'Add Bank',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CreditCard(
                    openBalance: openBalance,
                    bankName: bankName,
                    cardColor: colorToString(cardColor),
                    accountNumber: accountNumber)
              ],
            ),
            Container(
              width: screenWidth,
              height: screenHeight / 1.9,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Color(0xff121212),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 56,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.white
                                    : Color(0xff1F1F1F),
                            borderRadius: BorderRadius.circular(16),
                            border: Border(
                              top: BorderSide(
                                  color:
                                      const Color.fromARGB(31, 227, 109, 109),
                                  width: 2.0),
                              bottom: BorderSide(
                                  color:
                                      const Color.fromARGB(31, 227, 109, 109),
                                  width: 2.0),
                              left: BorderSide(
                                  color:
                                      const Color.fromARGB(31, 227, 109, 109),
                                  width: 2.0),
                              right: BorderSide(
                                  color:
                                      const Color.fromARGB(31, 227, 109, 109),
                                  width: 2.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              maxLength: 10,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')), // Allow only numbers
                              ],
                              onChanged: (value) {
                                setState(() {
                                  openBalance =
                                      int.parse(value.isNotEmpty ? value : '0');
                                });
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Image.asset('assets/coin-black.png')
                                      : Image.asset('assets/coin-white.png'),
                                  hintStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff91919F)),
                                  hintText: "Open Balance",
                                  counterText: "",
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          height: 56,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.white
                                    : Color(0xff1F1F1F),
                            borderRadius: BorderRadius.circular(16),
                            border: Border(
                              top: BorderSide(
                                  color:
                                      const Color.fromARGB(31, 227, 109, 109),
                                  width: 2.0),
                              bottom: BorderSide(
                                  color:
                                      const Color.fromARGB(31, 227, 109, 109),
                                  width: 2.0),
                              left: BorderSide(
                                  color:
                                      const Color.fromARGB(31, 227, 109, 109),
                                  width: 2.0),
                              right: BorderSide(
                                  color:
                                      const Color.fromARGB(31, 227, 109, 109),
                                  width: 2.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              maxLength: 16,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  accountNumber = value.length <= 16
                                      ? value
                                      : value.substring(0, 16);
                                });
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Ionicons.card),
                                  hintStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff91919F)),
                                  hintText: "Account No",
                                  counterText: '',
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          height: 56,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.white
                                    : Color(0xff1F1F1F),
                            borderRadius: BorderRadius.circular(16),
                            border: Border(
                              top: BorderSide(
                                  color:
                                      const Color.fromARGB(31, 227, 109, 109),
                                  width: 2.0),
                              bottom: BorderSide(
                                  color:
                                      const Color.fromARGB(31, 227, 109, 109),
                                  width: 2.0),
                              left: BorderSide(
                                  color:
                                      const Color.fromARGB(31, 227, 109, 109),
                                  width: 2.0),
                              right: BorderSide(
                                  color:
                                      const Color.fromARGB(31, 227, 109, 109),
                                  width: 2.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              maxLength: 20,
                              onChanged: (value) {
                                setState(() {
                                  bankName = value;
                                });
                              },
                              decoration: InputDecoration(
                                  counterText: "",
                                  prefixIcon: SizedBox(
                                    width: 5,
                                    child: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Image.asset(
                                            'assets/balance-black.png')
                                        : Image.asset(
                                            'assets/balance-white.png'),
                                  ),
                                  hintStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff91919F)),
                                  hintText: "Bank Name",
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            10,
                            (index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  cardColor = _getContainerColor(index);
                                  if (!isSelected[index]) {
                                    for (int i = 0;
                                        i < isSelected.length;
                                        i++) {
                                      isSelected[i] = (i == index);
                                    }
                                  }
                                });
                              },
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                  color: _getContainerColor(index),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: isSelected[index]
                                    ? Icon(
                                        Icons.check,
                                        size: 19,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        String colorString = colorToString(cardColor);
                        if (openBalance == 0) {
                          Get.snackbar(
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              "Open Balance is zero",
                              "Open Balance is a required field please enter to continue");
                        } else {
                          _storage.write('onboard', true);
                          print(_storage.read('onboard'));
                          pushtoBank(openBalance, accountNumber, colorString,
                              bankName);

                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        }
                      },
                      child: Container(
                        height: 56,
                        width: screenWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Color(0xff95AEEE)
                                  : Color(0xff7F3DFF),
                        ),
                        child: Center(
                            child: Text("Finish",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Function to get container color
Color _getContainerColor(int index) {
  switch (index) {
    case 0:
      return Colors.black;
    case 1:
      return Colors.blue;
    case 2:
      return Colors.red;
    case 3:
      return Colors.green;
    case 4:
      return Colors.orange;
    case 5:
      return Colors.purple;
    case 6:
      return Colors.lightGreen;
    case 7:
      return Colors.teal;
    case 8:
      return Colors.brown;
    case 9:
      return Colors.indigo;
    default:
      return Colors.black;
  }
}

String colorToString(Color color) {
  // Convert color to hexadecimal string representation
  return color.value.toRadixString(16).substring(2); // Remove alpha value
}

Color stringToColor(String colorString) {
  // Convert hexadecimal string to Color
  return Color(
      int.parse(colorString, radix: 16) + 0xFF000000); // Add alpha value
}

import 'package:expense_tracker_app/resources/theme.dart';
import 'package:expense_tracker_app/services/db_helper.dart';
import 'package:expense_tracker_app/views/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddIncome extends StatefulWidget {
  AddIncome({Key? key});

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  late DateTime _showDateTime = DateTime.now();

  late FocusNode _amountFocusNode;
  TextEditingController amountController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: _showDateTime,
            firstDate: DateTime(2000),
            lastDate: DateTime(2025))
        .then((value) {
      if (value != null) {
        setState(() {
          _showDateTime = DateTime(value.year, value.month, value.day);
        });
      }
    });
  }

  String? selectedCategory;
  String? selectedWallet;
  DBHelper dbHelper = DBHelper();
  List<String> items = [];
  List<String> category_images = [];
  List<String> wallets = [];
  late List<Map<String, dynamic>> banks;

  @override
  void initState() {
    // TODO: implement initState
    _amountFocusNode = FocusNode();
    super.initState();
  }

  void fetchCategories() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> categories =
        await db.query('income_categories');
    items = categories.map((e) => e['income_name'] as String).toList();
    category_images = categories.map((e) => e['img_path'] as String).toList();
  }

  void fetchBanks() async {
    final db = await dbHelper.database;
    banks = await db.query('banks');
    wallets = banks.map((e) => e['bank_name'] as String).toList();
  }

  void subtractFromBank(int bank_id, amount) async {
    bank_id--;
    final db = await dbHelper.database;
    Map<String, dynamic> selectedBank = banks[bank_id];
    print("old balance was ${selectedBank['balance']}");
    int finalBalance = selectedBank['balance'] + amount;
    print("new balance is ${finalBalance}");

    print("where bank id is ${bank_id}");
    bank_id++;
    await db.update('banks', {'balance': finalBalance},
        where: 'bank_id = ?', whereArgs: [bank_id]);

    // for (var bb in banks) {
    //   print(bb[1]);
    // }
  }

  Future<void> pushExpenseIntoDb(
      int categorie_id,
      int amount,
      String date,
      
      String note,
      int bank_id,
      int type,
      int income_id) async {
    // Change parameter types

    final db = await dbHelper.database;
    await db.insert('transactions', {
      'category_id': categorie_id,
      'income_id': income_id,
      'amount': amount,
      'date': date,
      
      'note': note,
      'bank_id': bank_id,
      'type': type,
    });
    print("values pushed");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _amountFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fetchCategories();
    fetchBanks();

    // fetchBanks();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: myGreen,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            kToolbarHeight + 16.0), // Adjust the height here as needed
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: AppBar(
            centerTitle: true,
            backgroundColor: myGreen,
            title: Text(
              'Add Income',
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
            SizedBox(
              height: screenHeight / 3.45,
              width: screenWidth,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 26),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "How much?",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffFCFCFC)),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      controller: amountController,
                      inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')), // Allow only numbers
                              ],
                      focusNode: _amountFocusNode,
                      style: TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                          hintText: "\$0",
                          border: InputBorder.none),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: screenWidth,
              height: screenHeight / 1.77,
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
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Category',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff91919F),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: items.asMap().entries.map((entry) {
                                int index = entry.key;
                                String item = entry.value;
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Row(
                                    children: [
                                      Image(
                                          width: 25,
                                          image: AssetImage(
                                              category_images[index])),
                                      SizedBox(
                                          width:
                                              8), // Adjust spacing between icon and text as needed
                                      Text(
                                        item,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              value: selectedCategory,
                              onChanged: (value) {
                                setState(() {
                                  selectedCategory = value;
                                  int category_id =
                                      items.indexOf(selectedCategory!);
                                  print(category_id);
                                });
                              },
                              buttonStyleData: ButtonStyleData(
                                height: 50,
                                width: 160,
                                padding:
                                    const EdgeInsets.only(left: 14, right: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              iconStyleData: IconStyleData(
                                icon: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                ),
                                iconSize: 14,
                                iconEnabledColor:
                                    Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white,
                                iconDisabledColor: Colors.grey,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 200,
                                width: screenWidth - 32,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                offset: const Offset(0, 0),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness: MaterialStateProperty.all(6),
                                  thumbVisibility:
                                      MaterialStateProperty.all(true),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                                padding: EdgeInsets.only(left: 14, right: 14),
                              ),
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
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: TextField(
                              controller: notesController,
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff91919F)),
                                  hintText: "Note",
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
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Wallet',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff91919F),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: wallets
                                  .map(
                                      (String item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                  .toList(),
                              value: selectedWallet,
                              onChanged: (value) {
                                setState(() {
                                  selectedWallet = value;
                                  int walletsId =
                                      wallets.indexOf(selectedWallet!);
                                  print(walletsId);
                                });
                              },
                              buttonStyleData: ButtonStyleData(
                                height: 50,
                                width: 160,
                                padding:
                                    const EdgeInsets.only(left: 14, right: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              iconStyleData: IconStyleData(
                                icon: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                ),
                                iconSize: 14,
                                iconEnabledColor:
                                    Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white,
                                iconDisabledColor: Colors.grey,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 200,
                                width: screenWidth - 32,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                offset: const Offset(0, 0),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness: MaterialStateProperty.all(6),
                                  thumbVisibility:
                                      MaterialStateProperty.all(true),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                                padding: EdgeInsets.only(left: 14, right: 14),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          height: 56,
                          width: screenWidth,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                          child: GestureDetector(
                            onTap: _showDatePicker,
                            child: Container(
                              width: screenWidth,
                              height: 63,
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.white
                                    : const Color(0xff1F1F1F),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DateFormat('dd-MM-yyyy')
                                              .format(_showDateTime) ==
                                          DateFormat('dd-MM-yyyy')
                                              .format(DateTime.now())
                                      ? Text("Today",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff91919F),
                                          ))
                                      : Text(DateFormat('dd-MM-yyyy')
                                          .format(_showDateTime)),
                                  Image(
                                      image: AssetImage('assets/calender.png'))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        if (selectedCategory == null) {
                          Get.snackbar(
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              "Category is missing",
                              "Catgory is a required field please enter to continue");
                        } else if (selectedWallet == null) {
                          Get.snackbar(
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              "Bank is missing",
                              "Bank is a required field please enter to continue");
                        } else if (selectedWallet == null) {
                          Get.snackbar(
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              "Bank is missing",
                              "Bank is a required field please enter to continue");
                        } else if (notesController.text.isEmpty) {
                          Get.snackbar(
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              "Note is empty",
                              "Note is a required field please enter to continue");
                        } else if (amountController.text.isEmpty) {
                          Get.snackbar(
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              "Amount is empty",
                              "Amount is a required field please enter to continue");
                        } else {
                          int amount = int.parse(amountController.text);
                          String date =
                              DateFormat('yyyy-MM-dd').format(_showDateTime);
                         
                          String note = notesController.text;
                          int bank_id = wallets.indexOf(selectedWallet!);
                          int income_id = items.indexOf(selectedCategory!);
                          income_id++;
                          bank_id++;
                          int type = 1;
                          print(amount);
                          
                          print(_showDateTime.month);
                          print(_showDateTime.year);
                          print(notesController.text);
                          print(bank_id);
                          int categorie_id = -1;
                          pushExpenseIntoDb(categorie_id, amount, date,  note, bank_id, type, income_id);

                          subtractFromBank(bank_id, amount);
                          Navigator.pop(context);
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
                            child: Text("Add Income",
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

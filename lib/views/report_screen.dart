import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expense_tracker_app/models/products.dart';
import 'package:expense_tracker_app/resources/category_card.dart';
import 'package:expense_tracker_app/resources/custom_badge.dart';
import 'package:expense_tracker_app/resources/custom_transactions.dart';
import 'package:expense_tracker_app/resources/theme.dart';
import 'package:expense_tracker_app/services/db_helper.dart';
import 'package:expense_tracker_app/services/theme_helper.dart';
import 'package:expense_tracker_app/views/transaction_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen>
    with TickerProviderStateMixin {
  int touchedIndex = 0;
  late TabController tabController;
  int currentTabIndex = 0;
  final List<String> items = [
    'Category',
    'Transactions',
  ];
  late String selectedValue;
  late String startDate;
  late String endDate;
  int selectedMonth = DateTime.now().month;
  late Future<List<Map<String, dynamic>>> _transactionsFuture;

  DBHelper dbHelper = DBHelper();

  Future<List<Map<String, dynamic>>> fetchTransactionsIntoList(
      String startDate, String endDate) async {
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
    WHERE t.date BETWEEN '$startDate' AND '$endDate'
    
  ''');
  }

  void fetchTransactions(String start, String end) async {
    setState(() {
      _transactionsFuture = fetchTransactionsIntoList(start, end);
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    selectedValue = items[0];
    startDate = GetCurrentStartDateMonth();
    endDate = GetCurrentLastDateMonth();
    fetchTransactions(startDate, endDate);
    tabController.addListener(_handleTabSelection);
  }

  String GetCurrentStartDateMonth() {
    // Get current date
    DateTime now = DateTime.now();

    // Get start date of the current month
    DateTime startDate = DateTime(now.year, now.month, 1);

    // Format start date as a string in "dd-MM-yyyy" format
    String formattedStartDate =
        "${startDate.year.toString()}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}";
    return formattedStartDate;
  }

  String GetCurrentLastDateMonth() {
    // Get current date
    // Get current date
    DateTime now = DateTime.now();

    // Get last date of the current month
    DateTime lastDate = DateTime(now.year, now.month + 1, 0);

    // Format last date as a string in "dd-MM-yyyy" format
    String formattedLastDate =
        "${lastDate.year.toString()}-${lastDate.month.toString().padLeft(2, '0')}-${lastDate.day.toString().padLeft(2, '0')}";

    return formattedLastDate; // Output: 30-04-2024 (for April 2024)
  }

  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {
      currentTabIndex = tabController.index;
    });
  }

  List<Color> sectionColors = [
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.amber,
    Colors.indigo,
    Colors.brown,
    Colors.grey,
    Colors.cyan,
    Colors.lime,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.deepPurpleAccent,
    Colors.redAccent,
  ];

  List<Color> incomeColors = [
    Colors.green,
    Colors.blue,
    Colors.teal,
    Colors.orange,
    Colors.indigo,
    Colors.pink,
    Colors.amber,
    Colors.lightBlue,
    Colors.red,
    Colors.deepOrange,
    Colors.lime,
    Colors.deepPurple,
    Colors.cyan,
    Colors.purple,
    Colors.brown,
    Colors.blueGrey,
    Colors.yellow,
    Colors.deepOrangeAccent,
    Colors.lightGreen,
    Colors.deepPurpleAccent,
  ];

  List<String> sectionIcons = [
    "assets/images/expense/baby.png",
    "assets/images/expense/bank-flat.png",
    "assets/images/expense/car.png",
    "assets/images/expense/clothing.png",
  ];
  List<String> sectionText = [
    "Baby",
    "Bank",
    "Car",
    "Clothing",
  ];
  List<int> sectionIncome = [
    100,
    200,
    300,
    560,
  ];
  // Function to handle tap on a month
  void _handleMonthTap(BuildContext context, String month) {
    int startDay;
    int endDay;

    // Get the current year
    int currentYear = DateTime.now().year;

    // Determine start and end dates based on the month
    switch (month) {
      case "01":
        startDay = DateTime(currentYear, DateTime.january).day;
        endDay = DateTime(currentYear, DateTime.january + 1, 0).day;
        break;
      case "02":
        startDay = DateTime(currentYear, DateTime.february, 1).day;
        endDay = DateTime(currentYear, DateTime.february + 1, 0).day;
        break;
      case "03":
        startDay = DateTime(currentYear, DateTime.march, 1).day;
        endDay = DateTime(currentYear, DateTime.march + 1, 0).day;
        break;
      case "04":
        startDay = DateTime(currentYear, DateTime.april, 1).day;
        endDay = DateTime(currentYear, DateTime.april + 1, 0).day;
        break;
      case "05":
        startDay = DateTime(currentYear, DateTime.may, 1).day;
        endDay = DateTime(currentYear, DateTime.may + 1, 0).day;
        break;
      case "06":
        startDay = DateTime(currentYear, DateTime.june, 1).day;
        endDay = DateTime(currentYear, DateTime.june + 1, 0).day;
        break;
      case "07":
        startDay = DateTime(currentYear, DateTime.july, 1).day;
        endDay = DateTime(currentYear, DateTime.july + 1, 0).day;
        break;
      case "08":
        startDay = DateTime(currentYear, DateTime.august, 1).day;
        endDay = DateTime(currentYear, DateTime.august + 1, 0).day;
        break;
      case "09":
        startDay = DateTime(currentYear, DateTime.september, 1).day;
        endDay = DateTime(currentYear, DateTime.september + 1, 0).day;
        break;
      case "10":
        startDay = DateTime(currentYear, DateTime.october, 1).day;
        endDay = DateTime(currentYear, DateTime.october + 1, 0).day;
        break;
      case "11":
        startDay = DateTime(currentYear, DateTime.november, 1).day;
        endDay = DateTime(currentYear, DateTime.november + 1, 0).day;
        break;
      case "12":
        startDay = DateTime(currentYear, DateTime.december, 1).day;
        endDay = DateTime(currentYear, DateTime.december + 1, 0).day;
        break;
      default:
        startDay = 1;
        endDay = 1;
        break;
    }

    // Store the start and end dates
    // MonthDate selectedMonth = MonthDate(startDay, endDay);
    // print("Selected Month: $month, Start Date: $startDay, End Date: $endDay");
    // Do whatever you want with the selected month's start and end dates

    startDate =
        '$currentYear-${month.padLeft(2, '0')}-${startDay.toString().padLeft(2, '0')}';
    endDate =
        '$currentYear-${month.padLeft(2, '0')}-${endDay.toString().padLeft(2, '0')}';

    fetchTransactions(startDate, endDate);
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DefaultTabController(
          length: 3,
          child: Container(
            height: 250,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(text: 'Month'),
                    Tab(text: 'Year'),
                    Tab(text: 'Custom date'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildMonthList(),
                      _buildYearList(),
                      _buildCustomList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMonthList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                DateTime.now().year.toString(),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff91919F)),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    _handleMonthTap(context, "01");
                    selectedMonth = 01;
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: selectedMonth == 01
                          ? Colors.blue
                          : Colors.transparent,
                    ),
                    child: Text(
                      "Jan",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: selectedMonth == 01
                              ? Colors.white
                              : Color(0xff91919F)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _handleMonthTap(context, "02");
                    selectedMonth = 02;
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: selectedMonth == 02
                          ? Colors.blue
                          : Colors.transparent,
                    ),
                    child: Text(
                      "Feb",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: selectedMonth == 02
                              ? Colors.white
                              : Color(0xff91919F)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _handleMonthTap(context, "03");
                    selectedMonth = 03;
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: selectedMonth == 03
                          ? Colors.blue
                          : Colors.transparent,
                    ),
                    child: Text(
                      "March",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: selectedMonth == 03
                              ? Colors.white
                              : Color(0xff91919F)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _handleMonthTap(context, "04");
                    selectedMonth = 04;
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: selectedMonth == 04
                          ? Colors.blue
                          : Colors.transparent,
                    ),
                    child: Text(
                      "April",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: selectedMonth == 04
                              ? Colors.white
                              : Color(0xff91919F)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    _handleMonthTap(context, "05");
                    selectedMonth = 05;
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: selectedMonth == 05
                          ? Colors.blue
                          : Colors.transparent,
                    ),
                    child: Text(
                      "May",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: selectedMonth == 05
                            ? Colors.white
                            : Color(0xff91919F),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _handleMonthTap(context, "06");
                    selectedMonth = 06;
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: selectedMonth == 06
                          ? Colors.blue
                          : Colors.transparent,
                    ),
                    child: Text(
                      "June",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: selectedMonth == 06
                            ? Colors.white
                            : Color(0xff91919F),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _handleMonthTap(context, "07");
                    selectedMonth = 07;
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: selectedMonth == 07
                          ? Colors.blue
                          : Colors.transparent,
                    ),
                    child: Text(
                      "July",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: selectedMonth == 07
                            ? Colors.white
                            : Color(0xff91919F),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _handleMonthTap(context, "08");
                    selectedMonth = 08;
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: selectedMonth == 08
                          ? Colors.blue
                          : Colors.transparent,
                    ),
                    child: Text(
                      "Aug",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: selectedMonth == 08
                            ? Colors.white
                            : Color(0xff91919F),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    _handleMonthTap(context, "09");
                    selectedMonth = 09;
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: selectedMonth == 09
                          ? Colors.blue
                          : Colors.transparent,
                    ),
                    child: Text(
                      "Sept",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: selectedMonth == 09
                            ? Colors.white
                            : Color(0xff91919F),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _handleMonthTap(context, "10");
                    selectedMonth = 10;
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: selectedMonth == 10
                          ? Colors.blue
                          : Colors.transparent,
                    ),
                    child: Text(
                      "Oct",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: selectedMonth == 10
                            ? Colors.white
                            : Color(0xff91919F),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _handleMonthTap(context, "11");
                    selectedMonth = 11;
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: selectedMonth == 11
                          ? Colors.blue
                          : Colors.transparent,
                    ),
                    child: Text(
                      "Nov",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: selectedMonth == 11
                            ? Colors.white
                            : Color(0xff91919F),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _handleMonthTap(context, "12");
                    selectedMonth = 12;
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: selectedMonth == 12
                          ? Colors.blue
                          : Colors.transparent,
                    ),
                    child: Text(
                      "Dec",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: selectedMonth == 12
                            ? Colors.white
                            : Color(0xff91919F),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleYearTap(BuildContext context, int currentYear) {
    int startDay;
    int endDay;

    // Get the current year

    startDay = DateTime(currentYear, DateTime.january).day;
    endDay = DateTime(currentYear, DateTime.december + 1, 0).day;

    startDate =
        '$currentYear-${"01".padLeft(2, '0')}-${startDay.toString().padLeft(2, '0')}';
    endDate =
        '$currentYear-${"12".padLeft(2, '0')}-${endDay.toString().padLeft(2, '0')}';

    fetchTransactions(startDate, endDate);
  }

  Widget _buildYearList() {
    return ListView.builder(
      itemCount: 8, // Example: show 10 years
      itemBuilder: (BuildContext context, int index) {
        int twoyearsback = index - 2;
        int currentYear = DateTime.now().year + twoyearsback;
        return GestureDetector(
            onTap: () {
              _handleYearTap(context, currentYear);
              selectedMonth = currentYear;
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                child: Text("${currentYear}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color:
                          selectedMonth == currentYear ? myblue : Colors.black,
                    )),
              ),
            ));
      },
    );
  }

  Widget _buildCustomList() {
    DateTime _startDate = DateTime.now();
    DateTime _endDate = DateTime.now();

    return Center(
      child: GestureDetector(
        onTap: () async {
          final picked = await showDateRangePicker(
            context: context,
            firstDate: DateTime(2000),
            lastDate: DateTime(3000),
            initialDateRange: DateTimeRange(
              start: _startDate,
              end: _endDate,
            ),
          );
          if (picked != null) {
            _startDate = picked.start;
            _endDate = picked.end;
            startDate = DateFormat('yyyy-MM-dd').format(_startDate);
            endDate = DateFormat('yyyy-MM-dd').format(_endDate);
            fetchTransactions(startDate, endDate);
          }
        },
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Text(
              //   'Selected Date Range:',
              //   style: TextStyle(fontSize: 18.0),
              // ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50), color: Colors.red),
                child: Text(
                  "Date range",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '${startDate} - ${endDate}',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(startDate);
    print(endDate);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            kToolbarHeight + 16.0), // Adjust the height here as needed
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: AppBar(
            centerTitle: true,
            title: Text(
              'Financial Report',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            // leading: GestureDetector(
            //   onTap: () {
            //     Navigator.of(context).pop();
            //   },
            //   child: Image(
            //     image: AssetImage('assets/arrow-left.png'),
            //   ),
            // ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _showBottomSheet(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: myblue,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${startDate} - ${endDate}",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _transactionsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.data!.isEmpty == true) {
                  return Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text("No record available")]));
                } else {
                  List<Map<String, dynamic>> transactions = snapshot.data ?? [];
                  List<Map<String, dynamic>> expense = transactions
                      .where((transaction) => transaction['income_id'] == -1)
                      .toList();
                  print("expense ${expense}");

                  List<Map<String, dynamic>> income = transactions
                      .where((transaction) => transaction['income_id'] != -1)
                      .toList();

                  // Inside the FutureBuilder builder method where you handle transactions
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 160,
                          child: Container(
                            // color: Colors.blue,
                            child: PieChart(
                              PieChartData(
                                pieTouchData: PieTouchData(
                                  touchCallback:
                                      (FlTouchEvent event, pieTouchResponse) {
                                    setState(() {
                                      if (!event.isInterestedForInteractions ||
                                          pieTouchResponse == null ||
                                          pieTouchResponse.touchedSection ==
                                              null) {
                                        touchedIndex = -1;
                                        return;
                                      }
                                      touchedIndex = pieTouchResponse
                                          .touchedSection!.touchedSectionIndex;
                                    });
                                  },
                                ),
                                sections: piechartSection(expense, income),
                                sectionsSpace: 0,
                                centerSpaceRadius: 40,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.white
                                    : const Color(0xff1F1F1F),
                                borderRadius: BorderRadius.circular(50)),
                            child: TabBar(
                              labelColor: Colors.white,
                              controller: tabController,
                              indicatorWeight: 2,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: BoxDecoration(
                                color: myblue,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              tabs: const [
                                Tab(
                                  text: 'Expense',
                                ),
                                Tab(
                                  text: 'Income',
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.white
                                    : const Color(0xff1F1F1F),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'Category',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: items
                                      .map((String item) =>
                                          DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  value: selectedValue,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedValue = value!;
                                      print(selectedValue);
                                    });
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    height: 40,
                                    width: 140,
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        selectedValue == "Category"
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: tabController.index == 0
                                      ? expense.length
                                      : income.length,
                                  itemBuilder: (context, index) {
                                    int amount = tabController.index == 0
                                        ? expense[index]['amount']
                                        : income[index]['amount'];
                                    double sum = 0;

                                    for (var transaction
                                        in tabController.index == 0
                                            ? expense
                                            : income) {
                                      sum += transaction['amount'];
                                    }

                                    double percentage = amount * 100 / sum;
                                    double percent = percentage / 100;

                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: CategoryCard(
                                        type: tabController.index,
                                        amount: amount,
                                        color: tabController.index == 0
                                            ? sectionColors[index]
                                            : incomeColors[index],
                                        category_name: tabController.index == 0
                                            ? expense[index]['name']
                                            : income[index]['name'],
                                        percentage: percent,
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Expanded(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: tabController.index == 0
                                      ? expense.length
                                      : income.length,
                                  itemBuilder: (context, index) {
                                    final transaction = tabController.index == 0
                                        ? expense.reversed.toList()[index]
                                        : income.reversed.toList()[index];

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
                                    return CustomTransaction(
                                      imgPath: imgPath,
                                      subtitle: transaction['note'],
                                      title: title,
                                      amount: amount,
                                      type: transaction['type'],
                                      date: transaction['date'],
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const SizedBox(height: 2),
                                ),
                              ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> piechartSection(
      List<Map<String, dynamic>> expense, List<Map<String, dynamic>> income) {
    return List.generate(
      tabController.index == 0 ? expense.length : income.length,
      (i) {
        int value = tabController.index == 0
            ? expense[i]['amount']
            : income[i]['amount'];
        double sum = 0;

        if (tabController.index == 0) {
          for (var transaction in expense) {
            sum += transaction['amount'];
          }
        } else {
          for (var transaction in income) {
            sum += transaction['amount'];
          }
        }

        double percentage = value * 100 / sum;
        String percent = "${percentage.toInt().toString()}%";
        // double value = (i + 1) * 10;

        final isTouched = i == touchedIndex;
        final radius = isTouched ? 45.0 : 40.0;
        final fontSize = isTouched ? 16.0 : 14.0;
        final widgetSize = isTouched ? 40.0 : 40.0;
        return PieChartSectionData(
          color: tabController.index == 0 ? sectionColors[i] : incomeColors[i],
          value: value.toDouble(),
          title: percent,
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(
              0xffffffff,
            ),
          ),
          badgeWidget: isTouched
              ? CustomBadge(
                  icon: tabController.index == 0
                      ? expense[i]['img_path']
                      : income[i]['img_path'],
                  size: widgetSize,
                  borderColor: Colors.black)
              : SizedBox(),
          badgePositionPercentageOffset: 1.6,
        );
      },
    );
  }
}

class MonthDate {
  int start;
  int end;

  MonthDate(this.start, this.end);
}

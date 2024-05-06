import 'package:expense_tracker_app/resources/category_card.dart';
import 'package:flutter/material.dart';

class TransactionsModel {
  int amount;
  String category;
  String date;
  String notes;
  String imgpath;
  
  TransactionsModel(this.amount, this.category, this.date, this.notes,
      this.imgpath);
}

// List<TransactionsModel> dummyTransactions = [
//   TransactionsModel(
//       100, "Groceries", "01-04-2024", "Bought groceries", Colors.green),
//   TransactionsModel(
//       50, "Entertainment", "12-03-2024", "Movie tickets", Colors.blue),
//   TransactionsModel(
//       200, "Shopping", "05-06-2024", "New clothes", Colors.orange),
//   TransactionsModel(
//       150, "Dining", "08-05-2024", "Dinner with friends", Colors.red),
//   TransactionsModel(
//       80, "Transportation", "17-07-2024", "Taxi fare", Colors.purple),
//   TransactionsModel(
//       120, "Utilities", "29-10-2024", "Electricity bill", Colors.yellow),
//   TransactionsModel(
//       70, "Entertainment", "23-09-2024", "Concert tickets", Colors.blue),
//   TransactionsModel(
//       90, "Groceries", "11-11-2024", "Weekly shopping", Colors.green),
//   TransactionsModel(
//       180, "Dining", "14-12-2024", "Lunch with family", Colors.red),
//   TransactionsModel(60, "Utilities", "06-02-2024", "Water bill", Colors.yellow),
//   TransactionsModel(
//       130, "Groceries", "03-04-2024", "Bought groceries", Colors.green),
//   TransactionsModel(
//       70, "Entertainment", "19-03-2024", "Movie tickets", Colors.blue),
//   TransactionsModel(
//       220, "Shopping", "07-06-2024", "New clothes", Colors.orange),
//   TransactionsModel(
//       140, "Dining", "09-05-2024", "Dinner with friends", Colors.red),
//   TransactionsModel(
//       100, "Transportation", "21-07-2024", "Taxi fare", Colors.purple),
//   TransactionsModel(
//       110, "Utilities", "13-10-2024", "Electricity bill", Colors.yellow),
//   TransactionsModel(
//       80, "Entertainment", "27-09-2024", "Concert tickets", Colors.blue),
//   TransactionsModel(
//       120, "Groceries", "08-11-2024", "Weekly shopping", Colors.green),
//   TransactionsModel(
//       190, "Dining", "12-12-2024", "Lunch with family", Colors.red),
//   TransactionsModel(70, "Utilities", "04-02-2024", "Water bill", Colors.yellow),
// ];

// int calculateTotalAmount(List<TransactionsModel> transactions) {
//   int sum = 0;
//   for (var transaction in transactions) {
//     sum += transaction.amount;
//   }
//   return sum;
// }

// sortAccordingtoAmount() {
//   // Sorting the list by amount in ascending order
//   dummyTransactions.sort((a, b) => a.amount.compareTo(b.amount));
// }

// List<TransactionsModel> filterTransactionsByDate(
//     List<TransactionsModel> transactions,
//     DateTime startDate,
//     DateTime endDate) {
//   return transactions.where((transaction) {
//     List<String> dateComponents = transaction.date.split('-');
//     int day = int.parse(dateComponents[0]);
//     int month = int.parse(dateComponents[1]);
//     int year = int.parse(dateComponents[2]);
//     DateTime transactionDate = DateTime(year, month, day);
//     print(transactionDate);
//     return transactionDate.isAfter(startDate.subtract(Duration(days: 1))) &&
//         transactionDate.isBefore(endDate.add(Duration(days: 1)));
//   }).toList();
// }

// class FilterScreen extends StatefulWidget {
//   const FilterScreen({Key? key}) : super(key: key);

//   @override
//   State<FilterScreen> createState() => _FilterScreenState();
// }

// class _FilterScreenState extends State<FilterScreen> {
//   late List<TransactionsModel> filteredTransactions;
//   late List<CategoryModel> filteredTransaction;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize filteredTransactions here
//     filteredTransactions = filterTransactionsByDate(
//       dummyTransactions,
//       DateTime(2024, 11, 1), // Start date
//       DateTime(2024, 11, 31), // End date
//     );
//     filteredTransaction = sumTransactionsByCategory(filteredTransactions);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: filteredTransaction.length,
//         itemBuilder: (context, index) {
//           CategoryModel transaction = filteredTransaction[index];
//           int totalAmount = calculateTotalAmount(filteredTransactions);
//           double percent = transaction.amount / totalAmount * 100;
//           double percentage = percent / 100;
//           return CategoryCard(
//             amount: transaction.amount,
//             color: transaction.color,
//             category_name: transaction.categoryName,
//             percentage: percentage,
//           );
//         },
//       ),
//     );
//   }
// }

// class CategoryModel {
//   final int amount;
//   final String categoryName;
//   final Color color;

//   CategoryModel(
//       {required this.amount, required this.categoryName, required this.color});
// }

// List<CategoryModel> sumTransactionsByCategory(
//     List<TransactionsModel> transactions) {
//   Map<String, CategoryModel> categoryMap = {};

//   for (TransactionsModel transaction in transactions) {
//     if (!categoryMap.containsKey(transaction.category)) {
//       categoryMap[transaction.category] = CategoryModel(
//         amount: transaction.amount,
//         categoryName: transaction.category,
//         color: transaction.color,
//       );
//     } else {
//       CategoryModel existingCategory = categoryMap[transaction.category]!;
//       categoryMap[transaction.category] = CategoryModel(
//         amount: existingCategory.amount + transaction.amount,
//         categoryName: transaction.category,
//         color: transaction.color,
//       );
//     }
//   }

//   return categoryMap.values.toList();
// }

import 'package:flutter/material.dart';

class TransactionsModel {
  int amount;
  String category;
  String date;
  String notes;
  Color color;
  TransactionsModel(
      this.amount, this.category, this.date, this.notes, this.color);
}

List<TransactionsModel> dummyTransactions = [
  TransactionsModel(
      100, "Groceries", "01-04-2024", "Bought groceries", Colors.green),
  TransactionsModel(
      50, "Entertainment", "12-03-2024", "Movie tickets", Colors.blue),
  TransactionsModel(
      200, "Shopping", "05-06-2024", "New clothes", Colors.orange),
  TransactionsModel(
      150, "Dining", "08-05-2024", "Dinner with friends", Colors.red),
  TransactionsModel(
      80, "Transportation", "17-07-2024", "Taxi fare", Colors.purple),
  TransactionsModel(
      120, "Utilities", "29-10-2024", "Electricity bill", Colors.yellow),
  TransactionsModel(
      70, "Entertainment", "23-09-2024", "Concert tickets", Colors.blue),
  TransactionsModel(
      90, "Groceries", "11-11-2024", "Weekly shopping", Colors.green),
  TransactionsModel(
      180, "Dining", "14-12-2024", "Lunch with family", Colors.red),
  TransactionsModel(60, "Utilities", "06-02-2024", "Water bill", Colors.yellow),
  TransactionsModel(
      130, "Groceries", "03-04-2024", "Bought groceries", Colors.green),
  TransactionsModel(
      70, "Entertainment", "19-03-2024", "Movie tickets", Colors.blue),
  TransactionsModel(
      220, "Shopping", "07-06-2024", "New clothes", Colors.orange),
  TransactionsModel(
      140, "Dining", "09-05-2024", "Dinner with friends", Colors.red),
  TransactionsModel(
      100, "Transportation", "21-07-2024", "Taxi fare", Colors.purple),
  TransactionsModel(
      110, "Utilities", "13-10-2024", "Electricity bill", Colors.yellow),
  TransactionsModel(
      80, "Entertainment", "27-09-2024", "Concert tickets", Colors.blue),
  TransactionsModel(
      120, "Groceries", "08-11-2024", "Weekly shopping", Colors.green),
  TransactionsModel(
      190, "Dining", "12-12-2024", "Lunch with family", Colors.red),
  TransactionsModel(70, "Utilities", "04-02-2024", "Water bill", Colors.yellow),
];

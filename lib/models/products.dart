import 'package:expense_tracker_app/resources/custom_transactions.dart';
import 'package:get/get.dart';

class TransactionDetails {
  String imgPath;
  int price;
  String title;
  String subtitle;
  String date;

  TransactionDetails({
    required this.date,
    required this.price,
    required this.imgPath,
    required this.subtitle,
    required this.title,
  });
}

final List<TransactionDetails> transactions = [
  TransactionDetails(
      imgPath: 'assets/images/expense/shopping-bag.png',
      price: 120,
      title: "Shopping",
      subtitle: "Buy some grocery",
      date: "16-04-2024"),
  TransactionDetails(
    imgPath: 'assets/images/expense/shopping-bag.png',
    price: 120,
    title: "Shopping",
    subtitle: "Buy some grocery",
    date: "16-04-2024",
  ),
  TransactionDetails(
    imgPath: 'assets/images/expense/shopping-bag.png',
    price: 50,
    title: "Dining Out",
    subtitle: "Lunch with friends",
    date: "16-04-2024",
  ),
  TransactionDetails(
    imgPath: 'assets/images/expense/shopping-bag.png',
    price: 30,
    title: "Transportation",
    subtitle: "Taxi ride",
    date: "17-04-2024",
  ),
  TransactionDetails(
    imgPath: 'assets/images/expense/shopping-bag.png',
    price: 15,
    title: "Entertainment",
    subtitle: "Movie night",
    date: "17-04-2024",
  ),
  TransactionDetails(
    imgPath: 'assets/images/expense/shopping-bag.png',
    price: 5,
    title: "Coffee",
    subtitle: "Morning brew",
    date: "17-04-2024",
  ),
  TransactionDetails(
    imgPath: 'assets/images/expense/shopping-bag.png',
    price: 80,
    title: "Groceries",
    subtitle: "Weekly shopping",
    date: "18-04-2024",
  ),
  TransactionDetails(
    imgPath: 'assets/images/expense/shopping-bag.png',
    price: 200,
    title: "Shopping",
    subtitle: "Clothing",
    date: "19-04-2024",
  ),
  TransactionDetails(
    imgPath: 'assets/images/expense/shopping-bag.png',
    price: 70,
    title: "Dining Out",
    subtitle: "Dinner with family",
    date: "19-04-2024",
  ),
  TransactionDetails(
    imgPath: 'assets/images/expense/shopping-bag.png',
    price: 25,
    title: "Transportation",
    subtitle: "Bus fare",
    date: "19-04-2024",
  ),
  TransactionDetails(
    imgPath: 'assets/images/expense/shopping-bag.png',
    price: 90,
    title: "Groceries",
    subtitle: "Monthly stock-up",
    date: "20-04-2024",
  ),
  TransactionDetails(
    imgPath: 'assets/images/expense/shopping-bag.png',
    price: 150,
    title: "Shopping",
    subtitle: "Household items",
    date: "20-04-2024",
  ),
  TransactionDetails(
    imgPath: 'assets/images/expense/shopping-bag.png',
    price: 60,
    title: "Dining Out",
    subtitle: "Brunch",
    date: "20-04-2024",
  ),
  TransactionDetails(
    imgPath: 'assets/images/expense/shopping-bag.png',
    price: 4,
    title: "Coffee",
    subtitle: "Afternoon pick-me-up",
    date: "21-04-2024",
  ),
  TransactionDetails(
    imgPath: 'assets/images/expense/shopping-bag.png',
    price: 20,
    title: "Transportation",
    subtitle: "Subway fare",
    date: "21-04-2024",
  ),
  TransactionDetails(
    imgPath: 'assets/images/expense/shopping-bag.png',
    price: 12,
    title: "Entertainment",
    subtitle: "Movie night",
    date: "21-04-2024",
  ),
  TransactionDetails(
    imgPath: 'assets/images/expense/shopping-bag.png',
    price: 70,
    title: "Groceries",
    subtitle: "Quick run to the store",
    date: "21-04-2024",
  ),
  TransactionDetails(
    imgPath: 'assets/images/expense/shopping-bag.png',
    price: 180,
    title: "Shopping",
    subtitle: "Electronics",
    date: "21-04-2024",
  ),
  TransactionDetails(
    imgPath: 'assets/images/expense/shopping-bag.png',
    price: 80,
    title: "Dining Out",
    subtitle: "Celebration dinner",
    date: "22-04-2024",
  ),
  TransactionDetails(
    imgPath: 'assets/images/expense/shopping-bag.png',
    price: 35,
    title: "Transportation",
    subtitle: "Taxi ride",
    date: "22-04-2024",
  ),
  TransactionDetails(
    imgPath: 'assets/images/expense/shopping-bag.png',
    price: 100,
    title: "Groceries",
    subtitle: "Weekly stock-up",
    date: "22-04-2024",
  ),
];

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class CreditCard extends StatelessWidget {
  final openBalance;
  final bankName;
  final cardColor;
  final accountNumber;
  const CreditCard({
    super.key,
    required this.openBalance,
    required this.bankName,
    required this.cardColor,
    required this.accountNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(21),
            padding: EdgeInsets.symmetric(horizontal: 27, vertical: 15),
            height: 195,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: stringToColor(cardColor)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Balance",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        Text(
                          "\$$openBalance",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image(image: AssetImage('assets/sim.png')),
                      Image(width: 40, image: AssetImage('assets/wifi.png')),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      formatAccountNumber(accountNumber),
                      
                      style: TextStyle(
                          fontSize: Get.width * 0.06,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      bankName,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

String formatAccountNumber(String input) {
  String formatted = '';
  for (int i = 0; i < input.length; i++) {
    formatted += input[i];
    if ((i + 1) % 4 == 0 && (i + 1) != input.length) {
      formatted +=
          ' '; // Add space after every 4 characters, excluding the last group
    }
  }
  return formatted;
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

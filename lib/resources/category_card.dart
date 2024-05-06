import 'package:expense_tracker_app/resources/theme.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CategoryCard extends StatelessWidget {
  int amount;
  String category_name;
  int type;
  Color color;

  double percentage;
  CategoryCard(
      {super.key,
      required this.amount,
      required this.color,
      required this.category_name,
      required this.type,
      required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color(0xff1F1F1F),
          borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  // color: Color(0xffF1F1FA),
                  color: Theme.of(context).brightness == Brightness.light
                      ? Color(0xffF1F1FA)
                      : Colors.black,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: color,
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      category_name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Color(0xff212325)
                            : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                type == 0 ? "- \$${amount}" : "+ \$${amount}",
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w600, color: myRed),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              LinearPercentIndicator(
                animation: true,
                barRadius: Radius.circular(50),
                lineHeight: 15,
                percent: percentage,
                progressColor: color,
                backgroundColor: Color(0xffF1F1FA),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

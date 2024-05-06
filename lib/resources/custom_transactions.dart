// import 'dart:math';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/resources/theme.dart';
import 'package:flutter/widgets.dart';

class CustomTransaction extends StatelessWidget {
  String title;
  String subtitle;
  String imgPath;
  int amount;
  String date;
  int type;
  CustomTransaction(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.imgPath,
      required this.amount,
      required this.date,
      required this.type});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final Random random = Random();
    // final Color randomColor = Color.fromARGB(
    //   255,
    //   random.nextInt(256),
    //   random.nextInt(256),
    //   random.nextInt(256),
    // );
    return Column(children: [
      Row(
        children: [
          Container(
            height: 100,
            width: screenWidth - 40,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Color(0xff1F1F1F),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 19.73, vertical: 14.49),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Color(0xff95AEEE)
                                  : Color(0xff7F3DFF),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Image(image: AssetImage(imgPath)),
                      ),
                      SizedBox(
                        width: 9,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Color(0xff292B2D)
                                    : Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              truncateText(subtitle, 10),
                              style: TextStyle(
                                color: Color(0xff91919F),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          type == 0
                              ? "-\$${amount.toString()}"
                              : "+\$${amount.toString()}",
                          style: TextStyle(
                            color: type == 0 ? myRed : myGreen,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          date,
                          style: TextStyle(
                            color: Color(0xff91919F),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 10,
      )
    ]);
  }

  String truncateText(String name, int limit) {
    if (name.length <= limit) {
      return "${name}";
    }
    name = name.substring(0, limit);
    return "${name}...";
  }
}

import 'package:flutter/material.dart';
import 'package:expense_tracker_app/resources/theme.dart';

class CustomHomeButton extends StatelessWidget {
  final String imgPath;
  final String text;
  const CustomHomeButton(
      {super.key, required this.imgPath, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).brightness == Brightness.light
              ? myblue
              : Color(0xff1F1F1F),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage(imgPath)),
            SizedBox(
              height: 10,
            ),
            Text(text,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ));
  }
}

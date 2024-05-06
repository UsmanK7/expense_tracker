import 'package:expense_tracker_app/resources/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnboardingCard extends StatelessWidget {
  final String image;
  final String title;
  final String buttonText;
  final String subtitle;
  final Function onpressed;

  const OnboardingCard(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle,
      required this.buttonText,
      required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.80,
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            image,
            fit: BoxFit.contain,
          ),
          Column(
            children: [
              Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Color(0xff212325)
                        : Colors.white,
                    fontWeight: FontWeight.w700,
                  )),
              SizedBox(
                height: 5,
              ),
              Text(subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Color(0xff91919F)
                        : Color(0xffA0A0B0),
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
          GestureDetector(
            onTap: () => onpressed(),
            child: Container(
              width: MediaQuery.of(context).size.width - 80,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).brightness == Brightness.light
                    ? myblue
                    : Color(0xff7F3DFF),
              ),
              child: Center(
                  child: Text(buttonText,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ))),
            ),
          )
        ],
      ),
    );
  }
}

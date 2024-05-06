import 'package:expense_tracker_app/resources/onboarding_card.dart';
import 'package:expense_tracker_app/resources/theme.dart';
import 'package:expense_tracker_app/services/theme_helper.dart';
import 'package:expense_tracker_app/views/add_bank_screen.dart';
import 'package:expense_tracker_app/views/onboarding_screens/account.dart';
import 'package:expense_tracker_app/views/onboarding_screens/onboarding_add_bank.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  static final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    List<Widget> oboardingPages = [
      OnboardingCard(
        image: "assets/onboarding/1-onboarding.png",
        title: "Gain total control \n of your money",
        buttonText: "Next",
        subtitle: "Become your own money manager \n and make every cent count",
        onpressed: () {
          _pageController.animateToPage(1,
              duration: Durations.long1, curve: Curves.easeIn);
        },
      ),
      OnboardingCard(
          image: "assets/onboarding/2-onboarding.png",
          title: "Know where your \n  money goes ",
          buttonText: "Next",
          subtitle:
              "Track your transaction easily,\n with categories and financial report",
          onpressed: () {
            _pageController.animateToPage(2,
                duration: Durations.long1, curve: Curves.easeIn);
          }),
      OnboardingCard(
          image: "assets/onboarding/4-onboarding.png",
          title: "Planning ahead",
          buttonText: "Lets Begin",
          subtitle:
              "Setup your budget for each category \n  so you in control ",
          onpressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => CreateAccount()));
          }),
    ];
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 40, right: 20),
                child: AnimatedSwitcher(
                  duration:
                      Duration(milliseconds: 500), // Adjust duration as needed
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(1.0, 0.0), // Slide from right
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                  child: IconButton(
                    key:
                        UniqueKey(), 
                    onPressed: () {
                      ThemeServices().SwitchTheme();
                    },
                    icon: Icon(
                      Theme.of(context).brightness == Brightness.light
                          ? Icons.sunny
                          : Icons.dark_mode,
                      size: 40,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
              child: PageView(
            controller: _pageController,
            children: oboardingPages,
          )),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: ExpandingDotsEffect(
                  dotColor: Color(0xffEEE5FF),
                  activeDotColor:
                      Theme.of(context).brightness == Brightness.light
                          ? myblue
                          : Color(0xff7F3DFF),
                ),
              )),
        ],
      ),
    );
  }
}

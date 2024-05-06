import 'package:expense_tracker_app/views/home_screen.dart';
import 'package:expense_tracker_app/views/onboarding_screens/information.dart';
import 'package:expense_tracker_app/views/onboarding_screens/onboarding_add_bank.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAccount extends StatelessWidget {
  CreateAccount({super.key});

  static final PageController _pageController = PageController(initialPage: 0);
  List<Widget> oboardingPages = [
    PersonalInformations(
      onpressed: () {
        _pageController.animateToPage(1,
            duration: Durations.long1, curve: Curves.easeIn);
      },
    ),
    OnAddBankScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: oboardingPages,
      ),
    );
  }
}

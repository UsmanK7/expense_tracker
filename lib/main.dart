import 'package:expense_tracker_app/homo.dart';
import 'package:expense_tracker_app/models/transactions_model.dart';
import 'package:expense_tracker_app/views/home.dart';
import 'package:expense_tracker_app/views/home_screen.dart';
import 'package:expense_tracker_app/views/onboarding_screens/onboarding_page.dart';
import 'package:expense_tracker_app/views/report_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:expense_tracker_app/resources/theme.dart';
import 'package:expense_tracker_app/services/theme_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // late bool onboard = false;
  // final _storage = GetStorage();
  // if (_storage.read('onboard') != null) {
  //   onboard = true;
  // }
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _storage = GetStorage();
  @override
  Widget build(BuildContext context) {
    bool isOnboard =
        _storage.read('onboard') ?? false; // Read onboard status from storage
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeServices().theme,
      home: isOnboard ? Home() : OnboardingPage(),
      // home: ReportScreen(),
    );
  }
}

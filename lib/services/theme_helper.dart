import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class ThemeServices{
  final _box = GetStorage();
  final _isDarkMode = 'isDarkMode';
  bool checkDarkmode() => _box.read(_isDarkMode)??false;
  _save_to_box(bool isDarkMode)=>_box.write(_isDarkMode, isDarkMode);


  ThemeMode get theme => checkDarkmode() ? ThemeMode.dark : ThemeMode.light;
  void SwitchTheme(){
    Get.changeThemeMode(checkDarkmode()?ThemeMode.light : ThemeMode.dark);
    _save_to_box(!checkDarkmode());
  }
}
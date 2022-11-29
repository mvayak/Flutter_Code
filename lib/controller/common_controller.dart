import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marlo/main.dart';

class CommonController extends GetxController {
  static CommonController get to => Get.find(); // add this

  RxBool isLightTheme = false.obs;

  saveThemeStatus() async {
    getPreference.write('theme', isLightTheme.value);
  }

  getThemeStatus() async {
    isLightTheme.value = getPreference.read('theme') ?? true;
    Get.changeThemeMode(isLightTheme.value ? ThemeMode.light : ThemeMode.dark);
  }
}
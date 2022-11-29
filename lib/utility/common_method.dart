

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api_call/api_config.dart';

isNotEmptyString(String? string) {
  return string != null && string.isNotEmpty;
}

showSnackBar({required String title, required String message}) {
  return Get.snackbar(
    title, // title
    message, // message
    backgroundColor: title.isEmpty || title == ApiConfig.warning
        ? const Color(0xffFFCC00)
        : title == ApiConfig.success
        ? Colors.green
        : Colors.red,
    colorText: title.isEmpty || title == ApiConfig.warning ? Colors.black : Colors.white,
    icon: Icon(
      title.isEmpty || title == ApiConfig.warning
          ? Icons.warning_amber_outlined
          : title == ApiConfig.success
          ? Icons.check_circle
          : Icons.error,
      color: title.isEmpty || title == ApiConfig.warning ? Colors.black : Colors.white,
    ),
    onTap: (_) {},
    shouldIconPulse: true,
    barBlur: 10,
    isDismissible: true,
    duration: const Duration(seconds: 2),
  );
}
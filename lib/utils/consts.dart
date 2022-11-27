import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Consts {
  static String baseURL = 'https://dummyjson.com';

  static double borderRadius = 5;

  static final String kApiUrl = defaultTargetPlatform == TargetPlatform.android
      ? 'http://10.0.2.2:4242'
      : 'http://localhost:4242';

  static final TextStyle customButtonTextStyle =
      Get.textTheme.headline6!.copyWith(color: Colors.white);

  static errorSnackBar(message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Get.theme.errorColor.withOpacity(0.8),
      barBlur: 10,
      borderRadius: Consts.borderRadius,
      colorText: Colors.white,
      icon: const Icon(
        Icons.error,
        color: Colors.white,
      ),
    );
  }

  static successSnackBar({
    required String title,
    required Widget body,
    required Duration duration,
  }) {
    Get.snackbar(
      '',
      '',
      titleText: Center(
        child: Text(
          title,
          style: Consts.customButtonTextStyle,
        ),
      ),
      messageText: body,
      barBlur: 10,
      colorText: Colors.white,
      maxWidth: Get.width * 0.5,
      borderRadius: Consts.borderRadius,
      backgroundColor: Get.theme.colorScheme.tertiary.withOpacity(0.7),
      duration: duration,
    );
  }
}

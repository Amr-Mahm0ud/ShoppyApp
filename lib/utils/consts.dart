import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Consts {
  static final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.black,
    Colors.grey,
    Colors.white,
  ];
  static final List<int> enableColors = [
    0,
    1,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    16,
    19
  ];
  static final List<int> enableClothsSize = [7, 8, 10];
  static final List<String> clothsSizes = ['S', 'M', 'L', 'XL', 'XXL'];
  static final List<int> enableShoesSize = [9, 11];
  static final List<int> shoesSizes = [37, 38, 39, 40, 41, 42, 43, 44, 45];
  static String baseURL = 'https://dummyjson.com';

  static double borderRadius = 5;

  static final List profilePictures = [
    'assets/images/1.png',
    'assets/images/2.png',
    'assets/images/3.png',
    'assets/images/4.png',
    'assets/images/5.png',
    'assets/images/6.png',
    'assets/images/7.png',
    'assets/images/8.png',
  ];

  // static const String kApiUrl = 'http://localhost:4242';

  static final TextStyle customButtonTextStyle =
      Get.textTheme.titleLarge!.copyWith(color: Colors.white);

  static errorSnackBar(message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Get.theme.colorScheme.error.withOpacity(0.8),
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

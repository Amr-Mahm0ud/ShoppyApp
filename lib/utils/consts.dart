import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Consts {
  static double borderRadius = 5;

  static List<String> categoriesImages = [
    "assets/categories/smartphones.png",
    "assets/categories/laptops.png",
    "assets/categories/fragrances.png",
    "assets/categories/skincare.png",
    "assets/categories/groceries.png",
    "assets/categories/home-decoration.png",
    "assets/categories/furniture.png",
    "assets/categories/tops.png",
    "assets/categories/womens-dresses.png",
    "assets/categories/womens-shoes.png",
    "assets/categories/mens-shirts.png",
    "assets/categories/mens-shoes.png",
    "assets/categories/mens-watches.png",
    "assets/categories/womens-watches.png",
    "assets/categories/womens-bags.png",
    "assets/categories/womens-jewellery.png",
    "assets/categories/sunglasses.png",
    "assets/categories/automotive.png",
    "assets/categories/motorcycle.png",
    "assets/categories/lighting.png",
  ];

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

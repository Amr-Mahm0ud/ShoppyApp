import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class WelcomeScreenController extends GetxController {
  List images = [
    'assets/images/splash_1.png',
    'assets/images/splash_2.png',
    'assets/images/splash_3.png',
  ];
  List titles = [
    'Find Favorite Items',
    'Quick & Easy payments',
    'Product Delivery',
  ];
  List texts = [
    'find your favorite products that\nyou want to buy easily',
    'pay for products you buy safely\nand easily',
    'your product is delivered to your\nhome rapidly',
  ];

  PageController pageController = PageController(
    initialPage: 0,
  );

  int currentPage = 0;

  bool isAnimating = false;

  animate() {
    isAnimating = !isAnimating;
    update();
  }

  changePage(newVal) {
    currentPage = newVal;

    update();
  }
}

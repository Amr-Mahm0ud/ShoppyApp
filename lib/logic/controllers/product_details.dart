import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  final colors = [
    Colors.red,
    Colors.blue,
    Colors.black,
    Colors.grey,
    Colors.white,
  ];
  final enableColors = [0, 1, 7, 8, 9, 10, 11, 12, 13, 14, 16, 19];

  RxInt selectedColor = 0.obs;

  RxInt index = 0.obs;
  RxBool isAnimating = false.obs;

  animate() {
    isAnimating.value = !isAnimating.value;
  }
}

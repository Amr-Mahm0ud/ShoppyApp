import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.black,
    Colors.grey,
    Colors.white,
  ];
  final List<int> enableColors = [0, 1, 7, 8, 9, 10, 11, 12, 13, 14, 16, 19];
  final List<int> enableClothsSize = [7, 8, 10];
  final List<String> clothsSizes = ['S', 'M', 'L', 'XL', 'XXL'];
  final List<int> enableShoesSize = [9, 11];
  final List<int> shoesSizes = [37, 38, 39, 40, 41, 42, 43, 44, 45];

  RxInt selectedColor = 0.obs;
  RxInt selectedClothSize = 0.obs;
  RxInt selectedShoesSize = 0.obs;

  RxInt index = 0.obs;
  RxBool isAnimating = false.obs;

  animate() {
    isAnimating.value = !isAnimating.value;
  }
}

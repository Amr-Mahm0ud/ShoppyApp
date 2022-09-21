import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget backButton() {
  return IconButton(
    onPressed: () {
      Get.back();
    },
    icon: const Icon(Icons.arrow_back_ios_new_sharp),
  );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/controllers/categories_controller.dart';
import '../../logic/controllers/product_controller.dart';

Widget switchAnimation({required first, required second}) {
  ProductController pController = Get.find();
  CategoriesController cController = Get.find();
  return AnimatedCrossFade(
    firstChild: first,
    secondChild: second,
    crossFadeState:
        (pController.isLoading.value || cController.isCategoriesLoading.value)
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
    duration: const Duration(milliseconds: 500),
  );
}

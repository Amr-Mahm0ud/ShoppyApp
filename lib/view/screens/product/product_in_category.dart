import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/logic/controllers/categories_controller.dart';
import 'package:shoppy/view/widgets/product/product_tile.dart';

import '../../../utils/consts.dart';

class ProductsInCategory extends StatelessWidget {
  const ProductsInCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoriesController controller = Get.find();
    BoxDecoration decoration = BoxDecoration(
      color: Get.theme.cardColor,
      borderRadius: BorderRadius.circular(Consts.borderRadius),
    );
    return Obx(
      () => controller.isProductsLoading.value
          ? Scaffold(
              appBar: AppBar(
                title: Container(
                  decoration: decoration,
                  width: 100,
                  height: 30,
                ),
                leading: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CircleAvatar(
                    backgroundColor: Get.theme.cardColor,
                  ),
                ),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LinearProgressIndicator(),
                    const SizedBox(height: 10),
                    Container(
                      decoration: decoration,
                      width: Get.width * 0.9,
                      height: Get.height * 0.15,
                    ),
                    const SizedBox(height: 15),
                    Container(
                      decoration: decoration,
                      width: Get.width * 0.9,
                      height: Get.height * 0.15,
                    ),
                    const SizedBox(height: 15),
                    Container(
                      decoration: decoration,
                      width: Get.width * 0.9,
                      height: Get.height * 0.15,
                    ),
                    const SizedBox(height: 15),
                    Container(
                      decoration: decoration,
                      width: Get.width * 0.9,
                      height: Get.height * 0.15,
                    ),
                    const SizedBox(height: 15),
                    Container(
                      decoration: decoration,
                      width: Get.width * 0.9,
                      height: Get.height * 0.15,
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                title: Text(controller.currentCategoryName.value),
              ),
              body: ListView(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                physics: const BouncingScrollPhysics(),
                children: controller.allProductsInCategory
                    .map(
                      (element) => ProductTile(product: element),
                    )
                    .toList(),
              ),
            ),
    );
  }
}

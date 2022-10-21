import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/logic/controllers/product_controller.dart';
import 'package:shoppy/view/widgets/product/product_tile.dart';

import '../../../widgets/auth/input_field.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductController controller = Get.find();
    return controller.isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Obx(
            () => SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(
                  top: Get.height * 0.015,
                  bottom: MediaQuery.of(context).padding.bottom,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: Get.width * 0.9,
                      child: inputField(
                        icon: Icons.search_rounded,
                        label: 'Search',
                        onChange: (p0) {
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    Column(
                      children: controller.allProducts
                          .map((product) => ProductTile(product: product))
                          .toList(),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}

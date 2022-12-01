import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shoppy/logic/controllers/product_controller.dart';
import 'package:shoppy/view/widgets/product/product_tile.dart';

import '../../../../utils/consts.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductController controller = Get.find();
    if (controller.isLoading.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Obx(
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
                  child: TextField(
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Consts.borderRadius),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Consts.borderRadius),
                        borderSide:
                            BorderSide(color: Get.theme.cardColor, width: 1),
                      ),
                      hintText: 'Search by name',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: controller.searchController.text.isEmpty
                          ? null
                          : IconButton(
                              onPressed: () {
                                controller.clearSearch();
                              },
                              icon: const Icon(Icons.clear),
                            ),
                    ),
                    onChanged: (searchVal) {
                      controller.findProductByName(searchVal);
                    },
                  ),
                ),
                if (controller.searchController.text.isNotEmpty &&
                    controller.searchResult.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.2),
                    child: Lottie.asset(
                      'assets/lotties/not_found.json',
                      repeat: false,
                    ),
                  )
                else ...[
                  SizedBox(height: Get.height * 0.02),
                  Column(
                    children: (controller.searchController.text.isNotEmpty &&
                            controller.searchResult.isNotEmpty)
                        ? controller.searchResult
                            .map((product) => ProductTile(product: product))
                            .toList()
                        : controller.allProducts
                            .map((product) => ProductTile(product: product))
                            .toList(),
                  )
                ]
              ],
            ),
          ),
        ),
      );
    }
  }
}

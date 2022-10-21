import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shoppy/logic/controllers/product_controller.dart';

import '../../../widgets/product/product_tile.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();
    return Obx(
      () => controller.favorites.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/lotties/empty_bag.json',
                  width: Get.width * 0.75,
                ),
                const SizedBox(height: 20),
                Text(
                  'Your wishlist is empty \n discover products to add some',
                  style: Get.textTheme.headline6!
                      .copyWith(color: Get.textTheme.headline4!.color),
                  textAlign: TextAlign.center,
                ),
              ],
            )
          : Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom,
                left: Get.width * 0.05,
                right: Get.width * 0.05,
                top: Get.height * 0.02,
              ),
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) => ProductTile(
                  product: controller.favorites[index],
                  inFavoriteScreen: true,
                ),
                itemCount: controller.favorites.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
              ),
            ),
    );
  }
}

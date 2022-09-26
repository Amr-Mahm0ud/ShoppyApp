import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/product/product_tile.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List items = [1, 1, 2, 3, 4, 5];
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom,
        left: Get.width * 0.05,
        right: Get.width * 0.05,
        top: Get.height * 0.02,
      ),
      child: AnimatedList(
        itemBuilder:
            (BuildContext context, int index, Animation<double> animation) {
          return const ProductTile();
        },
        initialItemCount: items.length,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
      ),
    );
  }
}

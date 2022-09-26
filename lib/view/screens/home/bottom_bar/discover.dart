import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/view/widgets/product/product_card.dart';
import 'package:shoppy/view/widgets/product/product_tile.dart';

import '../../../widgets/auth/input_field.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List items = [1, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 2, 3, 4, 5];
    return SingleChildScrollView(
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
              children: items.map((e) => const ProductTile()).toList(),
            )
          ],
        ),
      ),
    );
  }
}

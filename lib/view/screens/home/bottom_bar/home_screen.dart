import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/logic/controllers/categories_controller.dart';
import 'package:shoppy/logic/controllers/product_controller.dart';
import 'package:shoppy/view/screens/product/product_in_category.dart';
import 'package:shoppy/view/widgets/product/product_card.dart';

import '../../../../utils/consts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoriesController = Get.find<CategoriesController>();
    final productController = Get.find<ProductController>();
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          Get.width * 0.05,
          0,
          Get.width * 0.05,
          MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.25,
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(vertical: 15),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: categoriesController.allCategories.length,
                itemBuilder: (context, index) => InkWell(
                  borderRadius: BorderRadius.circular(Consts.borderRadius),
                  onTap: () {
                    categoriesController.getProductsInCategory(
                        categoriesController.allCategories[index]);
                    Get.to(() => const ProductsInCategory());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Get.theme.cardColor),
                      borderRadius: BorderRadius.circular(Consts.borderRadius),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: Image.asset(
                        categoriesController.categoriesImages[index]),
                  ),
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Recommended',
              style: Get.textTheme.headline6!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
            buildSection(
              productController.allProducts
                  .getRange(
                      productController.random, productController.random + 7)
                  .toList(),
            ),
            const SizedBox(height: 10),
            Text(
              'Hot Deals',
              style: Get.textTheme.headline6!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
            buildSection(
              productController.allProducts
                  .where((item) => item.discountPercentage > 15)
                  .toList(),
            ),
            const SizedBox(height: 10),
            Text(
              'Top Rated',
              style: Get.textTheme.headline6!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
            buildSection(productController.allProducts
                .where(
                  (item) => item.rating > 4.5,
                )
                .toList()),
          ],
        ),
      ),
    );
  }

  SizedBox buildSection(List items) {
    return SizedBox(
      height: Get.height * 0.3,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: items.map(
            (item) {
              return Padding(
                padding: EdgeInsets.only(
                  left: items.first == item ? 0 : 7,
                  right: items.last == item ? 0 : 7,
                ),
                child: ProductCard(product: item),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

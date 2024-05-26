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
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom,
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
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(7),
                    child: Text(
                      categoriesController.allCategories[index],
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
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
            productController.allProducts.isEmpty
                ? SizedBox(
                    height: Get.height * 0.3,
                    child: Container(
                      height: Get.height * 0.3,
                      width: Get.width * 0.9,
                      decoration: BoxDecoration(
                        color: Get.theme.cardColor,
                        borderRadius:
                            BorderRadius.circular(Consts.borderRadius),
                      ),
                    ),
                  )
                : buildSection(
                    productController.allProducts
                        .getRange(productController.random.value,
                            productController.random.value + 7)
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

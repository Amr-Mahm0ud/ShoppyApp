import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/logic/controllers/categories_controller.dart';
import 'package:shoppy/logic/controllers/product_details.dart';
import 'package:shoppy/model/product_model.dart';
import 'package:shoppy/view/screens/product/product_in_category.dart';
import 'package:shoppy/view/widgets/bouncing_animation.dart';
import 'package:shoppy/view/widgets/custom_button.dart';
import 'package:shoppy/view/widgets/switch_animation.dart';

import '../../../logic/controllers/product_controller.dart';
import '../../../utils/consts.dart';
import '../../../utils/themes.dart';
import '../../widgets/product/product_card.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();
    final productController = Get.find<ProductDetailsController>();
    final categoriesController = Get.find<CategoriesController>();
    final ProductModel product = controller.currentProduct!.value;
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                constraints: const BoxConstraints(),
                icon: controller.isFavorite(product.id)
                    ? const Icon(Icons.favorite)
                    : const Icon(Icons.favorite_outline),
                onPressed: () {
                  controller.isFavorite(product.id)
                      ? controller.removeFromFavorite(product.id)
                      : controller.addToFavorite(product.id);
                },
              ),
              const SizedBox(width: 10)
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (categoriesController.allProductsInCategory.isEmpty)
                  const LinearProgressIndicator(),
                //tittle
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 10, horizontal: Get.width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.brand,
                        style: Get.textTheme.titleMedium!.copyWith(
                          color: Get.theme.colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        product.title,
                        style: Get.textTheme.headline5,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                //images & colors
                Row(
                  children: [
                    if (productController.enableColors.contains(
                        categoriesController.allCategories
                            .indexOf(product.category)))
                      Column(
                        children: productController.colors
                            .map(
                              (color) => GestureDetector(
                                onTap: () {
                                  productController.selectedColor(
                                      productController.colors.indexOf(color));
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: productController.colors
                                                .indexOf(color) ==
                                            productController
                                                .selectedColor.value
                                        ? color
                                        : color.withOpacity(0.4),
                                    border: Border.all(
                                      color: productController.colors
                                                  .indexOf(color) ==
                                              productController
                                                  .selectedColor.value
                                          ? Get.theme.colorScheme.tertiary
                                          : Get.theme.cardColor,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    Expanded(
                      child: SizedBox(
                        height: Get.height * 0.3,
                        // width: Get.width * 0.8,
                        child: PageView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          children: product.images
                              .map(
                                (image) => Image.network(
                                  image,
                                  fit: BoxFit.fill,
                                ),
                              )
                              .toList(),
                          onPageChanged: (value) {
                            productController.animate();
                            productController.index(value);
                            Future.delayed(const Duration(milliseconds: 200))
                                .then(
                              (value) => productController.animate(),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                //indicator
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: buildIndicator(),
                ),
                //product Information
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        color: Get.theme.cardColor,
                        thickness: 2,
                        height: 0,
                      ),
                      //Sizes
                      if (productController.enableClothsSize.contains(
                              categoriesController.allCategories
                                  .indexOf(product.category)) ||
                          productController.enableShoesSize.contains(
                              categoriesController.allCategories
                                  .indexOf(product.category)))
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: productController.enableClothsSize
                                    .contains(categoriesController.allCategories
                                        .indexOf(product.category))
                                ? productController.clothsSizes
                                    .map(
                                      (size) => GestureDetector(
                                        onTap: () {
                                          productController.selectedClothSize(
                                              productController.clothsSizes
                                                  .indexOf(size));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            top: 15,
                                            left: productController
                                                        .clothsSizes.first ==
                                                    size
                                                ? 0
                                                : 10,
                                          ),
                                          width: 45,
                                          height: 45,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 2,
                                              color: productController
                                                          .clothsSizes
                                                          .indexOf(size) ==
                                                      productController
                                                          .selectedClothSize
                                                          .value
                                                  ? Get.theme.colorScheme
                                                      .tertiary
                                                  : Get.theme.cardColor,
                                            ),
                                          ),
                                          child: Text(
                                            size,
                                            style: Get.textTheme.headline6!
                                                .copyWith(
                                              color: productController
                                                          .clothsSizes
                                                          .indexOf(size) ==
                                                      productController
                                                          .selectedClothSize
                                                          .value
                                                  ? Get.textTheme.headline5!
                                                      .color
                                                  : Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList()
                                : productController.shoesSizes
                                    .map(
                                      (size) => GestureDetector(
                                        onTap: () {
                                          productController.selectedShoesSize(
                                              productController.shoesSizes
                                                  .indexOf(size));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            top: 15,
                                            left: productController
                                                        .shoesSizes.first ==
                                                    size
                                                ? 0
                                                : 10,
                                          ),
                                          width: 45,
                                          height: 45,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 2,
                                              color: productController
                                                          .shoesSizes
                                                          .indexOf(size) ==
                                                      productController
                                                          .selectedShoesSize
                                                          .value
                                                  ? Get.theme.colorScheme
                                                      .tertiary
                                                  : Get.theme.cardColor,
                                            ),
                                          ),
                                          child: Text(
                                            size.toString(),
                                            style: Get.textTheme.headline6!
                                                .copyWith(
                                              color: productController
                                                          .shoesSizes
                                                          .indexOf(size) ==
                                                      productController
                                                          .selectedShoesSize
                                                          .value
                                                  ? Get.textTheme.headline5!
                                                      .color
                                                  : Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                        ),
                      const SizedBox(height: 15),
                      //price & rate
                      Row(
                        children: [
                          Text(
                            '\$ ',
                            style: Get.textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            '${product.price}',
                            style: Get.textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const Spacer(),
                          Text(product.rating.toString()),
                          Icon(
                            Icons.star,
                            color: Get.theme.primaryColor,
                            size: 20,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      //offer
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '\$ ',
                            style: Get.textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          Text(
                            '${product.price + (product.discountPercentage / 100 * product.price).ceil()}',
                            style: Get.textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Text(
                            '${product.discountPercentage.floor()}% OFF',
                            style: Get.textTheme.headline6!.copyWith(
                              color: Get.theme.primaryColor,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      Divider(
                        color: Get.theme.cardColor,
                        thickness: 2,
                        height: 0,
                      ),
                      const SizedBox(height: 15),
                      //category
                      Row(
                        children: [
                          Text(
                            'Category:',
                            style: Get.textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            product.category,
                            style: Get.textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      //stock
                      Row(
                        children: [
                          Text(
                            'In stock:',
                            style: Get.textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            product.stock.toString(),
                            style: Get.textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      //description
                      Text(
                        product.description,
                        style: Get.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Divider(
                        color: Get.theme.cardColor,
                        thickness: 2,
                        height: 0,
                      ),
                      const SizedBox(height: 20),
                      AnimatedCrossFade(
                        duration: const Duration(milliseconds: 500),
                        crossFadeState:
                            categoriesController.allProductsInCategory.isEmpty
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                        firstChild: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Get.theme.cardColor,
                                borderRadius:
                                    BorderRadius.circular(Consts.borderRadius),
                              ),
                              width: 150,
                              height: 30,
                            ),
                            CircleAvatar(backgroundColor: Get.theme.cardColor),
                          ],
                        ),
                        secondChild: GestureDetector(
                          onTap: () {
                            Get.to(() => const ProductsInCategory());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'More From ${product.category}',
                                style: Get.textTheme.headline6!
                                    .copyWith(fontWeight: FontWeight.normal),
                              ),
                              const Icon(Icons.arrow_forward)
                            ],
                          ),
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child:
                            categoriesController.allProductsInCategory.isEmpty
                                ? loadingSection([1, 2, 3], true)
                                : buildSection(
                                    categoriesController.allProductsInCategory
                                        .getRange(0, 5)
                                        .toList(),
                                  ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.all(Get.width * 0.05),
            child: Row(
              children: [
                Expanded(
                  child: BouncingAnimation(
                    child: CustomButton(
                      filled: false,
                      onTap: () {},
                      child: Text(
                        'Add To Cart',
                        style: Get.textTheme.headline6,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: BouncingAnimation(
                    child: CustomButton(
                      filled: true,
                      onTap: () {},
                      child: Text(
                        'Buy Now',
                        style: Get.textTheme.headline6!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

SizedBox loadingSection(List items, full) {
  return SizedBox(
    height: full ? Get.height * 0.25 : Get.height * 0.2,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items.map(
        (item) {
          return Container(
            width: Get.width * 0.275,
            decoration: BoxDecoration(
              color: Get.theme.cardColor,
              borderRadius: BorderRadius.circular(Consts.borderRadius),
            ),
          );
        },
      ).toList(),
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

buildIndicator() {
  final productController = Get.find<ProductDetailsController>();
  final controller = Get.find<ProductController>();
  final int length = controller.currentProduct!.value.images.length;
  final int index = productController.index.value;
  return Align(
    alignment: const Alignment(0, 0.45),
    child: Container(
      width: 15.0 * controller.currentProduct!.value.images.length,
      height: 15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: cardLight,
      ),
      child: Obx(
        () => AnimatedAlign(
          alignment: length != 1
              ? Alignment((index * (2 / (length - 1)) - 1), 0)
              : Alignment.center,
          duration: const Duration(milliseconds: 300),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: productController.isAnimating.value ? 30 : 15,
            height: 15,
            decoration: BoxDecoration(
              color: Get.theme.primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    ),
  );
}

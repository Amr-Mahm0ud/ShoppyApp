import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/logic/controllers/cart_controller.dart';
import 'package:shoppy/logic/controllers/categories_controller.dart';
import 'package:shoppy/logic/controllers/product_details_controller.dart';
import 'package:shoppy/model/product_model.dart';
import 'package:shoppy/view/screens/product/product_in_category.dart';
import 'package:shoppy/view/widgets/bouncing_animation.dart';
import 'package:shoppy/view/widgets/custom_button.dart';

import '../../../logic/controllers/product_controller.dart';
import '../../../utils/consts.dart';
import '../../../utils/themes.dart';
import '../../widgets/product/product_card.dart';
import '../order/cart_screen.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();
    final productController = Get.find<ProductDetailsController>();
    final categoriesController = Get.find<CategoriesController>();
    final cartController = Get.find<CartController>();
    final ProductModel product = controller.currentProduct!.value;
    return Obx(
      () {
        int quantity = cartController.cartItems
                .any((element) => element.item.id == product.id)
            ? cartController.cartItems
                .singleWhere((element) => element.item.id == product.id)
                .quantity
            : 0;
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                padding: EdgeInsets.zero,
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
              GestureDetector(
                onTap: () {
                  Get.to(() => const CartScreen(),
                      transition: Transition.cupertino);
                },
                child: SizedBox(
                  width: Get.width * 0.15,
                  height: Get.width * 0.15,
                  child: Obx(
                    () => AnimatedRotation(
                      turns: cartController.shakeAnimation.value,
                      duration: const Duration(milliseconds: 100),
                      child: Stack(
                        children: [
                          const Align(
                            alignment: Alignment.center,
                            child: Icon(Icons.shopping_cart_outlined),
                          ),
                          Align(
                            alignment: const Alignment(0.5, -0.5),
                            child: AnimatedContainer(
                              transformAlignment: Alignment.center,
                              duration: const Duration(milliseconds: 100),
                              width: cartController.animateNum.value ? 0 : 18,
                              height: cartController.animateNum.value ? 0 : 18,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Get.theme.backgroundColor,
                                  width: 2,
                                ),
                                color: Get.theme.errorColor,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: cartController.animateNum.value
                                  ? null
                                  : Text(
                                      cartController.cartItems.length
                                          .toString(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
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
                    if (Consts.enableColors.contains(categoriesController
                        .allCategories
                        .indexOf(product.category)))
                      Column(
                        children: Consts.colors
                            .map(
                              (color) => GestureDetector(
                                onTap: () {
                                  productController.selectedColor(
                                      Consts.colors.indexOf(color));
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
                                    color: Consts.colors.indexOf(color) ==
                                            productController
                                                .selectedColor.value
                                        ? color
                                        : color.withOpacity(0.4),
                                    border: Border.all(
                                      color: Consts.colors.indexOf(color) ==
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
                      if (Consts.enableClothsSize.contains(categoriesController
                              .allCategories
                              .indexOf(product.category)) ||
                          Consts.enableShoesSize.contains(categoriesController
                              .allCategories
                              .indexOf(product.category)))
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: Consts.enableClothsSize.contains(
                                    categoriesController.allCategories
                                        .indexOf(product.category))
                                ? Consts.clothsSizes
                                    .map(
                                      (size) => GestureDetector(
                                        onTap: () {
                                          productController.selectedClothSize(
                                              Consts.clothsSizes.indexOf(size));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            top: 15,
                                            left:
                                                Consts.clothsSizes.first == size
                                                    ? 0
                                                    : 10,
                                          ),
                                          width: 45,
                                          height: 45,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 2,
                                              color: Consts.clothsSizes
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
                                              color: Consts.clothsSizes
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
                                : Consts.shoesSizes
                                    .map(
                                      (size) => GestureDetector(
                                        onTap: () {
                                          productController.selectedShoesSize(
                                              Consts.shoesSizes.indexOf(size));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            top: 15,
                                            left:
                                                Consts.shoesSizes.first == size
                                                    ? 0
                                                    : 10,
                                          ),
                                          width: 45,
                                          height: 45,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 2,
                                              color: Consts.shoesSizes
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
                                              color: Consts.shoesSizes
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
                      const SizedBox(height: 10),
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
                      filled: true,
                      onTap: () {
                        cartController.animateShaking();
                        cartController.addToCart(
                          item: product,
                          cSize: productController.selectedClothSize.value,
                          color: productController.selectedColor.value,
                          sSize: productController.selectedShoesSize.value,
                        );
                      },
                      child: AnimatedCrossFade(
                        firstChild: Text(
                          'Add To Cart',
                          style: Get.textTheme.headline6!
                              .copyWith(color: Colors.white),
                        ),
                        secondChild: Text(
                          'Increase quantity  $quantity',
                          style: Get.textTheme.headline6!
                              .copyWith(color: Colors.white),
                        ),
                        crossFadeState: cartController.cartItems
                                .any((element) => element.item.id == product.id)
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 200),
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

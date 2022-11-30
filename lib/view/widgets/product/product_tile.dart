import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/logic/controllers/cart_controller.dart';
import 'package:shoppy/model/product_model.dart';
import 'package:shoppy/view/screens/product/product_details.dart';

import '../../../bindings/product_details.dart';
import '../../../logic/controllers/categories_controller.dart';
import '../../../logic/controllers/product_controller.dart';
import '../../../utils/consts.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;
  final bool? inFavoriteScreen;
  const ProductTile({Key? key, required this.product, this.inFavoriteScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();
    final cartController = Get.find<CartController>();

    return GestureDetector(
      onTap: () {
        final cController = Get.find<CategoriesController>();
        controller.currentProduct = product.obs;
        cController.getProductsInCategory(product.category);
        Get.to(
          () => const ProductDetails(),
          transition: Transition.cupertino,
          binding: ProductBinding(),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Get.theme.cardColor),
          borderRadius: BorderRadius.circular(Consts.borderRadius),
        ),
        height: Get.height * 0.15,
        width: Get.width * 0.9,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Consts.borderRadius),
                    bottomLeft: Radius.circular(Consts.borderRadius),
                  ),
                  image: DecorationImage(
                      image: NetworkImage(product.thumbnail), fit: BoxFit.fill),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Get.textTheme.titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      product.category,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          Get.textTheme.bodyText1!.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "\$ ${product.price}",
                          style: Get.textTheme.bodyText1!
                              .copyWith(color: Get.theme.primaryColor),
                        ),
                        const SizedBox(width: 20),
                        Text(product.rating.toString()),
                        Icon(
                          Icons.star,
                          color: Get.theme.primaryColor,
                          size: 20,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Obx(
                    () => IconButton(
                      icon: controller.isFavorite(product.id)
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_outline),
                      onPressed: () {
                        controller.isFavorite(product.id)
                            ? controller.removeFromFavorite(product.id)
                            : controller.addToFavorite(product.id);
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  Obx(
                    () => IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: AnimatedCrossFade(
                        firstChild:
                            const Icon(Icons.add_shopping_cart_outlined),
                        crossFadeState: cartController.cartItems.any(
                          (element) => element.item.id == product.id,
                        )
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        duration: const Duration(milliseconds: 300),
                        secondChild: const Icon(Icons.shopping_cart_outlined),
                      ),
                      onPressed: () {
                        cartController.animateShaking();
                        cartController.addToCart(
                          item: product,
                          cSize: 0,
                          color: 0,
                          sSize: 0,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

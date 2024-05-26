import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/bindings/product_details.dart';
import 'package:shoppy/logic/controllers/cart_controller.dart';
import 'package:shoppy/logic/controllers/categories_controller.dart';
import 'package:shoppy/logic/controllers/product_controller.dart';
import 'package:shoppy/model/product_model.dart';

import '../../../utils/consts.dart';
import '../../screens/product/product_details.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();
    final CartController cartController = Get.find<CartController>();
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
        width: Get.width * 0.45,
        decoration: BoxDecoration(
          border: Border.all(color: Get.theme.cardColor),
          borderRadius: BorderRadius.circular(Consts.borderRadius),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: Get.height * 0.15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Consts.borderRadius),
                  topRight: Radius.circular(Consts.borderRadius),
                ),
                image: DecorationImage(
                    image: NetworkImage(product.thumbnail), fit: BoxFit.fill),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Get.textTheme.titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    product.category,
                    style:
                        Get.textTheme.bodyText1!.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (product.discountPercentage > 15)
                            Text(
                              "\$${(product.price + (product.price * product.discountPercentage / 100)).floor()}",
                              style: Get.textTheme.bodySmall!.copyWith(
                                decoration: TextDecoration.lineThrough,
                                decorationThickness: 2,
                                decorationStyle: TextDecorationStyle.solid,
                              ),
                            ),
                          const SizedBox(width: 5),
                          Text(
                            "\$${product.price}",
                            style: Get.textTheme.bodyText1!
                                .copyWith(color: Get.theme.primaryColor),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Obx(
                        () => InkWell(
                          child: controller.isFavorite(product.id)
                              ? const Icon(Icons.favorite)
                              : const Icon(Icons.favorite_outline),
                          onTap: () {
                            controller.isFavorite(product.id)
                                ? controller.removeFromFavorite(product.id)
                                : controller.addToFavorite(product.id);
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Obx(
                        () => InkWell(
                          child: AnimatedCrossFade(
                            firstChild:
                                const Icon(Icons.add_shopping_cart_outlined),
                            crossFadeState: cartController.cartItems.any(
                              (element) => element.item.id == product.id,
                            )
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                            duration: const Duration(milliseconds: 300),
                            secondChild:
                                const Icon(Icons.shopping_cart_outlined),
                          ),
                          onTap: () {
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

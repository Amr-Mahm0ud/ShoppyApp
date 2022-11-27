import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/logic/controllers/cart_controller.dart';
import 'package:shoppy/model/cart_item_model.dart';
import 'package:shoppy/view/screens/product/product_details.dart';

import '../../../bindings/product_details.dart';
import '../../../logic/controllers/categories_controller.dart';
import '../../../logic/controllers/product_controller.dart';
import '../../../utils/consts.dart';

class CartItem extends StatelessWidget {
  final CartItemModel item;

  const CartItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();
    final cartController = Get.find<CartController>();

    return GestureDetector(
      onTap: () {
        final cController = Get.find<CategoriesController>();
        controller.currentProduct = item.item.obs;
        cController.getProductsInCategory(item.item.category);
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
            //image
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
                      image: NetworkImage(item.item.thumbnail),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            const SizedBox(width: 10),
            //info
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.item.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Get.textTheme.titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      item.item.category,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          Get.textTheme.bodyText1!.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    //increase or decrease
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Get.theme.cardColor,
                            child: IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                cartController.addToCart(item.item);
                              },
                            ),
                          ),
                          Text(
                            item.quantity.toString(),
                            style: Get.textTheme.headline6!
                                .copyWith(color: Get.theme.primaryColor),
                          ),
                          CircleAvatar(
                            backgroundColor: Get.theme.cardColor,
                            child: IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                cartController.decreaseFromCart(item.item);
                              },
                            ),
                          ),
                          Text(
                            "\$ ${item.totalPrice}",
                            style: Get.textTheme.bodyText1!
                                .copyWith(color: Get.theme.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //remove
            Expanded(
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    cartController.removeFromCart(item.item);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

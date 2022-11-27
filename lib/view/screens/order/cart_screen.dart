import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shoppy/logic/controllers/cart_controller.dart';
import 'package:shoppy/view/screens/order/order_screen.dart';
import 'package:shoppy/view/widgets/cart_item.dart';

import '../../widgets/bouncing_animation.dart';
import '../../widgets/custom_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your cart'),
        leading: const BackButton(),
      ),
      body: Obx(
        () {
          return cartController.cartItems.isEmpty
              ? SizedBox(
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Lottie.asset(
                          'assets/lotties/empty_cart.json',
                          height: Get.height * 0.25,
                          repeat: false,
                          alignment: Alignment.center,
                          animate: true,
                        ),
                      ),
                      Text(
                        'Your Cart is empty\n Add some products to buy.',
                        style: Get.textTheme.headline6!
                            .copyWith(fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: cartController.cartItems.length,
                  itemBuilder: (context, index) => CartItem(
                    item: cartController.cartItems[index],
                  ),
                );
        },
      ),
      bottomNavigationBar: Obx(
        () => AnimatedCrossFade(
          duration: const Duration(milliseconds: 200),
          crossFadeState: cartController.cartItems.isEmpty
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: const SizedBox(),
          secondChild: Container(
            padding: EdgeInsets.all(Get.width * 0.05),
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total:',
                        style: Get.textTheme.bodyText1!
                            .copyWith(color: Colors.grey)),
                    Obx(
                      () => Text(
                        "${cartController.totalPrice} \$",
                        style: Get.textTheme.headline5!
                            .copyWith(color: Get.theme.primaryColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: BouncingAnimation(
                    child: CustomButton(
                      filled: true,
                      onTap: () {
                        Get.to(
                          () => const OrderScreen(),
                        );
                      },
                      child: Text(
                        'Order Now',
                        style: Get.textTheme.headline6!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

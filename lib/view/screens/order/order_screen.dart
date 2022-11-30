import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shoppy/bindings/main_binding.dart';
import 'package:shoppy/logic/controllers/cart_controller.dart';
import 'package:shoppy/logic/controllers/categories_controller.dart';
import 'package:shoppy/utils/consts.dart';
import 'package:shoppy/view/screens/home/main_screen.dart';
import 'package:shoppy/view/widgets/auth/input_field.dart';
import 'package:shoppy/view/widgets/bouncing_animation.dart';
import 'package:shoppy/view/widgets/custom_button.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController card = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();
    final categoriesController = Get.find<CategoriesController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        centerTitle: true,
      ),
      body: Obx(
        () => SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final element = controller.cartItems[index];
                  return AnimatedContainer(
                    height: controller.showMore.value
                        ? Get.height * 0.17
                        : Get.height * 0.1,
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Consts.borderRadius),
                      border: Border.all(
                        color: Get.theme.cardColor,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(element.item.title,
                                    style: Get.textTheme.headline6),
                              ],
                            ),
                            Text(element.item.brand),
                            if (controller.showMore.value) ...[
                              const SizedBox(height: 10),
                              //color
                              if (Consts.enableColors.contains(
                                  categoriesController.allCategories
                                      .indexOf(element.item.category)))
                                RichText(
                                  text: TextSpan(
                                    text: 'color: ',
                                    style: Get.textTheme.bodyText1!
                                        .copyWith(color: Colors.grey),
                                    children: [
                                      TextSpan(
                                        text: showColor(element.color),
                                        style: (element.color != 2 ||
                                                element.color != 4)
                                            ? Get.textTheme.bodyText1!.copyWith(
                                                color: Consts
                                                    .colors[element.color])
                                            : Get.textTheme.bodyText1,
                                      ),
                                    ],
                                  ),
                                ),

                              //cloth size
                              if (Consts.enableClothsSize.contains(
                                  categoriesController.allCategories
                                      .indexOf(element.item.category)))
                                RichText(
                                  text: TextSpan(
                                    text: 'size: ',
                                    style: Get.textTheme.bodyText1!
                                        .copyWith(color: Colors.grey),
                                    children: [
                                      TextSpan(
                                        text: Consts
                                            .clothsSizes[element.clothSize],
                                        style: Get.textTheme.bodyText1,
                                      ),
                                    ],
                                  ),
                                ),
                              //shoes size
                              if (Consts.shoesSizes.contains(
                                  categoriesController.allCategories
                                      .indexOf(element.item.category)))
                                RichText(
                                  text: TextSpan(
                                    text: 'size: ',
                                    style: Get.textTheme.bodyText1!
                                        .copyWith(color: Colors.grey),
                                    children: [
                                      TextSpan(
                                        text: Consts
                                            .shoesSizes[element.shoesSize]
                                            .toString(),
                                        style: Get.textTheme.bodyText1,
                                      ),
                                    ],
                                  ),
                                ),
                              //quantity
                              RichText(
                                text: TextSpan(
                                  text: 'quantity: ',
                                  style: Get.textTheme.bodyText1!
                                      .copyWith(color: Colors.grey),
                                  children: [
                                    TextSpan(
                                      text: element.quantity.toString(),
                                      style: Get.textTheme.titleMedium!
                                          .copyWith(
                                              color: Get.theme.primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'item price: ',
                                      style: Get.textTheme.bodyText1!
                                          .copyWith(color: Colors.grey),
                                      children: [
                                        TextSpan(
                                          text: element.item.price.toString(),
                                          style: Get.textTheme.titleMedium!
                                              .copyWith(
                                                  color:
                                                      Get.theme.primaryColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: 'item price: ',
                                      style: Get.textTheme.bodyText1!
                                          .copyWith(color: Colors.grey),
                                      children: [
                                        TextSpan(
                                          text: element.totalPrice.toString(),
                                          style: Get.textTheme.titleMedium!
                                              .copyWith(
                                                  color:
                                                      Get.theme.primaryColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: controller.cartItems.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
              ),
              TextButton(
                onPressed: () {
                  controller.showMore(!controller.showMore.value);
                },
                child: Text(
                  '${controller.showMore.value ? 'Hide' : 'Show'} Details',
                  style: Get.textTheme.bodyText1!
                      .copyWith(color: Get.theme.primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: Get.height * 0.07,
        margin: EdgeInsets.all(Get.width * 0.05),
        child: Obx(
          () => BouncingAnimation(
            child: CustomButton(
              onTap: controller.payAnimation.value
                  ? null
                  : () {
                      Get.bottomSheet(
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: Get.width * 0.05,
                            horizontal: Get.width * 0.05,
                          ),
                          decoration: BoxDecoration(
                            color: Get.theme.scaffoldBackgroundColor,
                            borderRadius:
                                BorderRadius.circular(Consts.borderRadius),
                          ),
                          child: SingleChildScrollView(
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Get.theme.cardColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    width: Get.width * 0.2,
                                    height: 8,
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    'Checkout',
                                    style: Get.textTheme.headline4,
                                  ),
                                  const SizedBox(height: 15),
                                  inputField(
                                    label: 'Name',
                                    icon: Icons.person,
                                    type: TextInputType.name,
                                    controller: name,
                                    validator: (val) {
                                      if (val == null || val.trim().isEmpty) {
                                        return 'Name is required';
                                      }
                                      return null;
                                    },
                                    onSave: (val) {
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 15),
                                  inputField(
                                    label: 'Phone Number',
                                    icon: Icons.phone,
                                    type: TextInputType.phone,
                                    controller: phone,
                                    validator: (val) {
                                      if (val == null || val.trim().isEmpty) {
                                        return 'Phone is required';
                                      } else if (val.length != 11) {
                                        return 'Phone is not valid';
                                      }
                                      return null;
                                    },
                                    onSave: (val) {
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 15),
                                  inputField(
                                    label: 'Card Number',
                                    icon: Icons.payment_outlined,
                                    type: TextInputType.number,
                                    controller: card,
                                    validator: (val) {
                                      if (val == null || val.trim().isEmpty) {
                                        return 'Card is required';
                                      } else if (val.length != 19) {
                                        return 'Invalid card number';
                                      }
                                      return null;
                                    },
                                    onSave: (val) {
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 15),
                                  AnimatedCrossFade(
                                    firstChild: BouncingAnimation(
                                      child: CustomButton(
                                        child: Text('Confirm Order',
                                            style:
                                                Consts.customButtonTextStyle),
                                        onTap: () {
                                          bool validate =
                                              formKey.currentState!.validate();
                                          if (validate) {
                                            successfulPayment(controller);
                                          }
                                        },
                                      ),
                                    ),
                                    secondChild: const Center(
                                        child: CircularProgressIndicator()),
                                    crossFadeState:
                                        controller.payAnimation.value
                                            ? CrossFadeState.showSecond
                                            : CrossFadeState.showFirst,
                                    duration: const Duration(milliseconds: 100),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
              child: Text(
                'Pay ${controller.totalPrice}',
                style: Consts.customButtonTextStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String showColor(int color) {
    String selectedC = 'Red';
    switch (color) {
      case 0:
        selectedC = 'Red';
        break;
      case 1:
        selectedC = 'Blue';
        break;
      case 2:
        selectedC = 'Black';
        break;
      case 3:
        selectedC = 'Grey';
        break;
      case 4:
        selectedC = 'White';
        break;
    }
    return selectedC;
  }

  successfulPayment(controller) {
    controller.payAnimation(true);
    Future.delayed(
      const Duration(seconds: 1),
    ).then((value) {
      controller.payAnimation(false);
      Get.dialog(
        Container(
          decoration: BoxDecoration(
            color: Get.theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(Consts.borderRadius),
          ),
          child: Lottie.asset(
            'assets/lotties/success.json',
            width: Get.width * 0.35,
            repeat: false,
            onLoaded: (_) {
              Future.delayed(
                const Duration(milliseconds: 2500),
              ).then(
                (value) {
                  Get.offAll(
                    () => const MainScreen(),
                    binding: MainBinding(),
                    transition: Transition.circularReveal,
                  );
                },
              );
            },
          ),
        ),
      );
    });
  }
}

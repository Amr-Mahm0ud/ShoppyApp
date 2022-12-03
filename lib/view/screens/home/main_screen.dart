import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/logic/controllers/cart_controller.dart';
import 'package:shoppy/utils/consts.dart';
import '../../widgets/switch_animation.dart';
import '../order/cart_screen.dart';
import '/logic/controllers/main_controller.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MainController controller = Get.find();
    CartController cartController = Get.find();
    BoxDecoration decoration = BoxDecoration(
      color: Get.theme.cardColor,
      borderRadius: BorderRadius.circular(Consts.borderRadius),
    );

    return Obx(
      () => Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: switchAnimation(
            first: Container(
              decoration: decoration,
              width: 100,
              height: 30,
            ),
            second: Text(
              key: Key('${controller.currentPage}'),
              controller.titles[controller.currentPage.value],
            ),
          ),
          actions: controller.currentPage.value == 3
              ? null
              : [
                  switchAnimation(
                    first: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CircleAvatar(
                        backgroundColor: Get.theme.cardColor,
                      ),
                    ),
                    second: GestureDetector(
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
                                    width: cartController.animateNum.value
                                        ? 0
                                        : 18,
                                    height: cartController.animateNum.value
                                        ? 0
                                        : 18,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Get.theme.backgroundColor,
                                        strokeAlign: StrokeAlign.outside,
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
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
        ),
        body: switchAnimation(
          first: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LinearProgressIndicator(),
                  SizedBox(
                    height: Get.height * 0.25,
                    child: Center(
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 8,
                        itemBuilder: (context, index) => Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Consts.borderRadius),
                          ),
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    decoration: decoration,
                    width: 150,
                    height: 30,
                  ),
                  const SizedBox(height: 10),
                  buildSection(true),
                  const SizedBox(height: 15),
                  Container(
                    decoration: decoration,
                    width: 150,
                    height: 30,
                  ),
                  const SizedBox(height: 10),
                  buildSection(false),
                ],
              ),
            ),
          ),
          second: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            child: controller.pages[controller.currentPage.value],
          ),
        ),
        bottomNavigationBar: switchAnimation(
          first: Container(
            color: Get.theme.cardColor,
            width: Get.width,
            height: Get.height * 0.075,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundColor: Get.theme.scaffoldBackgroundColor,
                ),
                CircleAvatar(
                  backgroundColor: Get.theme.scaffoldBackgroundColor,
                ),
                CircleAvatar(
                  backgroundColor: Get.theme.scaffoldBackgroundColor,
                ),
                CircleAvatar(
                  backgroundColor: Get.theme.scaffoldBackgroundColor,
                ),
              ],
            ),
          ),
          second: BottomNavigationBar(
            elevation: 0,
            iconSize: 25,
            selectedIconTheme: Get.theme.iconTheme
                .copyWith(color: Theme.of(context).primaryColor, size: 35),
            enableFeedback: true,
            backgroundColor: Get.theme.scaffoldBackgroundColor,
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.currentPage.value,
            onTap: (val) {
              controller.changePage(val);
            },
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(controller.currentPage.value == 0
                    ? Icons.home_rounded
                    : Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(controller.currentPage.value == 1
                    ? Icons.explore_rounded
                    : Icons.explore_outlined),
                label: 'Discover',
              ),
              BottomNavigationBarItem(
                icon: Icon(controller.currentPage.value == 2
                    ? Icons.favorite_rounded
                    : Icons.favorite_outline_rounded),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(controller.currentPage.value == 3
                    ? Icons.settings_rounded
                    : Icons.settings_outlined),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox buildSection(full) {
    return SizedBox(
      height: full ? Get.height * 0.27 : Get.height * 0.2,
      child: Container(
        height: Get.height * 0.27,
        width: Get.width * 0.9,
        decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: BorderRadius.circular(Consts.borderRadius),
        ),
      ),
    );
  }
}

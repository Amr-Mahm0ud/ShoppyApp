import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/logic/controllers/product_controller.dart';
import 'package:shoppy/utils/consts.dart';
import '../../../logic/controllers/categories_controller.dart';
import '../../widgets/switch_animation.dart';
import '/logic/controllers/main_controller.dart';

import 'cart_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MainController controller = Get.find();
    BoxDecoration decoration = BoxDecoration(
      color: Get.theme.cardColor,
      borderRadius: BorderRadius.circular(Consts.borderRadius),
    );
    ProductController pController = Get.find();
    CategoriesController cController = Get.find();

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
          actions: [
            switchAnimation(
              first: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CircleAvatar(
                  backgroundColor: Get.theme.cardColor,
                ),
              ),
              second: IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () {
                  Get.to(() => const CartScreen());
                },
              ),
            ),
          ],
        ),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: (pController.isLoading.value ||
                  cController.isCategoriesLoading.value)
              ? Padding(
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
                                  borderRadius: BorderRadius.circular(
                                      Consts.borderRadius),
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
                        buildSection([1, 2, 3], true),
                        const SizedBox(height: 15),
                        Container(
                          decoration: decoration,
                          width: 150,
                          height: 30,
                        ),
                        const SizedBox(height: 10),
                        buildSection([1, 2, 3], false),
                      ],
                    ),
                  ),
                )
              : PageView.builder(
                  reverse: false,
                  itemCount: controller.pages.length,
                  allowImplicitScrolling: true,
                  pageSnapping: true,
                  physics: const BouncingScrollPhysics(),
                  controller: controller.pageController,
                  onPageChanged: (val) {
                    controller.changePage(val);
                  },
                  itemBuilder: (context, index) => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: controller.pages[controller.currentPage.value],
                  ),
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
              controller.pageController.animateToPage(
                val,
                duration: const Duration(milliseconds: 200),
                curve: Curves.linear,
              );
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
                    ? Icons.person_rounded
                    : Icons.person_outline_rounded),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox buildSection(List items, full) {
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
}

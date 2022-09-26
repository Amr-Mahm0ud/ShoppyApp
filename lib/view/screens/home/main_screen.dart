import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/logic/controllers/main_controller.dart';

import 'cart_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MainController controller = Get.find();
    return Obx(
      () => Scaffold(
        extendBody: true,
        appBar: AppBar(
          // leading: Padding(
          //   padding: const EdgeInsets.all(10),
          //   child: GestureDetector(
          //     onTap: () {
          //       controller.pageController.animateToPage(
          //         4,
          //         duration: const Duration(milliseconds: 300),
          //         curve: Curves.linear,
          //       );
          //     },
          //     child: const CircleAvatar(
          //       child: Icon(Icons.person_rounded),
          //     ),
          //   ),
          // ),
          title: Text(
            key: Key('${controller.currentPage}'),
            controller.titles[controller.currentPage.value],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                Get.to(() => const CartScreen());
              },
            )
          ],
        ),
        body: PageView.builder(
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
            duration: const Duration(milliseconds: 300),
            child: controller.pages[controller.currentPage.value],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/bindings/auth_binding.dart';

import 'package:shoppy/utils/consts.dart';
import 'package:shoppy/utils/themes.dart';
import 'package:shoppy/view/widgets/custom_button.dart';

import '../../bindings/main_binding.dart';
import '../../logic/controllers/welcome_screen_controller.dart';
import 'auth/sign_up_screen.dart';
import 'home/main_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WelcomeScreenController controller = Get.find();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            //page view
            GetBuilder<WelcomeScreenController>(
              builder: (_) => PageView.builder(
                scrollDirection: Axis.horizontal,
                reverse: false,
                itemCount: controller.images.length,
                onPageChanged: (value) {
                  controller.animate();
                  controller.changePage(value);
                  Future.delayed(const Duration(milliseconds: 200)).then(
                    (value) => controller.animate(),
                  );
                },
                physics: const BouncingScrollPhysics(),
                controller: controller.pageController,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      SizedBox(height: Get.height * 0.1),
                      Image.asset(
                        controller.images[controller.currentPage],
                        height: Get.height * 0.4,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        controller.titles[controller.currentPage],
                        style: Get.textTheme.headline5,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        controller.texts[controller.currentPage],
                        style: Get.textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                },
              ),
            ),
            //indicator
            Align(
              alignment: const Alignment(0, 0.45),
              child: Container(
                width: 75,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: cardLight,
                ),
                child: GetBuilder<WelcomeScreenController>(
                  builder: (_) => AnimatedAlign(
                    alignment: controller.currentPage == 0
                        ? const Alignment(-1, 0)
                        : controller.currentPage == 1
                            ? const Alignment(0, 0)
                            : const Alignment(1, 0),
                    duration: const Duration(milliseconds: 300),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: controller.isAnimating ? 50 : 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Get.theme.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //Buttons
            Align(
              alignment: const Alignment(0, 0.675),
              child: GetBuilder<WelcomeScreenController>(
                builder: (_) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AnimatedCrossFade(
                      duration: const Duration(milliseconds: 300),
                      crossFadeState: controller.currentPage == 2
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      firstChild: CustomButton(
                        onTap: () {
                          Get.off(
                            () => SignUpScreen(),
                            transition: Transition.rightToLeftWithFade,
                            binding: AuthBinding(),
                          );
                        },
                        child: Text(
                          'Get Started',
                          style: Consts.customButtonTextStyle,
                        ),
                      ),
                      secondChild: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                            width: Get.width * 0.4,
                            filled: false,
                            onTap: () {
                              Get.off(
                                () => SignUpScreen(),
                                transition: Transition.rightToLeftWithFade,
                                binding: AuthBinding(),
                              );
                            },
                            child: Text(
                              'skip',
                              style: Get.textTheme.headline6!
                                  .copyWith(color: Get.theme.primaryColor),
                            ),
                          ),
                          CustomButton(
                            width: Get.width * 0.4,
                            onTap: () {
                              int newVal = controller.currentPage + 1;
                              controller.pageController.animateToPage(
                                newVal,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linear,
                              );
                            },
                            child: Text(
                              'Next',
                              style: Consts.customButtonTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.off(
                  () => const MainScreen(),
                  transition: Transition.size,
                  binding: MainBinding(),
                );
              },
              child: const Text('Home'),
            )
          ],
        ),
      ),
    );
  }
}

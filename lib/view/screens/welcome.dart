import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../logic/controllers/welcome_screen_controller.dart';
import 'auth/sign_up_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Get.off(
                () => const SignUpScreen(),
                transition: Transition.fadeIn,
              );
            },
            child: const Text(
              'skip',
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            GetBuilder<WelcomeScreenController>(
              builder: (controller) => PageView.builder(
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
                      SizedBox(height: Get.height * 0.05),
                      Image.asset(
                        controller.images[controller.currentPage],
                        scale: 4,
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
                          color: Get.textTheme.headline4!.color,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                },
              ),
            ),
            Align(
              alignment: const Alignment(0, 0.375),
              child: Container(
                width: 60,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Get.theme.cardColor,
                ),
                child: GetBuilder<WelcomeScreenController>(
                  builder: (controller) => AnimatedAlign(
                    alignment: controller.currentPage == 0
                        ? const Alignment(-1, 0)
                        : controller.currentPage == 1
                            ? const Alignment(0, 0)
                            : const Alignment(1, 0),
                    duration: const Duration(milliseconds: 300),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: controller.isAnimating ? 40 : 20,
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
            Align(
              alignment: const Alignment(0, 0.85),
              child: GetBuilder<WelcomeScreenController>(
                builder: (controller) {
                  return CircularPercentIndicator(
                    radius: Get.width * 0.12,
                    animation: true,
                    animateFromLastPercent: true,
                    animationDuration: 300,
                    center: FloatingActionButton(
                      onPressed: controller.currentPage < 2
                          ? () {
                              int newVal = controller.currentPage + 1;
                              controller.pageController.animateToPage(
                                newVal,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linear,
                              );
                            }
                          : () {
                              Get.off(
                                () => const SignUpScreen(),
                                transition: Transition.fadeIn,
                              );
                            },
                      elevation: 0,
                      backgroundColor: Get.theme.primaryColor,
                      splashColor: Get.theme.scaffoldBackgroundColor,
                      foregroundColor: Colors.white,
                      child: controller.currentPage < 2
                          ? const Icon(Icons.arrow_forward_rounded)
                          : const Icon(Icons.arrow_forward_ios_rounded),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    lineWidth: 5,
                    backgroundWidth: 2,
                    progressColor: Get.theme.primaryColor,
                    curve: Curves.easeIn,
                    percent:
                        (controller.currentPage + 1) / controller.images.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

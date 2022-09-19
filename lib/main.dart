import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/logic/controllers/welcome_screen_controller.dart';
import 'package:shoppy/utils/themes.dart';

import 'view/screens/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      debugShowCheckedModeBanner: false,
      onInit: () {
        Get.put(WelcomeScreenController());
      },
      home: const WelcomeScreen(),
    );
  }
}

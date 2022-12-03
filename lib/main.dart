import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shoppy/bindings/main_binding.dart';
import 'package:shoppy/bindings/welcome_binding.dart';
import 'package:shoppy/logic/controllers/auth_controller.dart';
import 'package:shoppy/view/screens/home/main_screen.dart';
import '/utils/themes.dart';

import 'logic/services/theme_services.dart';
import 'view/screens/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  await GetStorage.init();
  await Firebase.initializeApp();
  Get.put(AuthController());
  Get.put(ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    themeController.isDark(themeController.theme == ThemeMode.dark);
    return GetBuilder<AuthController>(
      builder: (controller) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Themes.lightTheme,
          darkTheme: Themes.darkTheme,
          themeMode: themeController.theme,
          initialRoute:
              controller.tryAutoLogin() ? '/homeScreen' : '/welcomeScreen',
          getPages: [
            GetPage(
              name: '/welcomeScreen',
              page: () => const WelcomeScreen(),
              binding: WelcomeBinding(),
            ),
            GetPage(
              name: '/homeScreen',
              page: () => const MainScreen(),
              binding: MainBinding(),
            ),
          ],
          defaultTransition: Transition.fadeIn,
        );
      },
    );
  }
}

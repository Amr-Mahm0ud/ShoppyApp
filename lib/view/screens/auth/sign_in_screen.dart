import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/bindings/main_binding.dart';
import 'package:shoppy/logic/controllers/auth_controller.dart';
import 'package:shoppy/utils/consts.dart';
import 'package:shoppy/view/screens/auth/forgot_password.dart';
import 'package:shoppy/view/screens/auth/sign_up_screen.dart';
import 'package:shoppy/view/screens/home/main_screen.dart';

import '../../widgets/auth/input_field.dart';
import '../../widgets/custom_button.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: Get.width * 0.3,
        leading: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            Get.off(
              () => SignUpScreen(),
              transition: Transition.leftToRightWithFade,
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Get.theme.primaryColor,
                  size: 17,
                ),
                Text(
                  'SignUp',
                  style: Get.textTheme.titleMedium!
                      .copyWith(color: Get.theme.primaryColor),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.05, vertical: Get.height * 0.05),
            child: Column(
              children: [
                //welcome text
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Welcome back!\nLet's Logged you in!",
                    style: Get.textTheme.headline5!.copyWith(
                      color: Get.theme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                //email
                inputField(
                  icon: Icons.email_rounded,
                  label: 'Email',
                  controller: emailController,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'email is required';
                    } else if (!val.trim().isEmail) {
                      return 'please enter a valid email';
                    }
                    return null;
                  },
                  onSave: (val) {
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                //password
                GetBuilder<AuthController>(
                  builder: (controller) => inputField(
                      icon: Icons.lock_clock_rounded,
                      label: 'password',
                      controller: passwordController,
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'password is required';
                        } else if (val.trim().length < 8) {
                          return "password can't be less than 8 letters";
                        }
                        return null;
                      },
                      onSave: (p0) {
                        return null;
                      },
                      obscure: controller.obscure,
                      widget: IconButton(
                        icon: Icon(
                          controller.obscure
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                        ),
                        onPressed: () {
                          controller.changeVisibility();
                        },
                      )),
                ),
                const SizedBox(height: 30),
                //button
                CustomButton(
                  child: Text('Sign In', style: Consts.customButtonTextStyle),
                  onTap: () {
                    bool valid = formKey.currentState!.validate();
                    if (valid) {
                      Get.off(
                        () => const MainScreen(),
                        transition: Transition.size,
                        binding: MainBinding(),
                      );
                    }
                  },
                ),
                const SizedBox(height: 10),
                //forget password
                TextButton(
                  onPressed: () {
                    Get.to(
                      () => ForgotPasswordScreen(),
                    );
                  },
                  child: const Text(
                    'Forgot your password?',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                //'or auth with' section
                Row(
                  children: [
                    Expanded(child: Container(height: 1, color: Colors.grey)),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'OR',
                        style: Get.textTheme.titleMedium!
                            .copyWith(color: Get.theme.primaryColor),
                      ),
                    ),
                    Expanded(child: Container(height: 1, color: Colors.grey)),
                  ],
                ),
                //buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      splashColor: Get.theme.cardColor,
                      child: SizedBox(
                        width: Get.width * 0.125,
                        height: Get.width * 0.125,
                        child: Image.asset(
                          'assets/images/google.png',
                        ),
                      ),
                      onTap: () {},
                    ),
                    SizedBox(width: Get.width * 0.05),
                    InkWell(
                      splashColor: Get.theme.cardColor,
                      child: SizedBox(
                        width: Get.width * 0.125,
                        height: Get.width * 0.125,
                        child: Image.asset(
                          'assets/images/facebook.png',
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

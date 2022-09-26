import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/logic/controllers/auth_controller.dart';
import 'package:shoppy/utils/consts.dart';
import '../../../bindings/main_binding.dart';
import '../home/main_screen.dart';
import 'sign_in_screen.dart';
import '../../widgets/auth/input_field.dart';
import '../../widgets/custom_button.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final String validationEmail =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  final String validationName = r'^[a-z A-Z]+$';

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              Get.off(
                () => SignInScreen(),
                transition: Transition.rightToLeftWithFade,
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    'SignIn',
                    style: Get.textTheme.titleMedium!
                        .copyWith(color: Get.theme.primaryColor),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Get.theme.primaryColor,
                    size: 17,
                  ),
                ],
              ),
            ),
          )
        ],
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
                    "Welcome!\nLet's Get you started!",
                    style: Get.textTheme.headline5!.copyWith(
                      color: Get.theme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                //username
                inputField(
                  icon: Icons.person_rounded,
                  label: 'User Name',
                  controller: usernameController,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'name is required';
                    } else if (!RegExp(validationName).hasMatch(val.trim())) {
                      return 'please enter a real name';
                    }
                    return null;
                  },
                  onSave: (val) {
                    return null;
                  },
                ),
                const SizedBox(height: 15),
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
                  builder: (_) => inputField(
                      icon: Icons.lock_rounded,
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
                const SizedBox(height: 15),
                //accept terms
                GetBuilder<AuthController>(
                  builder: (_) => Row(
                    children: [
                      Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        onChanged: (bool? value) {
                          controller.changeAcceptTerms();
                        },
                        value: controller.acceptTerms,
                        checkColor: Colors.white,
                        activeColor: Get.theme.primaryColor,
                      ),
                      const Text('You agree the terms and privacy policy')
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                //button
                GetBuilder<AuthController>(builder: (_) {
                  return CustomButton(
                    child: Text('Sign Up', style: Consts.customButtonTextStyle),
                    onTap: () {
                      bool valid = formKey.currentState!.validate();
                      if (valid && controller.acceptTerms) {
                        Get.off(
                          () => const MainScreen(),
                          transition: Transition.size,
                          binding: MainBinding(),
                        );
                      } else if (!controller.acceptTerms) {
                        Consts.errorSnackBar('you have to accept our terms');
                      }
                    },
                  );
                }),
                ElevatedButton(
                  onPressed: () {
                    Get.off(
                      () => const MainScreen(),
                      transition: Transition.size,
                      binding: MainBinding(),
                    );
                  },
                  child: const Text('Next'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

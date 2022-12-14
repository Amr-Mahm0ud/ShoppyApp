import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shoppy/logic/controllers/auth_controller.dart';
import 'package:shoppy/utils/consts.dart';
import 'package:shoppy/view/widgets/auth/input_field.dart';
import 'package:shoppy/view/widgets/custom_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormFieldState> inputKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
          child: Column(
            children: [
              Lottie.asset(
                'assets/lotties/forgot_password.json',
                repeat: false,
                height: Get.height * 0.4,
              ),
              Text(
                'Please enter your email below to recover your account',
                style: Get.textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Get.height * 0.05),
              inputField(
                key: inputKey,
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
              SizedBox(height: Get.height * 0.025),
              GetBuilder<AuthController>(
                builder: (_) => CustomButton(
                  onTap: controller.isLoading
                      ? null
                      : () {
                          bool valid = inputKey.currentState!.validate();
                          if (valid) {
                            controller.sendPasswordResetEmail(
                              emailController.text.trim(),
                            );
                          }
                        },
                  child: AnimatedCrossFade(
                    firstChild: Text(
                      'Send Email',
                      style: Consts.customButtonTextStyle,
                    ),
                    crossFadeState: controller.isLoading
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 100),
                    secondChild: const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

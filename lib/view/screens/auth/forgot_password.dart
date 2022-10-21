import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shoppy/utils/consts.dart';
import 'package:shoppy/view/widgets/auth/input_field.dart';
import 'package:shoppy/view/widgets/custom_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormFieldState> inputKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
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
              CustomButton(
                child: Text(
                  'Send Email',
                  style: Consts.customButtonTextStyle,
                ),
                onTap: () {
                  bool valid = inputKey.currentState!.validate();
                  if (valid) {
                    Get.back();
                    Consts.successSnackBar(
                      title: 'Email sent',
                      body: Lottie.asset(
                        'assets/lotties/email_sent.json',
                        height: Get.height * 0.15,
                        repeat: false,
                      ),
                      duration: const Duration(milliseconds: 1500),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

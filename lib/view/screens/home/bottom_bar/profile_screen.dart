import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/logic/controllers/auth_controller.dart';
import 'package:shoppy/utils/consts.dart';
import 'package:shoppy/view/widgets/bouncing_animation.dart';
import 'package:shoppy/view/widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    return Column(
      children: [
        const Text('ProfileScreen'),
        BouncingAnimation(
          child: CustomButton(
            onTap: () {
              controller.logout();
            },
            filled: false,
            child: Text(
              'Logout',
              style: Consts.customButtonTextStyle.copyWith(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}

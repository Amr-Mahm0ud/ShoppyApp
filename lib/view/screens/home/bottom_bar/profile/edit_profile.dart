import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shoppy/bindings/main_binding.dart';
import 'package:shoppy/utils/consts.dart';
import 'package:shoppy/view/screens/home/main_screen.dart';
import 'package:shoppy/view/widgets/auth/input_field.dart';
import 'package:shoppy/view/widgets/bouncing_animation.dart';
import 'package:shoppy/view/widgets/custom_button.dart';

import '../../../../../logic/controllers/auth_controller.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});

  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name',
                  style: Get.textTheme.headline6,
                ),
                const SizedBox(height: 10),
                inputField(
                  controller: name,
                  type: TextInputType.name,
                  label: 'Enter your name',
                  icon: Icons.person,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'You should enter a name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'Phone',
                  style: Get.textTheme.headline6,
                ),
                const SizedBox(height: 10),
                inputField(
                  controller: phone,
                  type: TextInputType.phone,
                  label: 'Enter your phone number',
                  icon: Icons.phone,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'You should enter your phone num';
                    } else if (val.length != 11) {
                      return 'phone number is not valid';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'Profile Picture',
                  style: Consts.customButtonTextStyle.copyWith(
                    color: Get.textTheme.bodyText1!.color,
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: Consts.profilePictures
                        .map(
                          (image) => GestureDetector(
                            onTap: () {
                              controller.selectedImage(
                                Consts.profilePictures.indexOf(image),
                              );
                            },
                            child: CircleAvatar(
                              backgroundColor: controller.selectedImage.value ==
                                      Consts.profilePictures.indexOf(image)
                                  ? Get.theme.primaryColor
                                  : Get.theme.cardColor,
                              backgroundImage: AssetImage(image),
                              radius: Get.width * 0.1,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 20),
                BouncingAnimation(
                  child: CustomButton(
                    child: Text(
                      'Update',
                      style: Consts.customButtonTextStyle,
                    ),
                    onTap: () {
                      var isValid = formKey.currentState!.validate();
                      if (isValid) {
                        controller.updateInfo(
                          image: Consts
                              .profilePictures[controller.selectedImage.value],
                          name: name.text,
                          phone: phone.text,
                        );
                        Consts.successSnackBar(
                          title: 'Done',
                          body: Lottie.asset(
                            'assets/lotties/success.json',
                            repeat: false,
                            onLoaded: (_) {
                              Future.delayed(
                                const Duration(milliseconds: 3000),
                              ).then(
                                (value) => Get.offAll(
                                  () => const MainScreen(),
                                  binding: MainBinding(),
                                  transition: Transition.circularReveal,
                                ),
                              );
                            },
                          ),
                          duration: const Duration(milliseconds: 2500),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

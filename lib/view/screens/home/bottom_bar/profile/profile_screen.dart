import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/logic/controllers/auth_controller.dart';
import 'package:shoppy/logic/services/theme_services.dart';
import 'package:shoppy/utils/consts.dart';
import 'package:shoppy/view/screens/home/bottom_bar/profile/edit_profile.dart';
import 'package:shoppy/view/widgets/bouncing_animation.dart';
import 'package:shoppy/view/widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    final themeController = Get.find<ThemeController>();
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Personal Information
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: Get.width * 0.13,
                backgroundColor: Get.theme.cardColor,
                backgroundImage: AssetImage(
                  Consts.profilePictures[controller.selectedImage.value],
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    controller.userEmail.toString(),
                    style: Get.textTheme.headline6!.copyWith(
                        color: themeController.isDark.value
                            ? Colors.white
                            : Colors.black),
                  ),
                  Text(controller.userName ?? 'User Name'),
                  Text(controller.phoneNum ?? ''),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(thickness: 2),
          const SizedBox(height: 5),
          Text(
            'General',
            style: Get.textTheme.headline6!.copyWith(
              color: Get.theme.primaryColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          //Edit Profile
          ListTile(
            title: Text(
              'Edit Your Information',
              style: Consts.customButtonTextStyle.copyWith(
                  color: themeController.isDark.value
                      ? Colors.white
                      : Colors.black),
            ),
            onTap: () {
              Get.to(
                () => EditProfile(),
                transition: Transition.cupertino,
              );
            },
            leading: const Icon(Icons.edit_outlined),
          ),
          //Dark Mode
          ListTile(
            title: Text(
              'Dark Mode',
              style: Consts.customButtonTextStyle.copyWith(
                  color: themeController.isDark.value
                      ? Colors.white
                      : Colors.black),
            ),
            onTap: () {
              themeController.switchTheme();
            },
            leading: Icon(themeController.isDark.value
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined),
            trailing: Switch.adaptive(
              value: themeController.isDark.value,
              onChanged: (val) {
                themeController.switchTheme();
              },
            ),
          ),
          //language (UI Only)
          ListTile(
            title: Text(
              'Language',
              style: Consts.customButtonTextStyle.copyWith(
                  color: themeController.isDark.value
                      ? Colors.white
                      : Colors.black),
            ),
            onTap: () {},
            leading: const Icon(Icons.language_outlined),
          ),
          //Help (UI Only)
          ListTile(
            title: Text(
              'Help',
              style: Consts.customButtonTextStyle.copyWith(
                  color: themeController.isDark.value
                      ? Colors.white
                      : Colors.black),
            ),
            onTap: () {},
            leading: const Icon(Icons.help_outline),
          ),
          const Divider(thickness: 2),
          //Logout
          const SizedBox(height: 10),
          BouncingAnimation(
            child: CustomButton(
              onTap: () {
                controller.logout();
              },
              filled: false,
              child: Text(
                'Logout',
                style: Consts.customButtonTextStyle.copyWith(
                    color: themeController.isDark.value
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

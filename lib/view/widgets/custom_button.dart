import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/utils/consts.dart';
import 'bouncing_animation.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final double? width;
  final void Function()? onTap;
  final Color? color;
  final bool filled;
  final double? height;

  const CustomButton({
    super.key,
    required this.child,
    this.width,
    this.onTap,
    this.color,
    this.filled = true,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return BouncingAnimation(
      child: InkWell(
        borderRadius: BorderRadius.circular(Consts.borderRadius),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: height ?? Get.height * 0.07,
          alignment: Alignment.center,
          width: width ?? Get.width,
          decoration: BoxDecoration(
            color:
                filled ? color ?? Get.theme.primaryColor : Colors.transparent,
            border: filled
                ? null
                : Border.all(
                    color: color ?? Get.theme.primaryColor,
                    width: 1,
                  ),
            borderRadius: BorderRadius.circular(Consts.borderRadius),
          ),
          child: child,
        ),
      ),
    );
  }
}

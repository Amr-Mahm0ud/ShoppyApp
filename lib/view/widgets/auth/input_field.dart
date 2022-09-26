import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/utils/consts.dart';

Widget inputField({
  TextEditingController? controller,
  String? Function(String?)? validator,
  String? Function(String?)? onSave,
  String? Function(String?)? onChange,
  Key? key,
  bool autoCorrect = true,
  bool obscure = false,
  required String label,
  required IconData icon,
  Widget? widget,
}) {
  return TextFormField(
    key: key,
    validator: validator,
    onSaved: onSave,
    controller: controller,
    autocorrect: autoCorrect,
    cursorColor: Get.theme.primaryColor,
    obscureText: obscure,
    onChanged: onChange,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Consts.borderRadius),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Consts.borderRadius),
        borderSide: BorderSide(color: Get.theme.cardColor, width: 1),
      ),
      label: Text(label),
      prefixIcon: Icon(icon),
      suffixIcon: widget,
    ),
  );
}

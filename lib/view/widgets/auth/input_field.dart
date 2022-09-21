import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      label: Text(label),
      prefixIcon: Icon(icon),
      suffixIcon: widget,
    ),
  );
}

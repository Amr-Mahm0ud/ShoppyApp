import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  TextInputType? type,
}) {
  return TextFormField(
    keyboardType: type ??
        ((label == 'Email')
            ? TextInputType.emailAddress
            : TextInputType.visiblePassword),
    key: key,
    inputFormatters: (label == 'Card Number')
        ? [
            FilteringTextInputFormatter.digitsOnly,
            CardNumberFormatter(),
          ]
        : null,
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

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var inputText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}

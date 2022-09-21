import 'package:get/get.dart';

class AuthController extends GetxController {
  bool obscure = true;
  bool acceptTerms = false;

  changeVisibility() {
    obscure = !obscure;
    update();
  }

  changeAcceptTerms() {
    acceptTerms = !acceptTerms;
    update();
  }
}

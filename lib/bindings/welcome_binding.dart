import 'package:get/get.dart';
import 'package:shoppy/logic/controllers/welcome_screen_controller.dart';


class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(WelcomeScreenController());
  }
}

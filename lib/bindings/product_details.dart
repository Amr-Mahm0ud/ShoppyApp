import 'package:get/get.dart';
import 'package:shoppy/logic/controllers/product_details_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductDetailsController());
  }
}

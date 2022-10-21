import 'package:get/get.dart';
import 'package:shoppy/logic/controllers/product_details.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductDetailsController());
  }
}

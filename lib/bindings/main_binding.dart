import 'package:get/instance_manager.dart';
import 'package:shoppy/logic/controllers/cart_controller.dart';
import 'package:shoppy/logic/controllers/categories_controller.dart';
import 'package:shoppy/logic/controllers/main_controller.dart';
import 'package:shoppy/logic/controllers/product_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainController());
    Get.put(ProductController());
    Get.lazyPut(() => CategoriesController());
    Get.lazyPut(() => CartController());
  }
}

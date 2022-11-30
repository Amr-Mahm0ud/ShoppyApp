import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  RxInt selectedColor = 0.obs;
  RxInt selectedClothSize = 0.obs;
  RxInt selectedShoesSize = 0.obs;

  RxInt index = 0.obs;
  RxBool isAnimating = false.obs;

  animate() {
    isAnimating.value = !isAnimating.value;
  }
}

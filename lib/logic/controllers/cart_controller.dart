import 'package:get/state_manager.dart';
import 'package:shoppy/model/cart_item_model.dart';
import 'package:shoppy/model/product_model.dart';
import 'package:shoppy/utils/consts.dart';

class CartController extends GetxController {
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  RxBool animateNum = false.obs;
  RxDouble shakeAnimation = 0.0.obs;

  RxInt totalPrice = 0.obs;

  int calcTotalPrice() {
    totalPrice(0);
    for (var element in cartItems) {
      totalPrice.value += element.totalPrice;
    }
    return totalPrice.value;
  }

  animateShaking() {
    shakeAnimation(0.1);
    Future.delayed(const Duration(milliseconds: 50)).then(
      (value) => shakeAnimation(-0.1),
    );
    Future.delayed(const Duration(milliseconds: 100)).then(
      (value) => shakeAnimation(0.0),
    );
  }

  addToCart(ProductModel item) {
    if (cartItems.any(
      (element) => element.item.id == item.id,
    )) {
      if (cartItems
              .firstWhere(
                (element) => element.item.id == item.id,
              )
              .quantity <
          item.stock) {
        int quantity = cartItems
            .firstWhere((element) => element.item.id == item.id)
            .quantity;
        final newVal = CartItemModel(item: item, quantity: quantity + 1);
        cartItems[cartItems.indexWhere(
          (element) => element.item.id == item.id,
        )] = newVal;
      } else {
        Consts.errorSnackBar('Out of Stock');
      }
    } else {
      animateNum(true);
      cartItems.add(
        CartItemModel(
          item: item,
          quantity: 1,
        ),
      );
      Future.delayed(const Duration(milliseconds: 100)).then(
        (value) => animateNum(false),
      );
    }
    calcTotalPrice();
  }

  decreaseFromCart(ProductModel item) {
    if (cartItems.any(
          (element) => element.item.id == item.id,
        ) &&
        cartItems
                .firstWhere(
                  (element) => element.item.id == item.id,
                )
                .quantity >
            1) {
      int quantity = cartItems
          .firstWhere((element) => element.item.id == item.id)
          .quantity;
      final newVal = CartItemModel(item: item, quantity: quantity - 1);
      cartItems[cartItems.indexWhere(
        (element) => element.item.id == item.id,
      )] = newVal;
      update();
    } else {
      cartItems.removeWhere(
        (element) => element.item.id == item.id,
      );
    }
    calcTotalPrice();
  }

  removeFromCart(ProductModel item) {
    cartItems.removeAt(
        cartItems.indexWhere((element) => element.item.id == item.id));
    calcTotalPrice();
  }
}

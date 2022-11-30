import 'package:shoppy/model/product_model.dart';

class CartItemModel {
  ProductModel item;
  int quantity;
  int color;
  int clothSize;
  int shoesSize;
  late int totalPrice = (item.price * quantity).ceil();

  CartItemModel({
    required this.item,
    required this.quantity,
    this.color = 0,
    this.clothSize = 0,
    this.shoesSize = 0,
  });
}

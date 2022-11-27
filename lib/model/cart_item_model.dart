import 'package:shoppy/model/product_model.dart';

class CartItemModel {
  ProductModel item;
  int quantity;
  late int totalPrice = (item.price * quantity).ceil();

  CartItemModel({
    required this.item,
    required this.quantity,
  });
}

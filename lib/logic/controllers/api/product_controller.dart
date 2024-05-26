import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shoppy/model/product_model.dart';

import '../../services/products_services.dart';

class ProductController extends GetxController {
  @override
  void onInit() {
    getProducts();
    // List? existingFav = box.read<List>('favorites');
    // if (existingFav != null) {
    //   favorites = existingFav
    //       .map((element) =>
    //       ProductModel.fromJson(element)
    //       )
    //       .toList()
    //       .obs;
    // }
    super.onInit();
  }

  RxList<ProductModel> allProducts = <ProductModel>[].obs;
  RxList<ProductModel> favorites = <ProductModel>[].obs;
  RxBool isLoading = true.obs;
  Rx<ProductModel>? currentProduct;

  GetStorage box = GetStorage();

  RxInt random = (0).obs;

  void getProducts() async {
    try {
      isLoading(true);
      List<ProductModel> products = await ProductServices.getAllProducts();
      if (products.isNotEmpty) {
        allProducts.addAll(products);
      }
    } finally {
      random.value = Random().nextInt(allProducts.length - 7);
      isLoading(false);
    }
  }

  Future<void> addToFavorite(int productId) async {
    favorites.add(allProducts.firstWhere((product) => product.id == productId));
    await box.write('favorites', favorites);
  }

  Future<void> removeFromFavorite(int productId) async {
    favorites
        .remove(favorites.firstWhere((product) => product.id == productId));
    await box.write('favorites', favorites);
  }

  bool isFavorite(productId) {
    return favorites.any((product) => product.id == productId);
  }

  //search logic
  TextEditingController searchController = TextEditingController();
  RxList<ProductModel> searchResult = <ProductModel>[].obs;

  findProductByName() {
    if (searchController.text.isEmpty) {
      searchResult.value = allProducts.map((e) => e).toList();
    } else {
      searchResult.value = allProducts
          .where((element) =>
              element.title.toLowerCase().contains(searchController.text))
          .map((e) => e)
          .toList();
    }
    update();
  }

  clearSearch() {
    searchController.clear();
    findProductByName();
    update();
  }
}

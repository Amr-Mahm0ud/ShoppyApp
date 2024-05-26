import 'package:get/state_manager.dart';
import 'package:shoppy/model/product_model.dart';

import '../../services/categories_services.dart';

class CategoriesController extends GetxController {
  @override
  void onInit() {
    getCategories();
    super.onInit();
  }

  RxList allCategories = <String>[].obs;
  RxBool isCategoriesLoading = true.obs;
  RxList allProductsInCategory = <ProductModel>[].obs;
  RxBool isProductsLoading = true.obs;
  RxString currentCategoryName = ''.obs;

  List<String> categoriesImages = [
    "assets/categories/smartphones.png",
    "assets/categories/laptops.png",
    "assets/categories/fragrances.png",
    "assets/categories/skincare.png",
    "assets/categories/groceries.png",
    "assets/categories/home-decoration.png",
    "assets/categories/furniture.png",
    "assets/categories/tops.png",
    "assets/categories/womens-dresses.png",
    "assets/categories/womens-shoes.png",
    "assets/categories/mens-shirts.png",
    "assets/categories/mens-shoes.png",
    "assets/categories/mens-watches.png",
    "assets/categories/womens-watches.png",
    "assets/categories/womens-bags.png",
    "assets/categories/womens-jewellery.png",
    "assets/categories/sunglasses.png",
    "assets/categories/automotive.png",
    "assets/categories/motorcycle.png",
    "assets/categories/lighting.png",
  ];

  void getCategories() async {
    try {
      isCategoriesLoading(true);
      List<String> categories = await CategoriesServices.getAllCategories();
      if (categories.isNotEmpty) {
        allCategories.addAll(categories);
      }
    } finally {
      isCategoriesLoading(false);
    }
  }

  void getProductsInCategory(categoryName) async {
    try {
      currentCategoryName(categoryName);
      isProductsLoading(true);
      List<ProductModel> products =
          await CategoriesServices.productsInCategory(categoryName);
      if (products.isNotEmpty) {
        allProductsInCategory(products);
      }
    } finally {
      isProductsLoading(false);
    }
  }
}

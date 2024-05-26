import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shoppy/utils/consts.dart';

import '../../model/product_model.dart';

class CategoriesServices {
  static Future<List<String>> getAllCategories() async {
    try {
      var response =
          await http.get(Uri.parse('${Consts.baseURL}/products/categories'));
      if (response.statusCode == 200) {
        var resBody = response.body;
        return categoryModelFromJson(resBody);
      } else {
        return throw Exception('Failed to load Products');
      }
    } catch (error) {
      return throw Exception(error);
    }
  }

  static Future<List<ProductModel>> productsInCategory(
      String categoryName) async {
    try {
      var response = await http
          .get(Uri.parse('${Consts.baseURL}/products/category/$categoryName'));
      if (response.statusCode == 200) {
        var resBody = response.body;
        return productModelFromJson(resBody);
      } else {
        return throw Exception('Failed to load Products');
      }
    } catch (error) {
      return throw Exception(error);
    }
  }
}

List<String> categoryModelFromJson(String str) =>
    List<String>.from(json.decode(str).map((x) => x['name'].toString()));

String categoryModelToJson(List<String> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x)));

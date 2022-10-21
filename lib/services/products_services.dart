import 'package:http/http.dart' as http;
import 'package:shoppy/model/product_model.dart';
import 'package:shoppy/utils/consts.dart';

class ProductServices {
  static Future<List<ProductModel>> getAllProducts() async {
    try {
      var response = await http.get(Uri.parse('${Consts.baseURL}/products'));
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

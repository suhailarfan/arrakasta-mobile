import 'dart:convert';

import 'package:get/get.dart';
import 'package:my_flutter_project/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController {
  var isLoading = false.obs;
  var products = <Data>[].obs;
  ProductModel? productModel;
  ProductData? productData;

  var host = 'http://203.175.11.204/';

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchData();
  }

  fetchData() async {
    try {
      isLoading(true);
      http.Response response = await http.get(
        Uri.tryParse('http://203.175.11.204/api/v1/products/all')!,
      );
      if (response.statusCode == 200) {
        // data successfully fetched
        var result = jsonDecode(response.body);
        productModel = ProductModel.fromJson(result);
        productData = productModel?.data;
      } else {
        // handle other status codes if needed
      }
    } catch (e){
      print('Error fetching data: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> searchProducts(String query) async {
    try {
      isLoading(true);
      http.Response response = await http.get(
        Uri.tryParse('${host}api/v1/products/search?name=$query')!,
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var productModel = ProductModel.fromJson(result);
        if (productModel.data != null) {
          products.value = productModel.data!.data ?? []; // Assuming products is a list inside data
        }
      } else {
        print('Failed to search products: ${response.body}');
      }
    } catch (e) {
      print('Error searching products: $e');
    } finally {
      isLoading(false);
    }
  }
}

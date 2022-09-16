import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get_connect/connect.dart' hide Response;
import 'package:migo/models/cache.dart';
import 'package:migo/models/product/api.dart';
import 'package:migo/models/product/product.dart';

class ProductServices extends GetConnect with CacheManager {
  final String searchUrl =
      'https://backpos.herokuapp.com/api/v1/product/search/';
  final String allProduct = 'https://backpos.herokuapp.com/api/v1/product/';
  Future<List<Product>?> fetchProducts(Keyword model) async {
    var dio = Dio();
    final token = getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    Response response =
        await dio.post(searchUrl, data: json.encode(model.toJson()));
    if (response.statusCode == 200) {
      return ApiHandler.fromJson(response.data).allProducts;
    } else {
      //show error message
      return null;
    }
  }

  Future<List<Product>?> fetchAllProducts() async {
    var dio = Dio();
    final token = getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    Response response = await dio.get(allProduct);
    if (response.statusCode == 200) {
      ApiHandler handler = ApiHandler.fromJson(response.data);
      List<Product>? product = handler.getProducts();
      return product;
    } else {
      //show error message
      return null;
    }
  }
}

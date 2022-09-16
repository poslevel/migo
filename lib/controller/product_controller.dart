import 'package:get/get.dart';
import 'package:migo/models/product/product.dart';
import 'package:migo/service/product_service.dart';

class ProductController extends GetxController {
  late final ProductServices _productService;
  RxInt quantity = 0.obs;
  var isLoading = true.obs;
  var productList = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    _productService = Get.put(ProductServices());
  }

  void fetchProducts(String category, String query) async {
    try {
      isLoading(true);
      var products = await _productService
          .fetchProducts(Keyword(category: category, query: query));
      if (products != null) {
        productList.value = products;
      }
    } finally {
      isLoading(false);
    }
  }

  void fetchAllProducts() async {
    try {
      isLoading(true);
      print("done fetching all products");
      var products = await _productService.fetchAllProducts();
      print(products.toString());
      print("done fetching all products 1");
      if (products != null) {
        print("done fetching all products 2");
        productList.value = products;
      }
    } finally {
      isLoading(false);
    }
  }

  addProduct() {
    quantity.value = quantity.value++;
  }

  removeProduct() {
    quantity.value = quantity.value--;
  }
}

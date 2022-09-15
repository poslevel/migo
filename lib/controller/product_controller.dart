import 'package:get/get.dart';

class ProductController extends GetxController {
  RxInt quantity = 0.obs;
  addProduct() {
    quantity.value = quantity.value++;
  }

  removeProduct() {
    quantity.value = quantity.value--;
  }
}

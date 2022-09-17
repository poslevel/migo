import 'package:get/get.dart';
import 'package:migo/models/invoice.dart';
import 'package:migo/models/product/product.dart';
import 'package:migo/utils/functions.dart';
// import 'package:migo/service/product_service.dart';

class InvoiceController extends GetxController {
  // late final ProductServices _productService;
  int id = 0;
  var isLoading = true.obs;
  String? customerName;
  String? customerPhone;
  String? customerEmail;
  String? customerAddress;
  var totalAmt = 0.obs;
  var productList = <Product>[].obs;

  void setCustomer(
      String name, String phone, String email, String? address) async {
    customerName = name;
    customerPhone = phone;
    customerEmail = email;
    customerAddress = address;
    await Future.delayed(const Duration(milliseconds: 20), () {
      update();
    });
  }

  void addToTotal(int val) async {
    totalAmt.value += val;
    await Future.delayed(const Duration(milliseconds: 20), () {
      update();
    });
  }

  void removeFromTotal(int val) async {
    totalAmt.value -= val;
    await Future.delayed(const Duration(milliseconds: 20), () {
      update();
    });
  }

  void clearInvoice() async {
    totalAmt.value = 0;
    productList.clear();
    await Future.delayed(const Duration(milliseconds: 20), () {
      update();
    });
  }

  void setItems(List<Product> val) async {
    productList.addAll(val);
    await Future.delayed(const Duration(milliseconds: 20), () {
      update();
    });
  }

  Invoice generatePreviewInvoice() => Invoice(
        id: id,
        date: Functions.formatDate(DateTime.now()),
        customerName: customerName,
        customerEmail: customerEmail,
        customerAddress: customerAddress,
        customerPhone: customerPhone,
        store: "Hayat Store",
        posOperator: "Hayat Tamboli",
        products: productList,
        totalAmount: totalAmt.toString(),
      );
}

import 'package:get/get.dart';
import 'package:migo/models/invoice/invoice.dart';

import 'package:migo/models/product/product.dart';
import 'package:migo/service/invoice_service.dart';
// import 'package:migo/service/product_service.dart';

class InvoiceController extends GetxController {
  // late final ProductServices _productService;
  late final InvoiceService _invoiceService;
  int id = 0;
  var isLoading = true.obs;
  String? customerName;
  String? customerPhone;
  String? customerEmail;
  String? customerAddress;
  var totalAmt = 0.obs;
  var productList = <Product>[].obs;
  var salesList = <Invoice>[].obs;

  @override
  void onInit() {
    super.onInit();
    _invoiceService = Get.put(InvoiceService());
  }

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

  void fetchAllInvoice() async {
    try {
      isLoading(true);
      var invoices = await _invoiceService.getAllInvoice();
      if (invoices != null) {
        salesList.value = invoices;
      }
    } finally {
      isLoading(false);
    }
  }

  void setTotal(int val) async {
    totalAmt.value = val;
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
}

// ignore_for_file: equal_elements_in_set

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
  // for sales history purpose
  var selectedInvoice = (-1).obs;

  @override
  void onInit() {
    super.onInit();
    _invoiceService = Get.put(InvoiceService());
  }

  // for sales history purpose
  void setSelectedInvoice(int val) async {
    selectedInvoice.value = val;
    await Future.delayed(const Duration(milliseconds: 20), () {
      update();
    });
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

  Future<String?> createInvoice() async {
    try {
      isLoading(true);
      List<Map<String, dynamic>> item = [];
      for (int i = 0; i < productList.length; i++) {
        Map<String, dynamic> it = {
          'title': productList[i].name,
          'quantity': productList[i].qty,
          'unit_price': productList[i].sellingPrice,
          'net_amount': (int.parse(productList[i]
                      .sellingPrice!
                      .substring(0, productList[i].sellingPrice!.length - 3)) *
                  productList[i].qty!)
              .toString(),
        };

        item.add(it);
      }

      Map<String, dynamic> sample = {
        'client_name': customerName,
        'client_email': customerEmail,
        'client_number': customerName,
        'client_address1': customerAddress,
        'client_address2': "",
        'client_zipcode': "",
        'client_place': "",
        'client_country': "",
        'invoice_type': "invoice",
        'net_amount': totalAmt.toInt(),
        'items': item,
      };

      var details =
          await _invoiceService.addInvoice(InvoiceCreation.fromJson(sample));
      if (details != null) {
        return details.invoiceNumber.toString();
      }
    } finally {
      isLoading(false);
      fetchAllInvoice();
    }
    return null;
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

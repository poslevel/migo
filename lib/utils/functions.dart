// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'dart:io';
import 'dart:typed_data';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';
import 'package:migo/controller/product_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class Functions {
  static final ProductController productController =
      Get.put(ProductController());
  static String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(date);
    return formatted;
  }

  static Future<ConnectivityResult> checkConnectivity() async {
    var connectivityStatus = await Connectivity().checkConnectivity();
    return connectivityStatus;
  }

  static void searchProducts(String query) {
    final result = productController.productList.where((pro) {
      final productName = pro.name!.toLowerCase();
      final input = query.toLowerCase();
      return productName.contains(input);
    }).toList();
    productController.searchList.value = result;
  }

  static void filterProducts(String? query) {
    final result = productController.productList.where((pro) {
      final productCategory = pro.category!.toLowerCase();
      final input = query!.toLowerCase();
      return productCategory.contains(input);
    }).toList();
    productController.searchList.value = result;
  }

  static void saveInvoice(
      {required String name,
      required Uint8List fileBytes,
      String path = "/storage/emulated/0/Documents"}) async {
    try {
      bool checkPermission = await Permission.storage.request().isGranted;
      if (checkPermission) {
        File pdf_doc = File("$path/$name");
        await pdf_doc.writeAsBytes(fileBytes);
        Get.snackbar("done", "Invoice Saved succesfully to $path/$name",
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar("Error", "Storage permission denied !, please try again!",
            snackPosition: SnackPosition.BOTTOM);
        Future.delayed(
          const Duration(seconds: 2),
        );
        await Permission.storage.request();
      }
    } on FileSystemException catch (e) {
      Get.snackbar("ERROR", "${e.message} $path/$name",
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("ERROR", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  static Future<void> launchURL(String url) async {
    final Uri purl = Uri.parse(url);
    if (!await launchUrl(purl, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $purl';
    }
  }
}

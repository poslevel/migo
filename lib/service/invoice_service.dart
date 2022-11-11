import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_connect/connect.dart' hide Response;
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:dio/dio.dart';
import 'package:migo/models/cache.dart';
import 'package:migo/models/invoice/invoice.dart';

/// LoginService responsible to communicate with web-server
/// via authenticaton related APIs
class InvoiceService extends GetConnect with CacheManager {
  final String invoiceCreation =
      'https://backpos.herokuapp.com/api/v1/invoice/';
  Future<Invoice?> addInvoice(InvoiceCreation model) async {
    var dio = Dio();
    final token = getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    Response response =
        await dio.post(invoiceCreation, data: json.encode(model.toJson()));
    if (response.statusCode == HttpStatus.created) {
      debugPrint(response.data.toString());
      return Invoice.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<List<Invoice>?> getAllInvoice() async {
    var dio = Dio();
    final token = getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    Response response = await dio.get(invoiceCreation);
    if (response.statusCode == HttpStatus.ok) {
      InvoiceApiHandler handler = InvoiceApiHandler.fromJson(response.data);
      List<Invoice>? invoices = handler.getInvoice();
      return invoices;
    } else {
      return null;
    }
  }
}

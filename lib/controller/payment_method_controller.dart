import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethodController extends GetxController {
  RxString mode = "cash".obs;

  changed(String val) {
    debugPrint("🎈🎈🎈$val");
    mode.value = val;
  }
}

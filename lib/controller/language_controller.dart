import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  final languagePref = GetStorage();
  var lan = "English".obs;
  void setLangaugeEnglish() {
    var locale = const Locale('en', 'US');
    Get.updateLocale(locale);
    lan.value = "English";
    languagePref.write("lan", lan.value);
  }

  void setLangaugeHindi() {
    var locale = const Locale('hi', 'IN');
    Get.updateLocale(locale);
    lan.value = "Hindi";
    languagePref.write("lan", lan.value);
  }
}

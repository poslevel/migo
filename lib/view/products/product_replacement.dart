import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:migo/view/layout/layout.dart';

class ProductReplacement extends StatelessWidget {
  const ProductReplacement({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeTab: 1,
      content: Container(),
      pageName: "product_replacement".tr,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:migo/layout/layout.dart';

class ProductReplacement extends StatelessWidget {
  const ProductReplacement({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeTab: 1,
      content: Container(),
      pageName: "Product Replacement",
    );
  }
}

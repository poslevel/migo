import 'package:flutter/material.dart';
import 'package:migo/view/layout/layout.dart';

class OrderProduct extends StatefulWidget {
  const OrderProduct({super.key});

  @override
  State<OrderProduct> createState() => _OrderProductState();
}

class _OrderProductState extends State<OrderProduct> {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeTab: 0,
      pageName: "Order Product",
      content: Container(),
    );
  }
}

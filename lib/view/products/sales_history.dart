import 'package:flutter/material.dart';
import 'package:migo/layout/layout.dart';

class SalesHistory extends StatelessWidget {
  const SalesHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeTab: 1,
      content: Container(),
      pageName: "Sales History",
    );
  }
}

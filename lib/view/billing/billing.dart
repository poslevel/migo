import 'package:flutter/material.dart';
import 'package:migo/layout/layout.dart';

class Billing extends StatelessWidget {
  const Billing({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeTab: 0,
      content: Row(
        children: const [],
      ),
      pageName: "Billing",
    );
  }
}

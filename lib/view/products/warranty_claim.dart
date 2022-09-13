import 'package:flutter/material.dart';
import 'package:migo/layout/layout.dart';

class WarrantyClaim extends StatelessWidget {
  const WarrantyClaim({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeTab: 1,
      content: Container(),
      pageName: "Warranty Claim",
    );
  }
}

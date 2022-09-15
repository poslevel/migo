import 'package:flutter/material.dart';
import 'package:migo/layout/layout.dart';
import 'package:migo/view/responsive.dart';

class Billing extends StatelessWidget {
  const Billing({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeTab: 0,
      content: Column(
        children: [
          Column(
            children: [
              Row(),
              const Divider(),
            ],
          ),
          SizedBox(
            width: !Responsive.isMobile(context)
                ? MediaQuery.of(context).size.width - 110
                : null,
            height: !Responsive.isMobile(context)
                ? MediaQuery.of(context).size.height - 150
                : MediaQuery.of(context).size.height - 220,
            child: Row(
              children: [
                Expanded(child: Container()),
                Expanded(child: Container()),
              ],
            ),
          )
        ],
      ),
      pageName: "Billing",
    );
  }
}

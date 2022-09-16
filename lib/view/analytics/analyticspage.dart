import 'package:flutter/material.dart';
import 'package:migo/layout/layout.dart';
import 'package:migo/widgets/billing_page_divider.dart';
import 'package:migo/widgets/piechart.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeTab: 1,
      pageName: "Analytics",
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 32,
                backgroundImage: AssetImage("assets/avatar.png"),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Hello, " + " Hayat Tamboli" + "👋",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  Text(
                    "These are your reports, have a great day",
                    style: TextStyle(color: Color(0xffB9B7FF)),
                  ),
                ],
              ),
            ],
          ),
          const BillingPageDivider(),
          const SizedBox(height: 16),
          const Text("Status",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          Row(),
        ],
      ),
    );
  }
}

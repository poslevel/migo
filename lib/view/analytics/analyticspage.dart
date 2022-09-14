import 'package:flutter/material.dart';
import 'package:migo/layout/layout.dart';
import 'package:migo/widgets/piechart.dart';

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
      content: Row(
        children: const [SizedBox(height: 270, child: PieChartSample2())],
      ),
    );
  }
}

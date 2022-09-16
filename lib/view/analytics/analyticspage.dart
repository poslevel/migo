import 'package:flutter/material.dart';
import 'package:migo/layout/layout.dart';
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
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(
                  height: 270,
                  child: PieChartSample2(),
                ),
                ToggleSwitch(
                  initialLabelIndex: 0,
                  totalSwitches: 3,
                  inactiveBgColor: Color(0xff1F212E),
                  activeFgColor: Color(0xff1F212E),
                  labels: ['Days', 'Weeks', 'Months'],
                  onToggle: (index) {
                    print('switched to: $index');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

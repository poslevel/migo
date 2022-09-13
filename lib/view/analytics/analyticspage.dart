import 'package:flutter/material.dart';
import 'package:migo/layout/layout.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppLayout(
        activeTab: 2,
        pageName: "Analytics",
        content: Row(
          children: [
            InkWell(
              onTap: () {},
              child: Card(
                child: Column(
                  children: const [
                    Text("Analytics page"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:migo/layout/layout.dart';
import 'package:migo/widgets/piechart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeTab: 0,
      pageName: "Home",
      content: Row(
        children: [SizedBox(height: 270, child: PieChartSample2())],
      ),
    );
  }
}

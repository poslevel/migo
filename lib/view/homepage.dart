import 'package:flutter/material.dart';
import 'package:migo/layout/layout.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppLayout(
        activeTab: 0,
        pageName: "Home",
        content: Container(),
      ),
    );
  }
}

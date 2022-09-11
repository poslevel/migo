import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/layout/layout.dart';
import 'package:migo/view/responsive.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AppLayout(
          content: Row(
            children: [
              // Main Panel
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Icon(Iconsax.user),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(),
                    ),
                  ],
                ),
              ),
              // Right Panel
              Visibility(
                visible: Responsive.isDesktop(context),
                child: Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Container(),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

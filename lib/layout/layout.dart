import 'package:flutter/cupertino.dart';
import 'package:migo/layout/navigation_panel.dart';
import 'package:migo/layout/top_app_bar.dart';
import 'package:migo/view/responsive.dart';

class AppLayout extends StatelessWidget {
  final Widget content;

  const AppLayout({Key? key, required this.content}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: Column(
        children: [
          const TopAppBar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: content,
            ),
          ),
          const NavigationPanel(
            axis: Axis.horizontal,
          ),
        ],
      ),
      desktop: Row(
        children: [
          const NavigationPanel(
            axis: Axis.vertical,
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0, bottom: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 100, child: TopAppBar()),
                  Expanded(child: content),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
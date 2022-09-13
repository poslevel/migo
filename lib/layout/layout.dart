import 'package:flutter/cupertino.dart';
import 'package:migo/layout/navigation_panel.dart';
import 'package:migo/layout/top_app_bar.dart';
import 'package:migo/view/responsive.dart';

class AppLayout extends StatelessWidget {
  final Widget content;
  final String pageName;
  final int activeTab;
  const AppLayout(
      {Key? key,
      required this.content,
      required this.pageName,
      required this.activeTab})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: Column(
        children: [
          TopAppBar(
            pageName: pageName,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: content,
            ),
          ),
          NavigationPanel(
            axis: Axis.horizontal,
            activeTab: activeTab,
          ),
        ],
      ),
      desktop: Row(
        children: [
          NavigationPanel(
            axis: Axis.vertical,
            activeTab: activeTab,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TopAppBar(
                  pageName: pageName,
                ),
                Expanded(child: content),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Responsive.isMobile(context)
            ? const Size.fromHeight(128)
            : Size.zero,
        child: Visibility(
          visible: Responsive.isMobile(context),
          child: TopAppBar(
            pageName: pageName,
          ),
        ),
      ),
      bottomNavigationBar: Visibility(
        visible: Responsive.isMobile(context),
        child: NavigationPanel(
          axis: Axis.horizontal,
          activeTab: activeTab,
        ),
      ),
      body: Responsive(
        mobile: Column(
          children: [
            Expanded(
              child: content,
            ),
          ],
        ),
        desktop: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NavigationPanel(
              axis: Axis.vertical,
              activeTab: activeTab,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TopAppBar(
                      pageName: pageName,
                    ),
                    Expanded(child: content),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

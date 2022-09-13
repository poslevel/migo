import 'package:flutter/cupertino.dart';
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
      bottomNavigationBar: Responsive.isMobile(context)
          ? NavigationPanel(
              axis: Axis.horizontal,
              activeTab: activeTab,
            )
          : Container(
              height: 0,
            ),
      body: SafeArea(
        child: Flex(
          direction:
              Responsive.isDesktop(context) ? Axis.horizontal : Axis.vertical,
          children: [
            NavigationPanel(
              axis: Responsive.isDesktop(context)
                  ? Axis.vertical
                  : Axis.horizontal,
              activeTab: activeTab,
            ),
            Column(
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
              ],
            ),
          ],
        ),
        // desktop: Row(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     NavigationPanel(
        //       axis: Axis.vertical,
        //       activeTab: activeTab,
        //     ),
        //     Row(
        //       mainAxisSize: MainAxisSize.max,
        //       children: [
        //         Column(
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             TopAppBar(
        //               pageName: pageName,
        //             ),
        //             content,
        //           ],
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
        // ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/models/navigation_items.dart';
import 'package:migo/view/analytics/analyticspage.dart';
// import 'package:migo/view/employees/employee_dashboard.dart';
// import 'package:migo/view/homepage.dart';
import 'package:migo/view/products/productpage.dart';
import 'package:migo/view/responsive.dart';
import 'package:migo/view/settings/settingspage.dart';
import 'package:migo/widgets/nav_buttons.dart';

class NavigationPanel extends StatefulWidget {
  final Axis axis;
  final int activeTab;
  const NavigationPanel({Key? key, required this.axis, required this.activeTab})
      : super(key: key);

  @override
  State<NavigationPanel> createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 80),
      decoration: BoxDecoration(
        color: const Color(0xff1F212E),
        borderRadius: !Responsive.isMobile(context)
            ? const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )
            : BorderRadius.circular(0),
      ),
      margin: const EdgeInsets.all(0),
      child: widget.axis == Axis.vertical
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                    onTap: () {
                      // Get.to(
                      //   () => const HomePage(),
                      //   transition: Transition.noTransition,
                      // );
                      Get.to(
                        () => const ProductsPage(),
                        transition: Transition.noTransition,
                      );
                    },
                    child: Image.asset("assets/logo.png")),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: NavigationItems.values
                      .map(
                        (e) => NavigationButton(
                          onPressed: () {
                            // if (e.index == 0) {
                            //   Get.to(
                            //     () => const HomePage(),
                            //     transition: Transition.noTransition,
                            //   );
                            // }
                            if (e.index == 0) {
                              Get.to(
                                () => const ProductsPage(),
                                transition: Transition.noTransition,
                              );
                            }
                            if (e.index == 1) {
                              Get.to(
                                () => const AnalyticsPage(),
                                transition: Transition.noTransition,
                              );
                            }
                            // if (e.index == 3) {
                            //   Get.to(
                            //     () => const EmployeesPage(),
                            //     transition: Transition.noTransition,
                            //   );
                            // }
                          },
                          icon: e.icon,
                          isActive: e.index == widget.activeTab,
                        ),
                      )
                      .toList(),
                ),
                IconButton(
                  onPressed: () {
                    Get.to(
                      () => const SettingsPage(),
                      transition: Transition.noTransition,
                    );
                  },
                  icon: Icon(
                    Iconsax.setting,
                    color: widget.activeTab == 5
                        ? Colors.white
                        : const Color(0xff6C6BA9),
                  ),
                )
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NavigationButton(
                  isActive: widget.activeTab == 0,
                  icon: NavigationItems.products.icon,
                  onPressed: () {
                    Get.to(
                      () => const ProductsPage(),
                      transition: Transition.noTransition,
                    );
                  },
                ),
                NavigationButton(
                  isActive: widget.activeTab == 1,
                  icon: NavigationItems.analytics.icon,
                  onPressed: () {
                    Get.to(
                      () => const AnalyticsPage(),
                      transition: Transition.noTransition,
                    );
                  },
                ),
                NavigationButton(
                  isActive: widget.activeTab == 5,
                  onPressed: () {
                    Get.to(
                      () => const SettingsPage(),
                      transition: Transition.noTransition,
                    );
                  },
                  icon: Iconsax.setting,
                ),
              ],
            ),
    );
  }
}

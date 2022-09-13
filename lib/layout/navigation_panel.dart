import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/models/navigation_items.dart';
import 'package:migo/view/responsive.dart';
import 'package:migo/widgets/nav_buttons.dart';

class NavigationPanel extends StatefulWidget {
  final Axis axis;
  const NavigationPanel({Key? key, required this.axis}) : super(key: key);

  @override
  State<NavigationPanel> createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
  int activeTab = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 80),
      decoration: const BoxDecoration(
        color: Color(0xff1F212E),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      margin: Responsive.isDesktop(context)
          ? const EdgeInsets.all(0)
          : const EdgeInsets.all(10),
      child: widget.axis == Axis.vertical
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset("assets/logo.png"),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: NavigationItems.values
                      .map(
                        (e) => NavigationButton(
                          onPressed: () {
                            setState(() {
                              activeTab = e.index;
                            });
                          },
                          icon: e.icon,
                          isActive: e.index == activeTab,
                        ),
                      )
                      .toList(),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      activeTab = 5;
                    });
                  },
                  icon: Icon(
                    Iconsax.setting,
                    color:
                        activeTab == 5 ? Colors.white : const Color(0xff6C6BA9),
                  ),
                )
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: NavigationItems.values
                      .map(
                        (e) => NavigationButton(
                          onPressed: () {
                            setState(() {
                              activeTab = e.index;
                            });
                          },
                          icon: e.icon,
                          isActive: e.index == activeTab,
                        ),
                      )
                      .toList(),
                ),
                Container()
              ],
            ),
    );
  }
}

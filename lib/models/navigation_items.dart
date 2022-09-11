import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

enum NavigationItems {
  home,
  users,
  panel,
  pieChart,
}

extension NavigationItemsExtensions on NavigationItems {
  IconData get icon {
    switch (this) {
      case NavigationItems.home:
        return Iconsax.home;
      case NavigationItems.panel:
        return Iconsax.chart;
      case NavigationItems.pieChart:
        return Iconsax.chart_square;
      case NavigationItems.users:
        return Iconsax.user;
      default:
        return Iconsax.add;
    }
  }
}

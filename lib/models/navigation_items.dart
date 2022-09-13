import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

enum NavigationItems {
  home,
  products,
  analytics,
  employees,
}

extension NavigationItemsExtensions on NavigationItems {
  IconData get icon {
    switch (this) {
      case NavigationItems.home:
        return Iconsax.home;
      case NavigationItems.products:
        return Iconsax.box;
      case NavigationItems.analytics:
        return Iconsax.chart_square;
      case NavigationItems.employees:
        return Iconsax.people;
      default:
        return Iconsax.add;
    }
  }
}

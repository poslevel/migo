import 'package:flutter/material.dart';
import 'package:migo/view/responsive.dart';

class SearchShortcutIndicator extends StatelessWidget {
  const SearchShortcutIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: Responsive.isDesktop(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
            border: Border.all(
              width: 1.5,
              color: const Color(0xffDAEEB8),
            ),
            borderRadius: BorderRadius.circular(4)),
        child: const Text("/"),
      ),
    );
  }
}

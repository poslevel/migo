import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:migo/view/homepage.dart';

class ProductCTACard extends StatelessWidget {
  final Widget toPage;
  final String caption;
  final String image;
  final Color? cardColor;
  const ProductCTACard({
    Key? key,
    this.toPage = const HomePage(),
    required this.caption,
    required this.image,
    required this.cardColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => toPage, transition: Transition.noTransition);
      },
      borderRadius: BorderRadius.circular(20),
      child: Card(
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(image),
              Text(
                caption,
                style: const TextStyle(
                  color: Color(0xff0c0d16),
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

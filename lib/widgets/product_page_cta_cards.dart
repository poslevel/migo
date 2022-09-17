import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:migo/view/products/productpage.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductCTACard extends StatelessWidget {
  final Widget toPage;
  final String caption;
  final String image;
  final bool isGoToAdmin;
  final Color? cardColor;
  const ProductCTACard({
    Key? key,
    this.toPage = const ProductsPage(),
    required this.caption,
    required this.image,
    required this.cardColor,
    this.isGoToAdmin = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!isGoToAdmin) {
          Get.to(() => toPage, transition: Transition.noTransition);
        } else {
          _launchUrl("https://backpos.herokuapp.com/admin/");
        }
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

Future<void> _launchUrl(url) async {
  final Uri _url = Uri.parse(url);
  if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $_url';
  }
}

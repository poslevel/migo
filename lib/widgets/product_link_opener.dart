import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDescriptionLinkOpener extends StatelessWidget {
  const ProductDescriptionLinkOpener({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: const Color(0xff0C0D16),
          borderRadius: BorderRadius.circular(16)),
      child: IconButton(
        padding: const EdgeInsets.all(16),
        onPressed: () {
          _launchUrl(url);
        },
        icon: const Icon(Iconsax.export_3),
      ),
    );
  }
}

Future<void> _launchUrl(url) async {
  final Uri _url = Uri.parse(url);
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}
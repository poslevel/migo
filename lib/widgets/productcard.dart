import 'package:flutter/material.dart';
import 'package:migo/models/product/product.dart';
import 'package:migo/view/responsive.dart';
import 'package:migo/widgets/product_link_opener.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Responsive.isDesktop(context)
          ? (MediaQuery.of(context).size.width - 100) / 3
          : 315,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image.asset(
                        "assets/mi_watch_img.png",
                        scale: Responsive.isMobile(context) ? 1 : 1.2,
                      ),
                    ],
                  ),
                  Text(
                    product.name.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 22),
                  ),
                  Row(
                    children: [
                      const Text(
                        "Price: ",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 22),
                      ),
                      Text(
                        "₹ ${product.sellingPrice?.replaceAllMapped(reg, mathFunc)}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 24),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Variants: ",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 22),
                        ),
                        Row(
                          children: const [
                            VariantCircle(),
                            VariantCircle(),
                            VariantCircle(),
                          ],
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Amount in Stock: ${product.stockAmount}",
                        style: const TextStyle(
                          color: Color(0xffB9B7FF),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          ProductDescriptionLinkOpener(url: product.description.toString()),
        ],
      ),
    );
  }
}

class VariantCircle extends StatelessWidget {
  const VariantCircle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 36,
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xffFF6900), width: 2.0),
      ),
    );
  }
}

RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
String Function(Match) mathFunc = (Match match) => '${match[1]},';

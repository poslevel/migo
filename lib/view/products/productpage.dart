import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:migo/layout/layout.dart';
import 'package:migo/view/homepage.dart';
import 'package:migo/view/products/billing.dart';
import 'package:migo/view/products/product_replacement.dart';
import 'package:migo/view/products/sales_history.dart';
import 'package:migo/view/products/warranty_claim.dart';
import 'package:migo/view/responsive.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeTab: 1,
      pageName: "Products",
      content: SingleChildScrollView(
        primary: false,
        child: Column(
          children: const [
            CTARow(),
          ],
        ),
      ),
    );
  }
}

class CTARow extends StatelessWidget {
  const CTARow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction:
          Responsive.isDesktop(context) ? Axis.horizontal : Axis.vertical,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProductCard(
            toPage: Billing(),
            caption: "Create Bill",
            image: "assets/create_bill_ill.png",
            cardColor: Color(0xffDAEEB8)),
        const ProductCard(
            toPage: SalesHistory(),
            caption: "View Sales History",
            image: "assets/view_sales_history.png",
            cardColor: Color(0xffFFD58E)),
        const ProductCard(
            caption: "Order a Product",
            image: "assets/order_a_product.png",
            cardColor: Color(0xffBEE4FF)),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Get.to(() => const ProductReplacement(),
                    transition: Transition.noTransition);
              },
              borderRadius: BorderRadius.circular(20),
              child: Card(
                color: const Color(0xffB9B7FF),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 24,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Product Replacement",
                        style: TextStyle(
                          color: Color(0xff0c0d16),
                          fontWeight: FontWeight.w800,
                          fontSize: 24,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: const Color(0xff6C6BA9),
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8),
                        margin: const EdgeInsets.only(top: 8),
                        child: const Text(
                          "< 7 days of delivery",
                          style: TextStyle(
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => const WarrantyClaim(),
                    transition: Transition.noTransition);
              },
              borderRadius: BorderRadius.circular(20),
              child: const Card(
                color: Color(0xffB9B7FF),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
                  child: Text(
                    "Warranty Claim",
                    style: TextStyle(
                      color: Color(0xff0c0d16),
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final Widget toPage;
  final String caption;
  final String image;
  final Color? cardColor;
  const ProductCard({
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
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
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

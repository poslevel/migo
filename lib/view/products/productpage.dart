import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
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
        padding: const EdgeInsets.only(left: 8.0),
        primary: false,
        child: Column(
          children: [
            const CTARow(),
            SizedBox(
              width: !Responsive.isMobile(context)
                  ? MediaQuery.of(context).size.width - 90
                  : null,
              child: Wrap(
                children: [
                  ProductCard(),
                  ProductCard(),
                  ProductCard(),
                  ProductCard(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Responsive.isDesktop(context) ? 400 : 300,
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
                      Image.asset("assets/mi_watch_img.png"),
                    ],
                  ),
                  const Text(
                    "Mi Watch Revolve Active",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 28),
                  ),
                  Row(
                    children: [
                      const Text(
                        "Price: ",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 22),
                      ),
                      const Text(
                        "₹9,999",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 28),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Variants: ",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 22),
                      ),
                      Row(
                        children: [
                          VariantCircle(),
                          VariantCircle(),
                          VariantCircle(),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(24),
            decoration: BoxDecoration(
                color: Color(0xff0C0D16),
                borderRadius: BorderRadius.circular(16)),
            child: IconButton(
                padding: EdgeInsets.all(16),
                onPressed: () {},
                icon: Icon(Iconsax.export_3)),
          ),
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
      margin: EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        shape: BoxShape.circle,
        border: Border.all(color: Color(0xffFF6900), width: 2.0),
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
    return SizedBox(
      // height: Responsive.isDesktop(context) ? 270 : null,
      width: !Responsive.isMobile(context)
          ? MediaQuery.of(context).size.width - 90
          : null,
      child: Wrap(
        spacing: 4,
        direction:
            !Responsive.isMobile(context) ? Axis.horizontal : Axis.vertical,
        // mainAxisSize: MainAxisSize.max,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProductCTACard(
              toPage: Billing(),
              caption: "Create Bill",
              image: "assets/create_bill_ill.png",
              cardColor: Color(0xffDAEEB8)),
          const ProductCTACard(
              toPage: SalesHistory(),
              caption: "View Sales History",
              image: "assets/view_sales_history.png",
              cardColor: Color(0xffFFD58E)),
          const ProductCTACard(
              caption: "Order a Product",
              image: "assets/order_a_product.png",
              cardColor: Color(0xffBEE4FF)),
          Column(
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
                        horizontal: 24.0, vertical: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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
              SizedBox(
                height: 135,
                width: 315,
                child: InkWell(
                  onTap: () {
                    Get.to(() => const WarrantyClaim(),
                        transition: Transition.noTransition);
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Card(
                    color: const Color(0xffB9B7FF),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 24),
                      child: Column(
                        children: [
                          const Text(
                            "Warranty Claim",
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
                              "Check Product Authentication",
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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

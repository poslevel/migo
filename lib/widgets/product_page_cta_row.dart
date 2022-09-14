import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:migo/view/billing/billing.dart';
import 'package:migo/view/products/product_replacement.dart';
import 'package:migo/view/products/sales_history.dart';
import 'package:migo/view/products/warranty_claim.dart';
import 'package:migo/view/responsive.dart';
import 'package:migo/widgets/product_page_cta_cards.dart';


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

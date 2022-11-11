import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:migo/utils/functions.dart';
import 'package:migo/view/products/billing/billing_page.dart';
import 'package:migo/view/products/salesHistory/sales_history.dart';
import 'package:migo/view/responsive.dart';
import 'package:migo/view/products/main/widgets/cta_cards.dart';
import 'package:url_launcher/url_launcher.dart';

class CTARow extends StatelessWidget {
  const CTARow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: !Responsive.isMobile(context)
          ? MediaQuery.of(context).size.width - 90
          : null,
      child: Wrap(
        spacing: 4,
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        direction:
            !Responsive.isMobile(context) ? Axis.horizontal : Axis.vertical,
        children: [
          CTACard(
            toPage: Billing(isMobile: Responsive.isMobile(context)),
            caption: "create_bill".tr,
            image: "assets/create_bill_ill.png",
            cardColor: const Color(0xffDAEEB8),
            shortcut: "Ctrl + B",
          ),
          CTACard(
            toPage: const SalesHistory(),
            caption: "view_sales_history".tr,
            image: "assets/view_sales_history.png",
            cardColor: const Color(0xffFFD58E),
            shortcut: "Ctrl + H",
          ),
          CTACard(
            caption: "order_a_product".tr,
            image: "assets/order_a_product.png",
            cardColor: const Color(0xffBEE4FF),
            // toPage: const OrderProduct(),
            shortcut: "Ctrl + O",
            isGoToAdmin: true,
          ),
          Column(
            children: [
              InkWell(
                onTap: () {
                  // Get.to(() => const ProductReplacement(),
                  //     transition: Transition.noTransition);
                  Functions.launchURL(
                      "https://www.mi.com/in/service/replacefaq/");
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
                        Text(
                          "product_replacement".tr,
                          style: const TextStyle(
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
                    // Get.to(() => const WarrantyClaim(),
                    //     transition: Transition.noTransition);
                    _launchUrl("https://www.mi.com/in/service/warranty/");
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Card(
                    color: const Color(0xffB9B7FF),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 24),
                      child: Column(
                        children: [
                          Text(
                            "warranty_claim".tr,
                            style: const TextStyle(
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
                                horizontal: 24, vertical: 7),
                            margin: const EdgeInsets.only(top: 8),
                            child: const Text(
                              "Check Product Authentication",
                              maxLines: 1,
                              style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis),
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

Future<void> _launchUrl(url) async {
  // ignore: no_leading_underscores_for_local_identifiers
  final Uri _url = Uri.parse(url);
  if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $_url';
  }
}

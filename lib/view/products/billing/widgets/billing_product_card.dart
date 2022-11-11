import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/controller/invoice_controller.dart';
import 'package:migo/models/product/product.dart';
import 'package:migo/widgets/buttons.dart';
import 'package:migo/widgets/product_link_opener.dart';

class BillingProductCard extends StatelessWidget {
  final Product product;
  final InvoiceController invoiceController;
  const BillingProductCard(this.product, this.invoiceController, {super.key});

  @override
  Widget build(BuildContext context) {
    // width: Responsive.isDesktop(context)
    //     ? (MediaQuery.of(context).size.width - 500) / 3
    //     : Responsive.isTablet(context)
    //         ? (MediaQuery.of(context).size.width - 500)
    //         : MediaQuery.of(context).size.width - 8,
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            border: Border.all(
              color: product.stockAmount! <= 5
                  ? const Color(0xffff6565)
                  : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Card(
            margin: const EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FadeInImage(
                        image: NetworkImage(product.image.toString()),
                        placeholder:
                            const AssetImage("assets/placeholder_product.png"),
                        fit: BoxFit.fitWidth,
                        placeholderFit: BoxFit.fitWidth,
                        width: 200,
                        height: 200,
                      ),
                    ],
                  ),
                  Text(
                    product.name.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                  Row(
                    children: [
                      Text(
                        "${"price".tr}: ",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "₹${product.sellingPrice.toString().substring(0, product.sellingPrice.toString().length - 3)}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 20),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      if (product.stockAmount! > 0)
                        Expanded(
                          child: PrimaryButton(
                            buttonTitle: "add_to_bill".tr,
                            onPressed: () {
                              invoiceController.productList.add(
                                Product(
                                  id: product.id,
                                  name: product.name,
                                  description: product.description,
                                  category: product.category,
                                  price: product.price,
                                  sellingPrice: product.sellingPrice,
                                  stockAmount: product.stockAmount,
                                ),
                              );
                              Get.snackbar(
                                "Added product to cart",
                                product.name!,
                                duration: const Duration(seconds: 1),
                                isDismissible: true,
                              );
                              var sellpr = product.sellingPrice.toString();
                              invoiceController.addToTotal(
                                int.parse(
                                    sellpr.substring(0, sellpr.length - 3)),
                              );
                            },
                            iconLeft: const Icon(Iconsax.add_circle),
                            bgColor: const Color(0xffDAEEB8),
                            textColor: const Color(0xff1F212E),
                            iconBgColor: const Color(0xffBEE29B),
                          ),
                        ),
                      if (product.stockAmount! == 0)
                        const Text(
                          "Out of stock",
                          style: TextStyle(
                            color: Color(0xffff6565),
                            fontSize: 24,
                          ),
                        )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        ProductDescriptionLinkOpener(url: product.url.toString()),
      ],
    );
  }
}

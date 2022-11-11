import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:migo/controller/invoice_controller.dart';
import 'package:migo/view/responsive.dart';
import 'package:migo/widgets/buttons.dart';
import 'package:migo/widgets/product_cart_list_tile.dart';

class ProductCart extends StatefulWidget {
  final TabController tabController;
  const ProductCart({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  State<ProductCart> createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  final InvoiceController invoiceController = Get.put(InvoiceController());
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Products to be billed",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                TextButton(
                    onPressed: () {
                      invoiceController.clearInvoice();
                    },
                    child: const Text("clear all"))
              ],
            ),
            Expanded(
              child: Obx(
                () => invoiceController.productList.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: invoiceController.productList.length,
                        itemBuilder: (_, i) => ProductToBeBilledListTile(
                          product: invoiceController.productList[i],
                          index: i,
                          invoiceController: invoiceController,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/cart_empty_state.png"),
                        ],
                      ),
              ),
            ),
            const Divider(
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Total"),
                    Obx(
                      () => Text(
                        "₹${invoiceController.totalAmt}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                PrimaryButton(
                  onPressed: () {
                    widget.tabController
                        .animateTo(Responsive.isMobile(context) ? 2 : 1);
                  },
                  buttonTitle: "Continue",
                  horzPad: 20,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

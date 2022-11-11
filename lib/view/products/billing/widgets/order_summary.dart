import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/controller/invoice_controller.dart';
import 'package:migo/view/products/billing/widgets/order_summary_product_tile.dart';
import 'package:migo/widgets/buttons.dart';

class OrderSummary extends StatefulWidget {
  final InvoiceController invoiceController;
  const OrderSummary({
    Key? key,
    required this.invoiceController,
  }) : super(key: key);

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  final TextEditingController couponController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Order Summary",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const Divider(
              color: Colors.white,
            ),
            Flexible(
              child: Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.invoiceController.productList.length,
                  itemBuilder: (_, i) => OrderSummaryProductTile(
                    product: widget.invoiceController.productList[i],
                    index: i,
                    invoiceController: widget.invoiceController,
                  ),
                ),
              ),
            ),
            const Divider(
              color: Colors.white,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.ticket_discount),
                        hintText: "Gift or discount code",
                      ),
                      controller: couponController,
                    ),
                  ),
                ),
                PrimaryButton(
                  onPressed: () {
                    if (couponController.text == "hayat50" ||
                        couponController.text == "manas50") {
                      widget.invoiceController.totalAmt.value =
                          (widget.invoiceController.totalAmt.value / 2).round();
                      Get.snackbar("${couponController.text} used",
                          "order is now 50% off");
                    }
                  },
                  bgColor: const Color(0xffBEE29B),
                  textColor: const Color(0xff0C0D16),
                  buttonTitle: "Apply",
                ),
              ],
            ),
            const Divider(
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Subtotal",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Obx(() => Text("₹${widget.invoiceController.totalAmt}")),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Shipping",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text("₹0"),
              ],
            ),
            const Divider(
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Total"),
                Obx(
                  () => Text(
                    "₹${widget.invoiceController.totalAmt}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

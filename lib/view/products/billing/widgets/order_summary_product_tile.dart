import 'package:flutter/material.dart';
import 'package:migo/controller/invoice_controller.dart';
import 'package:migo/models/product/product.dart';

class OrderSummaryProductTile extends StatefulWidget {
  final Product product;
  final int index;
  final InvoiceController invoiceController;
  const OrderSummaryProductTile({
    required this.product,
    required this.index,
    required this.invoiceController,
    Key? key,
  }) : super(key: key);

  @override
  State<OrderSummaryProductTile> createState() =>
      _OrderSummaryProductTileState();
}

class _OrderSummaryProductTileState extends State<OrderSummaryProductTile> {
  late int quantity;
  @override
  void initState() {
    super.initState();
    setState(() {
      quantity = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.product.name.toString(),
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(widget.invoiceController.productList[widget.index].qty
                        .toString()),
                    Text(
                      "₹ ${widget.product.sellingPrice.toString().substring(0, widget.product.sellingPrice.toString().length - 3)}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

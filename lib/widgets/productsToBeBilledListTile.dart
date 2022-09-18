import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/controller/invoice_controller.dart';
import 'package:migo/models/product/product.dart';
import 'package:migo/widgets/buttons.dart';
import 'package:quantity_input/quantity_input.dart';

class ProductToBeBilledListTile extends StatefulWidget {
  final Product product;
  final int index;
  final InvoiceController invoiceController;
  const ProductToBeBilledListTile({
    required this.product,
    required this.index,
    required this.invoiceController,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductToBeBilledListTile> createState() =>
      _ProductToBeBilledListTileState();
}

class _ProductToBeBilledListTileState extends State<ProductToBeBilledListTile> {
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        widget.product.name.toString(),
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      "(₹ ${widget.product.sellingPrice.toString().substring(0, widget.product.sellingPrice.toString().length - 3)})",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    // const SizedBox(
                    //   width: 100,
                    //   child: TextField(
                    //     decoration: InputDecoration(
                    //       label: Text("Quanitity"),
                    //       fillColor: Color(0xff0C0D16),
                    //       floatingLabelBehavior: FloatingLabelBehavior.always,
                    //     ),
                    //   ),
                    // ),
                    QuantityInput(
                      value: quantity,
                      onChanged: (val) {
                        int change = int.parse(val) - quantity;
                        setState(() {
                          quantity = int.parse(val);
                        });
                        var priceOfTheItem = int.parse(widget.invoiceController
                            .productList[widget.index].sellingPrice
                            .toString()
                            .substring(
                                0,
                                widget.invoiceController
                                        .productList[widget.index].sellingPrice
                                        .toString()
                                        .length -
                                    3));
                        int priceToBeChanged = priceOfTheItem * change;
                        if (change < 0) {
                          widget.invoiceController
                              .removeFromTotal(priceToBeChanged * -1);
                        } else {
                          widget.invoiceController.addToTotal(priceToBeChanged);
                        }
                      },
                      buttonColor: const Color(0xffBEE4FF),
                      iconColor: const Color(0xff1F212E),
                      maxValue: 10,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     const Text("Price"),
                    //     Text(
                    //       "₹${product.sellingPrice.toString()}",
                    //       style: const TextStyle(
                    //         fontSize: 20,
                    //         fontWeight: FontWeight.w700,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          Column(
            children: [
              // Image.asset(
              //   "assets/mi_watch_img.png",
              //   scale: 2.5,
              // ),
              FadeInImage(
                image: NetworkImage("https://i.imgur.com/JZtfCYf.png"),
                placeholder: AssetImage("assets/placeholder_product.png"),
                fit: BoxFit.fitWidth,
                placeholderFit: BoxFit.fitWidth,
                width: 80,
                height: 80,
              ),
              PrimaryButton(
                onPressed: () {
                  var priceToBeDeducted = int.parse(widget
                      .invoiceController.productList[widget.index].sellingPrice
                      .toString()
                      .substring(
                          0,
                          widget.invoiceController.productList[widget.index]
                                  .sellingPrice
                                  .toString()
                                  .length -
                              3));
                  widget.invoiceController.productList.removeAt(widget.index);
                  widget.invoiceController.removeFromTotal(priceToBeDeducted);
                },
                // buttonTitle: "Remove product",
                bgColor: const Color(0xffFFBBC1),
                iconLeft: const Icon(Iconsax.trash),
                iconBgColor: const Color(0xffF29DA3),
                textColor: const Color(0xff1F212E),
              )
            ],
          ),
        ],
      ),
    );
  }
}

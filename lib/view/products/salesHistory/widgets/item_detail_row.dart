import 'package:flutter/material.dart';
import 'package:migo/models/invoice/invoice.dart';
import 'package:migo/view/responsive.dart';

class ItemDetailRow extends StatelessWidget {
  final Items item;

  const ItemDetailRow({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff1F212E)),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "${item.title} (${item.unitPrice})",
              maxLines: 2,
              style: TextStyle(
                  fontSize: Responsive.isMobile(context) ? 16 : 20,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xffB9B7FF)),
            ),
          ),
          Text(
            "x${item.quantity.toString()} ",
            style: TextStyle(
              fontSize: Responsive.isMobile(context) ? 16 : 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "₹${item.netAmount.toString()}",
            style: TextStyle(
                fontSize: Responsive.isMobile(context) ? 16 : 20,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

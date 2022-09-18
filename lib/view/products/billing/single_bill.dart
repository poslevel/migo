import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/controller/invoice_controller.dart';
import 'package:migo/view/products/sales%20history/sales_history.dart';
import 'package:migo/widgets/buttons.dart';

class SingleBill extends StatefulWidget {
  final int index;
  final InvoiceController invoiceController;
  const SingleBill(
      {super.key, required this.index, required this.invoiceController});

  @override
  State<SingleBill> createState() => _SingleBillState();
}

class _SingleBillState extends State<SingleBill> {
  @override
  Widget build(BuildContext context) {
    var seletedBill = widget.invoiceController.salesList[widget.index];
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Text(
                  "Purchase: Mi Watch Revolve",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: BillLabel(
                    color: Color(0xffBEE29B),
                    status: "Paid",
                  ),
                )
              ],
            ),
            const Text("14 Aug 2022"),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xff1F212E)),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    children: [
                      BillDetailRow(
                        property: "Bill ID",
                        value: seletedBill.invoiceNumber.toString(),
                      ),
                      BillDetailRow(
                        property: "Amount",
                        value: seletedBill.netAmount.toString(),
                      ),
                      BillDetailRow(
                        property: "Type",
                        value: seletedBill.invoiceType.toString(),
                      ),
                      BillDetailRow(
                        property: "Customer Name",
                        value: seletedBill.clientName.toString(),
                      ),
                      BillDetailRow(
                        property: "POS operator",
                        value: "Hayat",
                      ),
                      BillDetailRow(
                        property: "Bill sent Via",
                        value: "E-mail",
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Products",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xff1F212E)),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: ListView.builder(
                    itemCount: seletedBill.items!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => const BillDetailRow(
                      // TODO: errors sambhal
                      property: seletedBill.items[index].title,
                      value: seletedBill.items[index].unitPrice,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Actions",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    PrimaryButton(
                      buttonTitle: "Cancel Bill",
                      onPressed: () {},
                      iconLeft: const Icon(Iconsax.close_circle),
                      bgColor: const Color(0xffFFBBC1),
                      iconBgColor: const Color(0xffF29DA3),
                      textColor: const Color(0xff1F212E),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class BillDetailRow extends StatelessWidget {
  final String property;
  final String value;
  const BillDetailRow({
    required this.property,
    required this.value,
    Key? key,
  }) : super(key: key);

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
          Text(
            property,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xffB9B7FF)),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

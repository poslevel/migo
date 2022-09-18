import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/controller/invoice_controller.dart';
import 'package:migo/models/invoice/invoice.dart';
import 'package:migo/view/products/sales%20history/sales_history.dart';
import 'package:migo/widgets/buttons.dart';

class MobileSingleBill extends StatefulWidget {
  final int index;
  final InvoiceController invoiceController;
  const MobileSingleBill(
      {super.key, required this.index, required this.invoiceController});

  @override
  State<MobileSingleBill> createState() => _MobileSingleBillState();
}

class _MobileSingleBillState extends State<MobileSingleBill> {
  @override
  Widget build(BuildContext context) {
    Invoice seletedBill = widget.invoiceController.salesList[widget.index];
    return Scaffold(
      appBar: AppBar(title: Text(seletedBill.invoiceNumber.toString())),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Text(
                    "Purchase: Mi Watch Revolve",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
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
                        MobileBillDetailRow(
                          property: "Bill ID",
                          value: seletedBill.invoiceNumber.toString(),
                        ),
                        MobileBillDetailRow(
                          property: "Amount",
                          value: seletedBill.netAmount.toString(),
                        ),
                        MobileBillDetailRow(
                          property: "Type",
                          value: seletedBill.invoiceType.toString(),
                        ),
                        MobileBillDetailRow(
                          property: "Customer Name",
                          value: seletedBill.clientName.toString(),
                        ),
                        const MobileBillDetailRow(
                          property: "POS operator",
                          value: "Hayat",
                        ),
                        const MobileBillDetailRow(
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
                      itemBuilder: (context, i) =>
                          ItemDetailRow(item: seletedBill.items![i]),
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
      ),
    );
  }
}

class MobileBillDetailRow extends StatelessWidget {
  final String property;
  final String value;
  const MobileBillDetailRow({
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
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xffB9B7FF)),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

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
          Text(
            item.title.toString(),
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xffB9B7FF)),
          ),
          Text(
            item.netAmount.toString(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

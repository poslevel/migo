// ignore_for_file: depend_on_referenced_packages, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/controller/invoice_controller.dart';
import 'package:migo/models/invoice/invoice.dart';
import 'package:migo/view/products/salesHistory/sales_history.dart';
import 'package:migo/view/products/salesHistory/widgets/invoice_printable_data.dart';
import 'package:migo/view/products/salesHistory/widgets/item_detail_row.dart';
import 'package:migo/view/products/salesHistory/widgets/print_invoice_btn.dart';
import 'package:migo/widgets/buttons.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class MobileSingleBill extends StatefulWidget {
  final int index;
  final InvoiceController invoiceController;
  const MobileSingleBill(
      {super.key, required this.index, required this.invoiceController});

  @override
  State<MobileSingleBill> createState() => _MobileSingleBillState();
}

class _MobileSingleBillState extends State<MobileSingleBill> {
  Future<void> printDoc(selectedBill) async {
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return buildPrintableInvoice(selectedBill);
        }));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  @override
  Widget build(BuildContext context) {
    Invoice selectedBill = widget.invoiceController.salesList[widget.index];
    return Scaffold(
      appBar: AppBar(title: Text(selectedBill.invoiceNumber.toString())),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Purchase: ${selectedBill.items![0].title}",
                    style:const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  const Padding(
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
                          value: selectedBill.invoiceNumber.toString(),
                        ),
                        MobileBillDetailRow(
                          property: "Amount",
                          value: selectedBill.netAmount.toString(),
                        ),
                        MobileBillDetailRow(
                          property: "Type",
                          value: selectedBill.invoiceType.toString(),
                        ),
                        MobileBillDetailRow(
                          property: "Customer Name",
                          value: selectedBill.clientName.toString(),
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
                  Text(
                    "products".tr,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xff1F212E)),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: ListView.builder(
                      itemCount: selectedBill.items!.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) =>
                          ItemDetailRow(item: selectedBill.items![i]),
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
                      ),
                      const SizedBox(width: 8),
                      PrintInvoiceBtn(
                          printFunction: () => printDoc(selectedBill)),
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
              color: Color(0xffB9B7FF),
            ),
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

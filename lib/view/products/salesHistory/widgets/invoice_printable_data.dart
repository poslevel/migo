// ignore_for_file: depend_on_referenced_packages

import 'package:migo/models/invoice/invoice.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

buildPrintableInvoice(Invoice selectedBill) => pw.Padding(
      padding: const pw.EdgeInsets.all(16.00),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          //header
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    "INVOICE",
                    style: pw.TextStyle(
                      fontSize: 28,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    "14 Aug 2022",
                    style: const pw.TextStyle(fontSize: 16),
                  ),
                ],
              ),
              pw.SizedBox(height: 10.00),
              pw.Text(
                "No. ${selectedBill.invoiceNumber!}",
                style: const pw.TextStyle(
                  color: PdfColor(0.5, 0.5, 0.5, 0.5),
                  fontSize: 12.00,
                ),
              ),
              pw.SizedBox(height: 10.00),
              pw.Text("${selectedBill.clientName!}/MiGo"),
              pw.SizedBox(height: 30.00),
            ],
          ),

          // item table
          pw.Column(children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Row(
                  children: [
                    pw.Text("#"),
                    pw.SizedBox(width: 20.00),
                    pw.SizedBox(
                      width: 300,
                      child: pw.Text(
                        "ITEM",
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                pw.Text("QTY"),
                pw.Text("PRICE"),
              ],
            ),
            pw.ListView.builder(
              spacing: 10,
              itemBuilder: (context, index) {
                return pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Row(
                      children: [
                        pw.Text((index + 1).toString()),
                        pw.SizedBox(width: 20.00),
                        pw.SizedBox(
                          width: 300,
                          child: pw.Text(
                            "${selectedBill.items![index].title}",
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    pw.Text("${selectedBill.items![index].quantity}"),
                    pw.Text("RS. ${selectedBill.items![index].unitPrice}"),
                  ],
                );
              },
              itemCount: selectedBill.items!.length,
            ),
            pw.Divider(),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text("Total"),
                pw.Text(
                  "INR ${selectedBill.netAmount.toString()}",
                  style: const pw.TextStyle(
                    color: PdfColor(255 / 255, 105 / 255, 0, 1),
                  ),
                ),
              ],
            ),
          ]),

          // final note
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
            pw.Column(
              children: [
                pw.SizedBox(height: 10.00),
                pw.Text(
                  "Thanks for choosing our service!",
                  style: const pw.TextStyle(
                      color: PdfColor(0.5, 0.5, 0.5, 0.5), fontSize: 12.00),
                ),
                pw.SizedBox(height: 5.00),
                pw.Text(
                  "Contact the branch for any clarifications.",
                  style: const pw.TextStyle(
                      color: PdfColor(0.5, 0.5, 0.5, 0.5), fontSize: 12.00),
                ),
                pw.SizedBox(height: 15.00),
              ],
            ),
          ]),
        ],
      ),
    );

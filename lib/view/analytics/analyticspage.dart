// ignore_for_file: depend_on_referenced_packages, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/view/layout/layout.dart';
import 'package:migo/view/responsive.dart';
import 'package:migo/view/products/billing/widgets/page_divider.dart';
import 'package:migo/widgets/buttons.dart';
import 'package:migo/widgets/charts/products_sold_line_chart.dart';
import 'package:migo/widgets/charts/revenue_line_chart.dart';
import 'package:migo/widgets/charts/customers_line_chart.dart';
import 'package:migo/widgets/charts/piechart.dart';
import 'package:migo/view/analytics/widgets/report_printable_data.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeTab: 1,
      pageName: "analytics".tr,
      content: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(!Responsive.isMobile(context) ? 0 : 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flex(
                direction: Responsive.isMobile(context)
                    ? Axis.vertical
                    : Axis.horizontal,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 32,
                        backgroundImage: AssetImage("assets/avatar.png"),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello, " + " Hayat Tamboli" + "👋",
                            style: TextStyle(
                                fontSize:
                                    !Responsive.isMobile(context) ? 24 : 18,
                                fontWeight: FontWeight.w800),
                          ),
                          const Text(
                            "These are your reports, have a great day",
                            style: TextStyle(color: Color(0xffB9B7FF)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PrimaryButton(
                      onPressed: () => printDoc(),
                      buttonTitle: "Print Report",
                      textColor: const Color(0xff1F212E),
                      bgColor: const Color(0xffBEE4FF),
                    ),
                  ),
                ],
              ),
              const PageDivider(),
              const SizedBox(height: 32),
              const Text("Status",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              const AnalyticsStatus(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> printDoc() async {
    final image = await imageFromAssetBundle(
      "assets/avatar.png",
    );
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return buildPrintableReport(image);
        }));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }
}

class AnalyticsStatus extends StatelessWidget {
  const AnalyticsStatus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: !Responsive.isMobile(context)
          ? MediaQuery.of(context).size.width - 90
          : MediaQuery.of(context).size.width,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const RevenueStatus(),
          const CustomersStatus(),
          const ProductSoldStatus(),
          if (Responsive.isDesktop(context))
            const ProductsSoldByCategoryChart(),
        ],
      ),
    );
  }
}

class RevenueStatus extends StatelessWidget {
  const RevenueStatus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: !Responsive.isMobile(context)
          ? (MediaQuery.of(context).size.width - 100) / 2
          : MediaQuery.of(context).size.width - 16,
      height: 400,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: const Color(0xffBEE29B),
                    borderRadius: BorderRadius.circular(16)),
                child: const Icon(
                  Iconsax.dollar_square,
                  size: 32,
                  color: Color(0xff1F212E),
                ),
              ),
              const Text(
                "Revenue",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                "\$45000",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Expanded(
                child: RevenueLineChart(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomersStatus extends StatelessWidget {
  const CustomersStatus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: !Responsive.isMobile(context)
          ? (MediaQuery.of(context).size.width - 100) / 2
          : MediaQuery.of(context).size.width - 16,
      height: 400,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: const Color(0xff90BAF9),
                    borderRadius: BorderRadius.circular(16)),
                child: const Icon(
                  Iconsax.people,
                  size: 32,
                  color: Color(0xff1F212E),
                ),
              ),
              const Text(
                "Customers",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                "40",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Expanded(
                child: CustomersLineChart(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProductSoldStatus extends StatelessWidget {
  const ProductSoldStatus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: !Responsive.isMobile(context)
          ? (MediaQuery.of(context).size.width - 100) / 2
          : MediaQuery.of(context).size.width - 16,
      height: 400,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: const Color(0xffF29DA3),
                    borderRadius: BorderRadius.circular(16)),
                child: const Icon(
                  Iconsax.box_1,
                  size: 32,
                  color: Color(0xff1F212E),
                ),
              ),
              const Text(
                "Products Sold",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                "70",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Expanded(
                child: ProductsSoldLineChart(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_adjacent_string_concatenation

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:keymap/keymap.dart';
import 'package:migo/controller/invoice_controller.dart';
import 'package:migo/view/layout/layout.dart';
import 'package:migo/models/invoice/invoice.dart';
import 'package:migo/view/products/billing/billing_page.dart';
import 'package:migo/view/products/salesHistory/widgets/mobile_single_bill.dart';
import 'package:migo/view/products/salesHistory/widgets/single_bill.dart';
import 'package:migo/view/responsive.dart';
import 'package:migo/widgets/buttons.dart';
import 'package:migo/widgets/search_shortcut_indicator.dart';

class SalesHistory extends StatefulWidget {
  const SalesHistory({super.key});

  @override
  State<SalesHistory> createState() => _SalesHistoryState();
}

class _SalesHistoryState extends State<SalesHistory> {
  final InvoiceController invoiceController = Get.put(InvoiceController());
  late FocusNode searchFocusNode;

  @override
  void initState() {
    super.initState();
    invoiceController.fetchAllInvoice();
    searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    searchFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardWidget(
      bindings: [
        KeyAction.fromString(
          '/',
          'focus on search',
          () {
            searchFocusNode.requestFocus();
          },
        ),
        KeyAction.fromString(
          'B',
          'create a bill',
          () {
            Get.to(() => Billing(isMobile: Responsive.isMobile(context)));
          },
          isControlPressed: true,
        ),
      ],
      child: AppLayout(
        activeTab: 0,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ActionRow(
              focusNode: searchFocusNode,
            ),
            SizedBox(
              width: !Responsive.isMobile(context)
                  ? MediaQuery.of(context).size.width - 110
                  : null,
              height: !Responsive.isMobile(context)
                  ? MediaQuery.of(context).size.height - 150
                  : MediaQuery.of(context).size.height - 240,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Obx(
                      () {
                        if (invoiceController.isLoading.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: invoiceController.salesList.length,
                            itemBuilder: (context, index) => BillCard(
                              invoice: invoiceController.salesList[index],
                              index: index,
                              invoiceController: invoiceController,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  if (Responsive.isDesktop(context))
                    Obx(
                      () {
                        if (invoiceController.selectedInvoice.value == -1) {
                          return const Expanded(
                            flex: 2,
                            child: SalesHistoryEmptyState(),
                          );
                        } else {
                          return Expanded(
                            flex: 2,
                            child: Obx(
                              () => SingleBill(
                                index: invoiceController.selectedInvoice.value,
                                invoiceController: invoiceController,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                ],
              ),
            )
          ],
        ),
        pageName: "Sales History",
      ),
    );
  }
}

class SalesHistoryEmptyState extends StatelessWidget {
  const SalesHistoryEmptyState({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("assets/select_bill_empty_state.png"),
        const Text(
          "Select a bill to view it",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class BillCard extends StatelessWidget {
  final Invoice invoice;
  final int index;
  final InvoiceController invoiceController;

  const BillCard(
      {super.key,
      required this.invoice,
      this.index = 0,
      required this.invoiceController});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: const Color(0xff1F212E),
      onTap: () {
        invoiceController.setSelectedInvoice(index);
        debugPrint(invoiceController.selectedInvoice.value.toString());
        if (Responsive.isMobile(context)) {
          Get.to(
            () => MobileSingleBill(
              index: invoiceController.selectedInvoice.value,
              invoiceController: invoiceController,
            ),
          );
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(
              color: Color(0xff1F212E),
            ),
          ),
        ),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BillCardRow1(
              price: invoice.netAmount?.toInt() ?? 0,
              status: "paid",
            ),
            const SizedBox(height: 8),
            BillCardRow2(
              productName: invoice.items![0].title ?? "Nothing",
            ),
            const SizedBox(height: 8),
            BillCardRow3(
              typeOfPayment: invoice.invoiceType?.toString() ?? "",
              customerName: invoice.clientName?.toString() ?? "",
            ),
          ],
        ),
      ),
    );
  }
}

class BillCardRow2 extends StatelessWidget {
  final String productName;
  const BillCardRow2({
    Key? key,
    required this.productName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Purchase: $productName",
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class BillCardRow3 extends StatelessWidget {
  final String typeOfPayment;
  final String customerName;
  const BillCardRow3({
    Key? key,
    required this.typeOfPayment,
    required this.customerName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          typeOfPayment,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xffB9B7FF)),
        ),
        const Text(
          "•",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xffB9B7FF)),
        ),
        Text(
          customerName,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xffB9B7FF)),
        ),
      ],
    );
  }
}

class BillCardRow1 extends StatelessWidget {
  final int price;
  final String status;
  const BillCardRow1({Key? key, required this.price, required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BillLabel(color: const Color(0xffBEE29B), status: status),
        Text(
          "₹$price",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class BillLabel extends StatelessWidget {
  final Color color;
  final String status;
  const BillLabel({
    Key? key,
    required this.color,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          border: Border.all(
            color: color,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8)),
      child: Text(
        status,
        style: TextStyle(color: color, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class ActionRow extends StatefulWidget {
  final FocusNode focusNode;
  const ActionRow({
    Key? key,
    required this.focusNode,
  }) : super(key: key);

  @override
  State<ActionRow> createState() => _ActionRowState();
}

class _ActionRowState extends State<ActionRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: Responsive.isMobile(context)
            ? MediaQuery.of(context).size.width
            : 400,
        child: Row(
          children: [
            // const FilterBtn(),
            Expanded(
              child: TextField(
                focusNode: widget.focusNode,
                decoration: const InputDecoration(
                  fillColor: Colors.transparent,
                  prefixIcon: Icon(Iconsax.search_normal),
                  hintText: 'Search...',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
            ),
            const SearchShortcutIndicator(),
            const SizedBox(width: 8),
            PrimaryButton(
              buttonTitle:
                  !Responsive.isMobile(context) ? "Create a new bill" : null,
              iconLeft: const Icon(Iconsax.add_circle),
              onPressed: () {
                Get.to(() => Billing(isMobile: Responsive.isMobile(context)),
                    transition: Transition.noTransition);
              },
              bgColor: const Color(0xffDAEEB8),
              textColor: const Color(0xff1F212E),
              iconBgColor: const Color(0xffBEE29B),
            )
          ],
        ),
      ),
    );
  }
}

class FilterBtn extends StatelessWidget {
  const FilterBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xff6C6BA9),
          width: 2.0,
        ),
      ),
      child: IconButton(
        onPressed: () {},
        icon: const Icon(
          Iconsax.filter,
          color: Color(0xff6C6BA9),
        ),
      ),
    );
  }
}

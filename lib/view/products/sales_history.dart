import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/layout/layout.dart';
import 'package:migo/view/billing/billing.dart';
import 'package:migo/view/billing/single_bill.dart';
import 'package:migo/view/responsive.dart';
import 'package:migo/widgets/buttons.dart';

class SalesHistory extends StatelessWidget {
  const SalesHistory({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController _controller = new ScrollController();
    return AppLayout(
      activeTab: 0,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ActionRow(),
          const SizedBox(height: 16),
          SizedBox(
            width: !Responsive.isMobile(context)
                ? MediaQuery.of(context).size.width - 110
                : null,
            height: !Responsive.isMobile(context)
                ? MediaQuery.of(context).size.height - 150
                : MediaQuery.of(context).size.height - 220,
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    controller: _controller,
                    itemBuilder: (context, index) => BillCard(
                      price: index,
                      status: "Paid",
                      typeOfPayment: "Debit Card",
                      customerName: "Hayat",
                    ),
                  ),
                ),
                if (Responsive.isDesktop(context))
                  const Expanded(
                    flex: 2,
                    child: SalesHistoryEmptyState(),
                  ),
                if (Responsive.isDesktop(context) && false)
                  const Expanded(
                    flex: 2,
                    child: SingleBill(),
                  ),
              ],
            ),
          )
        ],
      ),
      pageName: "Sales History",
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
        Text(
          "Select a bill to view it",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class BillCard extends StatelessWidget {
  final int price;
  final String status;
  final String typeOfPayment;
  final String customerName;
  const BillCard({
    Key? key,
    this.status = "Paid",
    required this.price,
    required this.typeOfPayment,
    required this.customerName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: const Color(0xff1F212E),
      onTap: () {
        
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
              price: price,
              status: status,
            ),
            const SizedBox(height: 8),
            const BillCardRow2(),
            const SizedBox(height: 8),
            BillCardRow3(
              typeOfPayment: typeOfPayment,
              customerName: customerName,
            ),
          ],
        ),
      ),
    );
  }
}

class BillCardRow2 extends StatelessWidget {
  const BillCardRow2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Purchase: " + "Mi Watch Revolve",
      style: TextStyle(
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
          "₹" + price.toString(),
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

class ActionRow extends StatelessWidget {
  const ActionRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 16,
        ),
        const FilterBtn(),
        const SizedBox(
          width: 200,
          child: TextField(
            decoration: InputDecoration(
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
        PrimaryButton(
          buttonTitle: "Create a new bill",
          iconLeft: const Icon(Iconsax.add_circle),
          onPressed: () {
            Get.to(() => const Billing(), transition: Transition.noTransition);
          },
          bgColor: const Color(0xffDAEEB8),
          textColor: const Color(0xff1F212E),
          iconBgColor: const Color(0xffBEE29B),
        )
      ],
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

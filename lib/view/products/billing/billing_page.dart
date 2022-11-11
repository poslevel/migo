import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/controller/invoice_controller.dart';
import 'package:migo/view/layout/layout.dart';
import 'package:migo/view/products/billing/add_products_page.dart';
import 'package:migo/view/products/billing/customer_info_page.dart';
import 'package:migo/view/products/billing/payments_page.dart';
import 'package:migo/view/products/billing/widgets/product_cart.dart';
import 'package:migo/view/responsive.dart';

class Billing extends StatefulWidget {
  final bool isMobile;
  const Billing({super.key, required this.isMobile});

  @override
  State<Billing> createState() => _BillingState();
}

class _BillingState extends State<Billing> with SingleTickerProviderStateMixin {
  final InvoiceController invoiceController = Get.put(InvoiceController());
  static List<Tab> desktopTabs = <Tab>[
    Tab(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: const [
          Icon(
            Iconsax.bag,
            size: 20,
          ),
          Text("Add Products"),
        ],
      ),
    )),
    Tab(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: const [
          Icon(
            Iconsax.user_edit,
            size: 20,
          ),
          Text("Customer info"),
        ],
      ),
    )),
    Tab(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: const [
          Icon(
            Iconsax.dollar_square,
            size: 20,
          ),
          Text("Payment"),
        ],
      ),
    )),
  ];
  static List<Tab> mobileTabs = <Tab>[
    Tab(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: const [
          Icon(
            Iconsax.bag,
            size: 20,
          ),
          Text("Add Products"),
        ],
      ),
    )),
    Tab(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: const [
          Icon(
            Iconsax.bag_happy,
            size: 20,
          ),
          Text("Cart"),
        ],
      ),
    )),
    Tab(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: const [
          Icon(
            Iconsax.user_edit,
            size: 20,
          ),
          Text("Customer info"),
        ],
      ),
    )),
    Tab(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: const [
          Icon(
            Iconsax.dollar_square,
            size: 20,
          ),
          Text("Payment"),
        ],
      ),
    )),
  ];

  late TabController _tabController;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        vsync: this,
        length: widget.isMobile ? mobileTabs.length : desktopTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    nameController.dispose();
    emailController.dispose();
    phonenumberController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeTab: 0,
      pageName: "Billing",
      content: SizedBox(
        width: !Responsive.isMobile(context)
            ? MediaQuery.of(context).size.width - 120
            : MediaQuery.of(context).size.width,
        child: Scaffold(
          appBar: TabBar(
            controller: _tabController,
            unselectedLabelColor: Colors.white,
            isScrollable: true,
            tabs: widget.isMobile ? mobileTabs : desktopTabs,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xffB9B7FF),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              AddProductsPage(
                tabController: _tabController,
                invoiceController: invoiceController,
              ),
              if (widget.isMobile)
                ProductCart(
                  tabController: _tabController,
                ),
              CustomerInfoPage(
                nameController: nameController,
                emailController: emailController,
                phonenumberController: phonenumberController,
                addressController: addressController,
                formkey: _formKey,
                tabController: _tabController,
                invoiceController: invoiceController,
              ),
              PaymentsPage(invoiceController: invoiceController),
            ],
          ),
        ),
      ),
    );
  }
}

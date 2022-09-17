import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/controller/invoice_controller.dart';
import 'package:migo/layout/layout.dart';
import 'package:migo/view/products/billing/add_products_page.dart';
import 'package:migo/view/products/billing/customer_info_page.dart';
import 'package:migo/view/products/productpage.dart';
import 'package:migo/view/responsive.dart';
import 'package:migo/widgets/buttons.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

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
                ProductsToBeBilledList(
                  invoiceController: invoiceController,
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
              const PaymentsPage(),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  static const platform = const MethodChannel("razorpay_flutter");

  var _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_9rAnsAfrRv0Epc',
      'amount': 11,
      'name': 'MiGo',
      'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '7887537943', 'email': 'hayat.tamboli@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('🤑Success Response: $response');
    // Do something when payment succeeds
    /*Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);*/
    Get.to(() => const ProductsPage());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('😣Error Response: $response');
    // Do something when payment fails
    /* Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('⚡External SDK Response: $response');
    // Do something when payment fails
    /* Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Card(
              child: PrimaryButton(
                onPressed: openCheckout,
                buttonTitle: "Test Payment",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

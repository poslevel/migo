import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/controller/invoice_controller.dart';
import 'package:migo/view/products/billing/payment_success.dart';
import 'package:migo/view/responsive.dart';
import 'package:migo/widgets/buttons.dart';
import 'package:migo/widgets/productsToBeBilledListTile.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../productpage.dart';

class PaymentsPage extends StatefulWidget {
  final InvoiceController invoiceController;
  const PaymentsPage({
    Key? key,
    required this.invoiceController,
  }) : super(key: key);

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  // ignore: unnecessary_const, unused_field
  final InvoiceController invoiceGenerateController =
      Get.put(InvoiceController());

  static const platform = MethodChannel("razorpay_flutter");

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
    String? orderId = await invoiceGenerateController.createInvoice();
    var options = {
      'key': 'rzp_test_9rAnsAfrRv0Epc',
      'amount': 11,
      'name': 'MiGo',
      'description': '',
      'retry': {'enabled': true, 'max_count': 1},
      'order_id': orderId,
      'send_sms_hash': true,
      'prefill': {'contact': '7887537943', 'email': 'hayat.tamboli@gmail.com'},
      'external': {
        'wallets': ['paytm']
      },
      'theme': {"backdrop_color": "#ffF1C17a"}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    debugPrint('🤑Success Response: $response');
    // Do something when payment succeeds
    /*Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);*/
    Get.to(() => const ProductsPage());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint('😣Error Response: $response');
    // Do something when payment fails
    /* Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint('⚡External SDK Response: $response');
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
        child: Flex(
          direction: Axis.vertical,
          children: [
            SizedBox(
              width: 315,
              height: MediaQuery.of(context).size.height / 2,
              child: _ProductsToBeBilledList(
                  invoiceController: widget.invoiceController),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: PrimaryButton(
                  bgColor: Color(0xffBEE29B),
                  textColor: Color(0xff0C0D16),
                  onPressed: () {
                    Get.to(() => PaymentSuccessPage());
                  },
                  buttonTitle: "Cash payment",
                  iconLeft: Icon(Iconsax.moneys),
                  horzPad: 24,
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: PrimaryButton(
                  onPressed: openCheckout,
                  iconLeft: Icon(Iconsax.card_pos),
                  buttonTitle: "Online Payment",
                  horzPad: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductsToBeBilledList extends StatelessWidget {
  final InvoiceController invoiceController;
  const _ProductsToBeBilledList({
    Key? key,
    required this.invoiceController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Products to be billed",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                TextButton(
                    onPressed: () {
                      invoiceController.clearInvoice();
                    },
                    child: const Text("clear all"))
              ],
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: invoiceController.productList.length,
                  itemBuilder: (_, i) => ProductToBeBilledListTile(
                    product: invoiceController.productList[i],
                    index: i,
                    invoiceController: invoiceController,
                  ),
                ),
              ),
            ),
            const Divider(
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Total"),
                    Obx(
                      () => Text(
                        "₹" + invoiceController.totalAmt.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

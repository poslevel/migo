import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/controller/invoice_controller.dart';
import 'package:migo/controller/payment_method_controller.dart';
import 'package:migo/models/upi.dart';
import 'package:migo/utils/functions.dart';
import 'package:migo/view/products/billing/payment_success.dart';
import 'package:migo/view/products/billing/widgets/order_summary.dart';
import 'package:migo/view/responsive.dart';
import 'package:migo/widgets/buttons.dart';
import 'package:migo/widgets/upi_qrcode/upi_qrcode.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../main/product_page.dart';

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
  final PaymentMethodController paymentMethodController =
      Get.put(PaymentMethodController());
  late StreamSubscription<ConnectivityResult> subscription;
  String connection = "online";

  // ignore: unused_field
  static const platform = MethodChannel("razorpay_flutter");

  var _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    checkcon();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        setState(() {
          connection = "offline";
        });
      } else {
        setState(() {
          connection = "online";
        });
      }
    });
  }

  void checkcon() async {
    var result = await Functions.checkConnectivity();
    debugPrint(result.toString());
    if (result == ConnectivityResult.none) {
      setState(() {
        connection = "offline";
      });
    } else {
      setState(() {
        connection = "online";
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
    _razorpay.clear();
  }

  void openCheckout() async {
    String? orderId = await invoiceGenerateController.createInvoice();
    var options = {
      'key': 'rzp_test_9rAnsAfrRv0Epc',
      'amount': 11,
      'name': 'MiGo',
      'description': '',
      'retry': {'enabled': true, 'max_count': 3},
      'order_id': orderId,
      'send_sms_hash': true,
      'prefill': {
        'contact': widget.invoiceController.customerPhone ?? '7887537943',
        'email':
            widget.invoiceController.customerEmail ?? 'hayat.tamboli@gmail.com'
      },
      'external': {
        'wallets': ['paytm']
      },
      'theme': {"backdrop_color": "#ffF1C17a"}
    };

    try {
      _razorpay.open(options);
      debugPrint("razorpay tried working");
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

  var delivery = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: Responsive.isMobile(context)
            ? const EdgeInsets.all(16.0)
            : const EdgeInsets.all(24.0),
        child: Flex(
          direction:
              Responsive.isMobile(context) ? Axis.vertical : Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: Responsive.isMobile(context)
                  ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width / 2.5,
              // height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OrderSummary(invoiceController: widget.invoiceController),
                ],
              ),
            ),
            SizedBox(
              width: Responsive.isMobile(context)
                  ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width / 2.5,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Payment",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    Obx(
                      () => SizedBox(
                        height: Responsive.isMobile(context) ? 64 * 3 : 64,
                        child: Flex(
                          direction: Responsive.isMobile(context)
                              ? Axis.vertical
                              : Axis.horizontal,
                          children: [
                            Expanded(
                              child: RadioListTile(
                                value: "cash",
                                groupValue: paymentMethodController.mode.value,
                                title: const Text("Cash"),
                                onChanged: (val) {
                                  paymentMethodController
                                      .changed(val.toString());
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile(
                                value: "upi",
                                groupValue: paymentMethodController.mode.value,
                                title: const Text("UPI"),
                                onChanged: (val) {
                                  paymentMethodController
                                      .changed(val.toString());
                                },
                              ),
                            ),
                            if (connection == "online")
                              Expanded(
                                flex: Responsive.isMobile(context) ? 1 : 2,
                                child: RadioListTile(
                                  value: "razorpay",
                                  groupValue:
                                      paymentMethodController.mode.value,
                                  title: const Text("Card/Bank transfer"),
                                  onChanged: (val) {
                                    paymentMethodController
                                        .changed(val.toString());
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          shape: const CircleBorder(),
                          activeColor: Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .primary,
                          // value: delivery,
                          value: delivery,
                          onChanged: (bool? value) {
                            setState(() {
                              delivery = value!;
                            });
                          },
                        ),
                        const Text("Opt-in for delivery")
                      ],
                    ),
                    Obx(
                      () => Column(
                        children: [
                          if (paymentMethodController.mode.value == "cash")
                            PrimaryButton(
                              bgColor: const Color(0xffBEE29B),
                              textColor: const Color(0xff0C0D16),
                              onPressed: () {
                                Get.to(() => const PaymentSuccessPage());
                                invoiceGenerateController.createInvoice();
                              },
                              buttonTitle: "Cash payment",
                              iconLeft: const Icon(Iconsax.moneys),
                              horzPad: 24,
                            ),
                          if (paymentMethodController.mode.value == "upi")
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(24),
                                  color: Colors.white,
                                  child: UPIPaymentQRCode(
                                    upiDetails: UPIDetails(
                                        upiID: "hayat.tamboli@okhdfcbank",
                                        payeeName: "Hayat Tamboli",
                                        amount: widget
                                            .invoiceController.totalAmt
                                            .toDouble(),
                                        transactionNote: "For Ode2Code"),
                                    size: 200,
                                  ),
                                ),
                                PrimaryButton(
                                  bgColor: const Color(0xffbee4ff),
                                  textColor: const Color(0xff0C0D16),
                                  buttonTitle: "UPI payment confirmed",
                                  iconLeft: const Icon(Iconsax.barcode),
                                  horzPad: 24,
                                  onPressed: () {
                                    Get.to(() => const PaymentSuccessPage());
                                    invoiceGenerateController.createInvoice();
                                  },
                                )
                              ],
                            ),
                          if (paymentMethodController.mode.value ==
                                  "razorpay" &&
                              connection == "online")
                            PrimaryButton(
                              onPressed: openCheckout,
                              iconLeft: const Icon(Iconsax.card_pos),
                              buttonTitle: "Online Payment",
                              horzPad: 24,
                            ),
                        ],
                      ),
                    ),
                    if (connection == "offline")
                      const Text(
                        "you are Offline, Get online to access online payments",
                        style: TextStyle(
                            color: Color(0xffb9b7ff),
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

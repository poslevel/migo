import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:migo/widgets/buttons.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../productpage.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  // ignore: unnecessary_const, unused_field
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
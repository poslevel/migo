import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:migo/view/products/main/product_page.dart';
import 'package:migo/view/responsive.dart';

class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({super.key});

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  @override
  void initState() {
    navigate();
    super.initState();
  }

  void navigate() async {
    await Future.delayed(const Duration(seconds: 3), () {
      Get.to(() => const ProductsPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/payment_success.png",
                fit: BoxFit.contain,
                height: Responsive.isMobile(context) ? 200 : 300,
              ),
              Text(
                "Payment was a success",
                style: TextStyle(
                  fontSize: Responsive.isMobile(context) ? 20 : 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

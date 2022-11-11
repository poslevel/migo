import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:migo/controller/product_controller.dart';
import 'package:migo/models/authManager.dart';
import 'package:migo/view/setup.dart';

class SplashView extends StatelessWidget {
  final AuthenticationManager _authmanager = Get.put(AuthenticationManager());
  final ProductController productController = Get.put(ProductController());

  SplashView({super.key});

  Future<void> initializeSettings() async {
    _authmanager.checkLoginStatus();

    //Simulate other services for 3 seconds
    productController.fetchAllProducts();
    await Future.delayed(const Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeSettings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return waitingView();
        } else {
          if (snapshot.hasError) {
            return errorView(snapshot);
          } else {
            return const OnStart();
          }
        }
      },
    );
  }

  Scaffold errorView(AsyncSnapshot<Object?> snapshot) {
    return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
  }

  Scaffold waitingView() {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo.png",
              scale: 0.8,
            ),
            const SizedBox(
              width: 250,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: LinearProgressIndicator(),
              ),
            ),
            const Text(
              '🍳Cooking the next screen',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

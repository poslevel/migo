import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:migo/models/authManager.dart';
import 'package:migo/view/auth/login.dart';
import 'package:migo/view/onboarding/onboarding.dart';
import 'package:migo/view/products/productpage.dart';

class OnStart extends StatelessWidget {
  const OnStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationManager authManager = Get.find();
    final onboardingOnce = GetStorage();

    return Obx(() {
      return authManager.isLogged.value
          ? onboardingOnce.read('onboarded') ?? false
              ? const ProductsPage()
              : const Onboarding()
          : const LoginView();
    });
  }
}

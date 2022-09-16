import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:migo/models/authManager.dart';
import 'package:migo/view/auth/login.dart';
import 'package:migo/view/products/productpage.dart';

class OnStart extends StatelessWidget {
  const OnStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationManager authManager = Get.find();

    return Obx(() {
      return authManager.isLogged.value
          ? const ProductsPage()
          : const LoginView();
    });
  }
}

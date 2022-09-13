import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:migo/utils/theme_config.dart';
import 'package:migo/view/auth/login.dart';

main() async {
  await GetStorage.init();
  runApp(const MiGo());
}

class MiGo extends StatelessWidget {
  const MiGo({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MiGo',
      debugShowCheckedModeBanner: false,
      theme: mainTheme,
      home: const LoginView(),
      // home: const ProductsPage(),
    );
  }
}

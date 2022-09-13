import 'package:flutter/material.dart';
import 'package:migo/layout/layout.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppLayout(
        activeTab: 1,
        pageName: "Products",
        content: Row(
          children: [
            InkWell(
              onTap: () {},
              child: Card(
                child: Column(
                  children: const [
                    Text("Product page"),
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

import 'package:flutter/material.dart';
import 'package:migo/layout/layout.dart';
import 'package:migo/view/responsive.dart';
import 'package:migo/widgets/product_page_cta_row.dart';
import 'package:migo/widgets/productcard.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeTab: 0,
      pageName: "Products",
      content: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 8.0),
        primary: false,
        child: Column(
          children: [
            const CTARow(),
            SizedBox(
              width: !Responsive.isMobile(context)
                  ? MediaQuery.of(context).size.width - 90
                  : null,
              child: Wrap(
                children: const [
                  ProductCard(
                    price: 800,
                    name: "Mi Watch Revolve Active",
                    url:
                        "https://www.mi.com/in/product/mi-watch-revolve-active/",
                  ),
                  ProductCard(
                    price: 800,
                    name: "Mi Watch Revolve Active",
                    url:
                        "https://www.mi.com/in/product/mi-watch-revolve-active/",
                  ),
                  ProductCard(
                    price: 800,
                    name: "Mi Watch Revolve Active",
                    url:
                        "https://www.mi.com/in/product/mi-watch-revolve-active/",
                  ),
                  ProductCard(
                    price: 800,
                    name: "Mi Watch Revolve Active",
                    url:
                        "https://www.mi.com/in/product/mi-watch-revolve-active/",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

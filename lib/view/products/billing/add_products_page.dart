// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:migo/controller/invoice_controller.dart';
import 'package:migo/controller/product_controller.dart';
import 'package:migo/view/products/billing/widgets/product_cart.dart';
import 'package:migo/view/products/billing/widgets/product_grid.dart';
import 'package:migo/view/responsive.dart';
import 'package:migo/view/products/billing/widgets/page_divider.dart';

class AddProductsPage extends StatefulWidget {
  final TabController tabController;
  final InvoiceController invoiceController;
  const AddProductsPage({
    Key? key,
    required this.tabController,
    required this.invoiceController,
  }) : super(key: key);

  @override
  State<AddProductsPage> createState() => _AddProductsPageState();
}

class _AddProductsPageState extends State<AddProductsPage> {
  final ProductController productController = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
    productController.fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageDivider(),
        SizedBox(
          width: !Responsive.isMobile(context)
              ? MediaQuery.of(context).size.width - 110
              : null,
          height: !Responsive.isMobile(context)
              ? MediaQuery.of(context).size.height - 150
              : MediaQuery.of(context).size.height - 220,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: Responsive.isTablet(context) ? 3 : 5,
                child: const ProductsGrid(),
              ),
              if (!Responsive.isMobile(context))
                Expanded(
                  flex: 2,
                  child: ProductCart(
                    tabController: widget.tabController,
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}

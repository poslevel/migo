import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:keymap/keymap.dart';
import 'package:migo/controller/invoice_controller.dart';
import 'package:migo/controller/product_controller.dart';
import 'package:migo/utils/functions.dart';
import 'package:migo/view/products/billing/widgets/billing_product_card.dart';
import 'package:migo/view/responsive.dart';
import 'package:migo/widgets/search_shortcut_indicator.dart';

class ProductsGrid extends StatefulWidget {
  const ProductsGrid({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  final ProductController productController = Get.put(ProductController());
  final InvoiceController invoiceController = Get.put(InvoiceController());
  late FocusNode searchFocusNode;

  @override
  void initState() {
    super.initState();
    if (productController.searchList.isEmpty) {
      productController.fetchAllProducts();
    }
    debugPrint("🎇🎇🎇 fetched all products ");
    searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    searchFocusNode.dispose();

    super.dispose();
  }

  String? chosenDropdownOption;
  @override
  Widget build(BuildContext context) {
    var productFilter = DropdownButton(
      hint: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text("Select Filter"),
      ),
      elevation: 8,
      value: chosenDropdownOption,
      icon: const Icon(Iconsax.arrow_circle_down),
      borderRadius: BorderRadius.circular(8),
      items: const [
        DropdownMenuItem(
          value: "",
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "All products",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        DropdownMenuItem(
          value: "Audio",
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Audio",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        DropdownMenuItem(
          value: "Laptops",
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Laptops",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        DropdownMenuItem(
          value: "Fitness bands",
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Fitness bands",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        DropdownMenuItem(
          value: "Phones",
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Phones",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
      onChanged: Functions.filterProducts,
    );
    var billingAddProductKeyboardShortcuts = [
      KeyAction.fromString(
        '/',
        'focus on search',
        () {
          searchFocusNode.requestFocus();
        },
      ),
    ];
    return SingleChildScrollView(
      child: KeyboardWidget(
        bindings: billingAddProductKeyboardShortcuts,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: Responsive.isDesktop(context),
                        child: Obx(
                          () => Text(
                            "All Products in store (${productController.searchList.length})",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                onChanged: Functions.searchProducts,
                                focusNode: searchFocusNode,
                                decoration: const InputDecoration(
                                  fillColor: Colors.transparent,
                                  prefixIcon: Icon(Iconsax.search_normal),
                                  hintText: 'Search...',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                ),
                              ),
                            ),
                            const SearchShortcutIndicator(),
                          ],
                        ),
                      )
                    ],
                  ),
                  DropdownButtonHideUnderline(
                    child: productFilter,
                  ),
                ],
              ),
            ),
            Obx(
              () {
                if (productController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return GridView.builder(
                    shrinkWrap: true,
                    itemCount: productController.searchList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: Responsive.isDesktop(context)
                          ? 3
                          : Responsive.isMobile(context)
                              ? 1
                              : 2,
                      childAspectRatio: 4 / 5,
                    ),
                    itemBuilder: (_, index) => BillingProductCard(
                      productController.searchList[index],
                      invoiceController,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:keymap/keymap.dart';
import 'package:migo/controller/product_controller.dart';
import 'package:migo/utils/functions.dart';
import 'package:migo/view/layout/layout.dart';
import 'package:migo/view/products/billing/billing_page.dart';
import 'package:migo/view/products/main/widgets/product_card.dart';
import 'package:migo/view/products/orderProduct/order_product.dart';
import 'package:migo/view/products/salesHistory/sales_history.dart';
import 'package:migo/view/responsive.dart';
import 'package:migo/view/products/main/widgets/cta_row.dart';
import 'package:migo/widgets/search_shortcut_indicator.dart';
import 'package:sticky_headers/sticky_headers.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ProductController productController = Get.put(ProductController());
  late FocusNode searchFocusNode;

  @override
  void initState() {
    super.initState();
    if (productController.searchList.isEmpty) {
      productController.fetchAllProducts();
    }
    searchFocusNode = FocusNode();
  }

  // void searchFunction(val) {
  //   debugPrint("🎈🎈🎈 ${chosenDropdownOption ?? "all"}, $val");
  //   productController.fetchProducts(
  //       chosenDropdownOption ?? "all".toLowerCase(), val.toString());
  //   // when searching nothing
  //   if (val == "") {
  //     productController.fetchAllProducts();
  //     debugPrint("🎫🎫🎫");
  //   }
  // }

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
      hint: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Text(chosenDropdownOption ?? "Select Filter"),
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

    var productPageKeyboardShortcuts = [
      KeyAction.fromString(
        '/',
        'focus on search',
        () {
          searchFocusNode.requestFocus();
        },
      ),
      KeyAction.fromString(
        'B',
        'create a bill',
        () {
          Get.to(() => Billing(isMobile: Responsive.isMobile(context)));
        },
        isControlPressed: true,
      ),
      KeyAction.fromString(
        'H',
        'Go to history',
        () {
          Get.to(() => const SalesHistory());
        },
        isControlPressed: true,
      ),
      KeyAction.fromString(
        'O',
        'Order product',
        () {
          Get.to(() => const OrderProduct());
          Functions.launchURL("https://backpos.herokuapp.com/admin/");
        },
        isControlPressed: true,
      ),
    ];
    return KeyboardWidget(
      bindings: productPageKeyboardShortcuts,
      child: AppLayout(
        activeTab: 0,
        pageName: "products".tr,
        content: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 8.0),
          primary: false,
          child: Column(
            children: [
              // top row
              const CTARow(),
              // heading row with filters
              StickyHeader(
                header: Container(
                  padding: const EdgeInsets.only(right: 16),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: SizedBox(
                    width: !Responsive.isMobile(context)
                        ? MediaQuery.of(context).size.width - 110
                        : null,
                    child: Padding(
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
                                      fontSize: 28,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                              //search box
                              SizedBox(
                                width: 200,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        // onChanged: searchFunction,
                                        onChanged: Functions.searchProducts,
                                        focusNode: searchFocusNode,
                                        decoration: const InputDecoration(
                                          fillColor: Colors.transparent,
                                          prefixIcon:
                                              Icon(Iconsax.search_normal),
                                          hintText: 'Search...',
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0)),
                                            borderSide: BorderSide(
                                                color: Colors.transparent),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
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
                          DropdownButtonHideUnderline(child: productFilter),
                        ],
                      ),
                    ),
                  ),
                ),
                content: SizedBox(
                  width: !Responsive.isMobile(context)
                      ? MediaQuery.of(context).size.width - 90
                      : null,
                  child: Obx(
                    () {
                      if (productController.isLoading.value) {
                        return const Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: Responsive.isDesktop(context)
                                      ? 3
                                      : Responsive.isMobile(context)
                                          ? 1
                                          : 2,
                                  childAspectRatio:
                                      Responsive.isMobile(context) ? 1 : 7 / 6),
                          itemCount: productController.searchList.length,
                          itemBuilder: (_, index) =>
                              ProductCard(productController.searchList[index]),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

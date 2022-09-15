import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
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
    String? chosenDropdownOption;
    var profileDropdown = DropdownButton(
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
          value: "All",
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
          value: "Watches",
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Watches",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        DropdownMenuItem(
          value: "Earphones",
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Earphones",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        DropdownMenuItem(
          value: "Mobiles",
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Mobiles",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
      onChanged: (value) {
        setState(
          () {
            chosenDropdownOption = value;
            // print(value);
          },
        );
      },
    );
    return AppLayout(
      activeTab: 0,
      pageName: "Products",
      content: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 8.0),
        primary: false,
        child: Column(
          children: [
            // top row
            const CTARow(),
            // heading row with filters
            SizedBox(
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
                          child: const Text(
                            "All Products in store (28)",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 200,
                          child: TextField(
                            decoration: InputDecoration(
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
                        )
                      ],
                    ),
                    DropdownButtonHideUnderline(
                      child: profileDropdown,
                    ),
                  ],
                ),
              ),
            ),
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

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/controller/product_controller.dart';
import 'package:migo/view/responsive.dart';

class SearchAndFilterRow extends StatefulWidget {
  final ProductController productController;
  const SearchAndFilterRow({
    Key? key,
    required this.productController,
  }) : super(key: key);

  @override
  State<SearchAndFilterRow> createState() => _SearchAndFilterRowState();
}

class _SearchAndFilterRowState extends State<SearchAndFilterRow> {
  late FocusNode searchFocusNode;

  @override
  void initState() {
    super.initState();
    widget.productController.fetchAllProducts();
    searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    searchFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? chosenDropdownOption = "All";
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
          value: "TV",
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "TV",
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
      onChanged: (value) {
        setState(
          () {
            chosenDropdownOption = value;
            // print(value);
            if (chosenDropdownOption == "All") {
              widget.productController.fetchAllProducts();
            } else {
              widget.productController
                  .fetchProducts(chosenDropdownOption!.toLowerCase(), "Mi");
            }
          },
        );
      },
    );
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Visibility(
                visible: Responsive.isDesktop(context),
                child: Text(
                  "All Products in store (${widget.productController.productList.length})",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (val) {
                          debugPrint("🎈🎈🎈 $chosenDropdownOption, $val");
                          widget.productController.fetchProducts(
                              chosenDropdownOption!.toLowerCase(),
                              val.toString());
                          // }
                        },
                        focusNode: searchFocusNode,
                        decoration: const InputDecoration(
                          fillColor: Colors.transparent,
                          prefixIcon: Icon(Iconsax.search_normal),
                          hintText: 'Search...',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                      ),
                    ),
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
    );
  }
}

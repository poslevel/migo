import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/controller/invoice_controller.dart';
import 'package:migo/view/responsive.dart';
import 'package:migo/view/products/billing/widgets/page_divider.dart';
import 'package:migo/widgets/buttons.dart';

class CustomerInfoPage extends StatefulWidget {
  const CustomerInfoPage({
    Key? key,
    required this.nameController,
    required this.emailController,
    required this.phonenumberController,
    required this.addressController,
    required this.formkey,
    required this.tabController,
    required this.invoiceController,
  }) : super(key: key);

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phonenumberController;
  final TextEditingController addressController;
  final GlobalKey<FormState> formkey;
  final TabController tabController;
  final InvoiceController invoiceController;

  @override
  State<CustomerInfoPage> createState() => _CustomerInfoPageState();
}

class _CustomerInfoPageState extends State<CustomerInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
      child: Column(
        children: [
          const PageDivider(),
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                width: Responsive.isDesktop(context)
                    ? MediaQuery.of(context).size.width / 2
                    : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Customer Information",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        autofocus: true,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.user_octagon),
                            label: Text("Customer Name"),
                            hintText: "Jhon Doe"),
                        controller: widget.nameController,
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Name';
                          }
                          return null;
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.sms),
                          label: Text("E-mail"),
                          hintText: "jhon.doe@example.com",
                        ),
                        controller: widget.emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Email';
                          }
                          if (!value.isEmail) {
                            return 'Please enter valid Email';
                          }
                          return null;
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.call),
                            label: Text("Phone Number"),
                            hintText: "9553052451"),
                        controller: widget.phonenumberController,
                        keyboardType: TextInputType.phone,
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Phone number';
                          }
                          if (!value.isPhoneNumber) {
                            return 'Please enter a valid Phone number';
                          }
                          return null;
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        maxLines: 3,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.location),
                            label: Text("Address"),
                            hintText: "Where does your customer live"),
                        controller: widget.addressController,
                      ),
                    ),
                    PrimaryButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (widget.formkey.currentState!.validate()) {
                          // ... Navigate To next page
                          widget.invoiceController.customerName =
                              widget.nameController.text;
                          widget.invoiceController.customerEmail =
                              widget.emailController.text;
                          widget.invoiceController.customerPhone =
                              widget.phonenumberController.text;
                          widget.invoiceController.customerAddress =
                              widget.addressController.text;
                          widget.tabController
                              .animateTo(Responsive.isMobile(context) ? 3 : 2);
                        }
                      },
                      buttonTitle: "Continue",
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

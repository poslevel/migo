import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/controller/customer_details_controller.dart';
import 'package:migo/controller/product_controller.dart';
import 'package:migo/layout/layout.dart';
import 'package:migo/view/billing/add_products_page.dart';
import 'package:migo/view/responsive.dart';
import 'package:migo/widgets/billing_page_divider.dart';
import 'package:migo/widgets/buttons.dart';
import 'package:migo/widgets/product_link_opener.dart';

class Billing extends StatefulWidget {
  const Billing({super.key});

  @override
  State<Billing> createState() => _BillingState();
}

class _BillingState extends State<Billing> with SingleTickerProviderStateMixin {
  static List<Tab> myTabs = <Tab>[
    Tab(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: const [
          Icon(
            Iconsax.bag,
            size: 20,
          ),
          Text("Add Products"),
        ],
      ),
    )),
    Tab(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: const [
          Icon(
            Iconsax.user_edit,
            size: 20,
          ),
          Text("Customer info"),
        ],
      ),
    )),
    Tab(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: const [
          Icon(
            Iconsax.dollar_square,
            size: 20,
          ),
          Text("Payment"),
        ],
      ),
    )),
  ];

  late TabController _tabController;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    nameController.dispose();
    emailController.dispose();
    phonenumberController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeTab: 0,
      pageName: "Billing",
      content: SizedBox(
        width: !Responsive.isMobile(context)
            ? MediaQuery.of(context).size.width - 120
            : MediaQuery.of(context).size.width,
        child: Scaffold(
          appBar: TabBar(
            controller: _tabController,
            unselectedLabelColor: Colors.white,
            isScrollable: true,
            tabs: myTabs,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xffB9B7FF),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              AddProductsPage(
                tabController: _tabController,
              ),
              _CustomerInfoPage(
                nameController: nameController,
                emailController: emailController,
                phonenumberController: phonenumberController,
                addressController: addressController,
                formkey: _formKey,
                tabController: _tabController,
              ),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomerInfoPage extends StatelessWidget {
  const _CustomerInfoPage({
    Key? key,
    required this.nameController,
    required this.emailController,
    required this.phonenumberController,
    required this.addressController,
    required this.formkey,
    required this.tabController,
  }) : super(key: key);

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phonenumberController;
  final TextEditingController addressController;
  final GlobalKey<FormState> formkey;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final CustomerDetailsController _customerDetailsController =
        Get.put(CustomerDetailsController());
    return Form(
      key: formkey,
      child: Column(
        children: [
          const BillingPageDivider(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          icon: Icon(Iconsax.user_octagon),
                          label: Text("Customer Name"),
                          hintText: "Jhon Doe"),
                      controller: nameController,
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Name';
                        }
                        return null;
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Iconsax.sms),
                        label: Text("E-mail"),
                        hintText: "jhon.doe@example.com",
                      ),
                      controller: emailController,
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
                    padding: const EdgeInsets.all(24),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          icon: Icon(Iconsax.call),
                          label: Text("Phone Number"),
                          hintText: "9553052451"),
                      controller: phonenumberController,
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
                    padding: const EdgeInsets.all(24),
                    child: TextFormField(
                      maxLines: 3,
                      decoration: const InputDecoration(
                          icon: Icon(Iconsax.location),
                          label: Text("Address"),
                          hintText: "Where does your customer live"),
                      controller: addressController,
                    ),
                  ),
                  PrimaryButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (formkey.currentState!.validate()) {
                        // ... Navigate To next page
                        _customerDetailsController.name.value =
                            nameController.text;
                        _customerDetailsController.email.value =
                            emailController.text;
                        _customerDetailsController.phone.value =
                            phonenumberController.text;
                        _customerDetailsController.address.value =
                            addressController.text;
                        tabController.animateTo(2);
                      }
                    },
                    buttonTitle: "Continue",
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

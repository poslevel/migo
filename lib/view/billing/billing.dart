import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/controller/customer_details_controller.dart';
import 'package:migo/controller/product_controller.dart';
import 'package:migo/layout/layout.dart';
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
              const _AddProductsPage(),
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
      pageName: "Billing",
    );
  }
}

class _AddProductsPage extends StatelessWidget {
  const _AddProductsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BillingPageDivider(),
        SizedBox(
          width: !Responsive.isMobile(context)
              ? MediaQuery.of(context).size.width - 110
              : null,
          height: !Responsive.isMobile(context)
              ? MediaQuery.of(context).size.height - 150
              : MediaQuery.of(context).size.height - 220,
          child: Row(
            children: [
              const Expanded(
                flex: 5,
                child: _ProductsGrid(),
              ),
              if (!Responsive.isMobile(context))
                Expanded(flex: 2, child: Container()),
            ],
          ),
        )
      ],
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
                _customerDetailsController.name.value = nameController.text;
                _customerDetailsController.email.value = emailController.text;
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
    );
  }
}

class _ProductsGrid extends StatelessWidget {
  const _ProductsGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: 9,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: Responsive.isDesktop(context)
              ? 3
              : Responsive.isMobile(context)
                  ? 1
                  : 2,
          childAspectRatio: 4 / 5,
        ),
        itemBuilder: (_, index) => _ProductCard(
            price: index,
            name: " Mi ka phone",
            url: "https://hayat.design",
            quantitySelected: 0),
      ),
    );
  }
}

class _ProductCard extends StatefulWidget {
  final int price;
  final String name;
  final String url;
  final int quantitySelected;
  const _ProductCard({
    Key? key,
    required this.price,
    required this.name,
    required this.url,
    required this.quantitySelected,
  }) : super(key: key);

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  @override
  Widget build(BuildContext context) {
    ProductController productController = Get.put(ProductController());
    // width: Responsive.isDesktop(context)
    //     ? (MediaQuery.of(context).size.width - 500) / 3
    //     : Responsive.isTablet(context)
    //         ? (MediaQuery.of(context).size.width - 500)
    //         : MediaQuery.of(context).size.width - 8,
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.asset(
                      "assets/mi_watch_img.png",
                      scale: 1.5,
                    ),
                  ],
                ),
                Text(
                  widget.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 20),
                ),
                Row(
                  children: [
                    const Text(
                      "Price: ",
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    Text(
                      "₹" + widget.price.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (widget.quantitySelected == 0)
                      Expanded(
                        child: PrimaryButton(
                          buttonTitle: "Add to bill",
                          onPressed: () {},
                          iconLeft: const Icon(Iconsax.add_circle),
                          bgColor: const Color(0xffDAEEB8),
                          textColor: const Color(0xff1F212E),
                          iconBgColor: const Color(0xffBEE29B),
                        ),
                      ),
                    if (widget.quantitySelected != 0)
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: PrimaryButton(
                                buttonTitle: "Add one",
                                onPressed: () {},
                                iconLeft: const Icon(Iconsax.add_circle),
                                bgColor: const Color(0xffDAEEB8),
                                textColor: const Color(0xff1F212E),
                                iconBgColor: const Color(0xffBEE29B),
                              ),
                            ),
                            PrimaryButton(
                              onPressed: () {},
                              iconLeft: const Icon(Iconsax.trash),
                              bgColor: const Color(0xffFFBBC1),
                              textColor: const Color(0xff1F212E),
                              iconBgColor: const Color(0xffF29DA3),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
        ProductDescriptionLinkOpener(url: widget.url),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/controller/product_controller.dart';
import 'package:migo/layout/layout.dart';
import 'package:migo/view/responsive.dart';
import 'package:migo/widgets/buttons.dart';
import 'package:url_launcher/url_launcher.dart';

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // String selectedTab = "Add Products";
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
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(24),
                    child: TextField(
                      decoration: InputDecoration(
                          icon: Icon(Iconsax.user_octagon),
                          label: Text("Customer Name"),
                          hintText: "Jhon Doe"),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(24),
                    child: TextField(
                      decoration: InputDecoration(
                          icon: Icon(Iconsax.sms),
                          label: Text("E-mail"),
                          hintText: "jhon.doe@example.com"),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(24),
                    child: TextField(
                      decoration: InputDecoration(
                          icon: Icon(Iconsax.call),
                          label: Text("Phone Number"),
                          hintText: "9553052451"),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(24),
                    child: TextField(
                      maxLines: 3,
                      decoration: InputDecoration(
                          icon: Icon(Iconsax.location),
                          label: Text("Address"),
                          hintText: "Where does your customer live"),
                    ),
                  ),
                  PrimaryButton(
                    onPressed: () {},
                    buttonTitle: "Continue",
                  )
                ],
              ),
              const _AddProductsPage(),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //   child: Flex(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     direction: !Responsive.isMobile(context)
            //         ? Axis.horizontal
            //         : Axis.vertical,
            //     children: [
            //       _Tab(selectedTab: selectedTab, value: "Add Products"),
            //       const SizedBox(width: 24),
            //       _Tab(selectedTab: selectedTab, value: "Customer info"),
            //       const SizedBox(width: 24),
            //       _Tab(selectedTab: selectedTab, value: "Payment"),
            //     ],
            //   ),
            // ),
            SizedBox(
              width: !Responsive.isMobile(context)
                  ? MediaQuery.of(context).size.width - 120
                  : MediaQuery.of(context).size.width,
              child: const Divider(color: Colors.white),
            )
          ],
        ),
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

class _Tab extends StatelessWidget {
  const _Tab({
    Key? key,
    required this.selectedTab,
    required this.value,
  }) : super(key: key);

  final String selectedTab;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 24,
        fontWeight: selectedTab == value ? FontWeight.w700 : FontWeight.w500,
        color: selectedTab == value
            ? const Color(0xffFFFFFF)
            : const Color(0xffB9B7FF),
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
      child: Wrap(
        children: [
          const _ProductCard(
              price: 9000, name: "Hayat", url: "https://hayat.design"),
          const _ProductCard(
              price: 9000, name: "Hayat", url: "https://hayat.design"),
          const _ProductCard(
              price: 9000, name: "Hayat", url: "https://hayat.design"),
          const _ProductCard(
              price: 9000, name: "Hayat", url: "https://hayat.design"),
          const _ProductCard(
              price: 9000, name: "Hayat", url: "https://hayat.design"),
          const _ProductCard(
              price: 9000, name: "Hayat", url: "https://hayat.design"),
          const _ProductCard(
              price: 9000, name: "Hayat", url: "https://hayat.design"),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final int price;
  final String name;
  final String url;
  const _ProductCard({
    Key? key,
    required this.price,
    required this.name,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductController productController = Get.put(ProductController());
    return SizedBox(
      width: Responsive.isDesktop(context)
          ? (MediaQuery.of(context).size.width - 500) / 3
          : Responsive.isTablet(context)
              ? (MediaQuery.of(context).size.width - 500)
              : MediaQuery.of(context).size.width - 8,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image.asset("assets/mi_watch_img.png"),
                    ],
                  ),
                  Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 20),
                  ),
                  Row(
                    children: [
                      const Text(
                        "Price: ",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      Text(
                        "₹" + price.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 20),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Variants: ",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 22),
                        ),
                        Row(
                          children: const [
                            // VariantCircle(),
                            // VariantCircle(),
                            // VariantCircle(),
                          ],
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      if (productController.quantity.value == 0)
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
                      if (productController.quantity.value != 0)
                        Expanded(
                          child: Row(
                            children: [
                              PrimaryButton(
                                buttonTitle: "Add one more",
                                onPressed: () {},
                                iconLeft: const Icon(Iconsax.add_circle),
                                bgColor: const Color(0xffDAEEB8),
                                textColor: const Color(0xff1F212E),
                                iconBgColor: const Color(0xffBEE29B),
                              ),
                              PrimaryButton(
                                onPressed: () {},
                                iconLeft: const Icon(Iconsax.trash),
                                bgColor: const Color(0xffDAEEB8),
                                textColor: const Color(0xff1F212E),
                                iconBgColor: const Color(0xffBEE29B),
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
          Container(
            margin: const EdgeInsets.all(24),
            decoration: BoxDecoration(
                color: const Color(0xff0C0D16),
                borderRadius: BorderRadius.circular(16)),
            child: IconButton(
              padding: const EdgeInsets.all(16),
              onPressed: () {
                _launchUrl(url);
              },
              icon: const Icon(Iconsax.export_3),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _launchUrl(url) async {
  final Uri _url = Uri.parse(url);
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}

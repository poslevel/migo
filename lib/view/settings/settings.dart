import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/view/layout/layout.dart';
import 'package:migo/view/responsive.dart';
import 'package:migo/view/settings/help_and_support.dart';
import 'package:migo/view/settings/profile_settings.dart';
import 'package:migo/widgets/buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class Vendor {
  Vendor(this.name, this.email);

  final String name;
  final String email;
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController fullnameController =
      TextEditingController(text: "Hayat");

  static List<Tab> adminTabs = <Tab>[
    Tab(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: const [
          Icon(
            Iconsax.user,
            size: 20,
          ),
          Text("Profile settings"),
        ],
      ),
    )),
    Tab(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: const [
          Icon(
            Iconsax.people,
            size: 20,
          ),
          Text("Store vendors"),
        ],
      ),
    )),
    Tab(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: const [
          Icon(
            Iconsax.message_question,
            size: 20,
          ),
          Text("Help & support"),
        ],
      ),
    )),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeTab: 5,
      pageName: "settings".tr,
      content: SizedBox(
        width: !Responsive.isMobile(context)
            ? MediaQuery.of(context).size.width - 120
            : MediaQuery.of(context).size.width,
        child: Scaffold(
          appBar: TabBar(
            controller: _tabController,
            unselectedLabelColor: Colors.white,
            isScrollable: true,
            tabs: adminTabs,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xffB9B7FF),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              ProfileSettings(fullnameController: fullnameController),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 300,
                      child: PrimaryButton(
                        onPressed: () {
                          launchUrl(Uri.parse(
                              "https://backpos.herokuapp.com/admin/accounts/user/add/"));
                        },
                        buttonTitle: "Register a new vendor",
                        iconLeft: const Icon(Iconsax.user_add),
                        bgColor: const Color(0xffDAEEB8),
                        textColor: const Color(0xff1F212E),
                        iconBgColor: const Color(0xffBEE29B),
                      ),
                    )
                    // EasyTable<Vendor>(_model),
                  ],
                ),
              ),
              const HelpAndSupport(),
            ],
          ),
        ),
      ),
    );
  }
}

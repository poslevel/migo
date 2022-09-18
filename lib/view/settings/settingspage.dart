import 'package:easy_table/easy_table.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/layout/layout.dart';
import 'package:migo/utils/functions.dart';
import 'package:migo/view/responsive.dart';
import 'package:migo/widgets/buttons.dart';

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
  EasyTableModel<Vendor>? _model;

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
    List<Vendor> rows = [
      Vendor('Landon', "Landon@backpos.com"),
      Vendor('Chaman', "Chaman@backpos.com"),
      Vendor('Vijay', "Vijay@backpos.com"),
      Vendor('Ajay', "Ajay@backpos.com"),
      Vendor('Atul', "Atul@backpos.com"),
    ];
    _model = EasyTableModel<Vendor>(rows: rows, columns: [
      EasyTableColumn(name: 'Name', stringValue: (row) => row.name),
      EasyTableColumn(name: 'Email', stringValue: (row) => row.email),
    ]);
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
      pageName: "Settings",
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
              Column(
                children: [
                  const SizedBox(height: 24),
                  SizedBox(
                    width: 315,
                    child: TextField(
                      controller: fullnameController,
                      decoration: const InputDecoration(
                        label: Text("Full Name"),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: 315,
                    child: PrimaryButton(
                      onPressed: () {
                        Functions.launchURL("https://www.mi.com/in/service/");
                      },
                      buttonTitle: "Change your name",
                    ),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: 315,
                    child: PrimaryButton(
                      onPressed: () {
                        Functions.launchURL("https://www.mi.com/in/service/");
                      },
                      buttonTitle: "Change password",
                      iconRight: Icon(Iconsax.export_3),
                      vertPad: 24,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 315,
                child: EasyTable<Vendor>(_model),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 315,
                    child: PrimaryButton(
                      onPressed: () {
                        Functions.launchURL("https://www.mi.com/in/service/");
                      },
                      buttonTitle: "Reach Mi Help and support service",
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

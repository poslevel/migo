import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/layout/layout.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppLayout(
        activeTab: 5,
        pageName: "Settings",
        content: Row(
          children: [
            InkWell(
              onTap: () {},
              child: Card(
                child: Column(
                  children: const [
                    Text("Settings page"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
